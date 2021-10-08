<template>
  <div>
    <AccountWidget :account="account" />
    <div v-if="!isLoading" class="container">
      <h2>{{asteroidName}}</h2>
      <div class="asteroid-details small">
        <div class="details-item">Total Supply:</div>
        <div class="details-item"><CounterWidget :decimals="6" :to="displayTotalSupply"/> {{symbolToken}}</div>
        <div class="details-item">Maximum Flow:</div>
        <div class="details-item">{{maxFlowInHours}} <DaiIcon/>/hour</div>
      </div>
      <AsteroidAnimation :percentage="displayCurrentSupply">
        <ShipAnimation ref="ship" :mining="isMining" :ready="isReady" />
        <OtherShipAnimation v-for="(c, idx) in otherMiners" :key="idx"  :rot="idx*-70+30" />
      </AsteroidAnimation>
      <div class="asteroid-details">
        <div></div>
        <div class="details-item big" ref="tokens"><CounterWidget :decimals="6" :to="displayBalanceToken"/> {{symbolToken}}</div>
      </div>
      <div class="asteroid-details">
        <div></div>
        <div class="details-item">
          <DaiIcon/> <CounterWidget :decimals="6" :to="displayBalanceDAIx"/>
        </div>
      </div>
      <ShipParticle 
        v-for="p in particles"
        :key="p.index"
        :target="p.target"
        :origin="p.origin"
        :killMe="removeParticle"
      />
      <div>
        <button v-if="balanceDAIx > 0 && !isMining" @click="startMining">Start Mining</button>
        <button v-if="isMining" @click="stopMining">Stop Mining</button>
        <button v-if="isCreator" @click="withdrawDAIx">Withdraw DAIx</button>
      </div>
    </div>
    <h2 v-if="isLoading" class="loading">Locating asteroid at <div class="small">{{$route.params.asteroid}}</div></h2>
    <h3>Instructions</h3>
    <p class="descriptions small steps">
      <b>1:</b> Wrap some DAI to DAIx at <a href="https://app.superfluid.finance" target="_blank">Superfluid Dashpanel</a> as energy source.<br/>
      <b>2:</b> Start mining spending your DAIx to fetch tokens.<br/>
      <b>3:</b> Stop mining anytime you want. Resources tokens is already in your wallet.<br/>
      <b>4:</b> In case you are the Asteroid creator, just click Withdraw to move all xDAI contained in the asteroid to your wallet..<br/>
    </p>
  </div>
</template>

<script>
import {BigNumber} from '@ethersproject/bignumber'
import {ethers} from 'ethers'
import AsteroidStream from '../contracts/AsteroidStream.js'
import SuperToken from '../contracts/SuperToken.js'

import DaiIcon from '../components/DaiIcon.vue'
import AsteroidAnimation from '../components/AsteroidAnimation.vue'
import ShipAnimation from '../components/ShipAnimation.vue'
import OtherShipAnimation from '../components/OtherShipAnimation.vue'
import ShipParticle from '../components/ShipParticle.vue'
import AccountWidget from '../components/AccountWidget.vue'
import CounterWidget from '../components/CounterWidget.vue'

export default {
  name: 'Asteroid',
  data() {
    return {
      particlesCount:0,
      particlesMax: 500,
      particles: [],
      isLoading: true,
      isMining: false,
      isReady: false,
      isCreator: false,
      asteroidName: '',
      asteroidCreator: undefined,
      totalSupply: BigNumber.from(0),
      currentSupply: BigNumber.from(0),
      maxFlow: BigNumber.from(0),
      balanceDAIx: BigNumber.from(0),
      balanceDAIDeposited: BigNumber.from(0),
      balanceToken: BigNumber.from(0),
      symbolToken: undefined,
      cAsteroid: undefined,
      cToken: undefined,
      cDAIx: undefined,
      updateInterval: undefined,
      particleInterval: undefined,
      otherMiners: []
    }
  },
  components: {
    AsteroidAnimation,
    ShipAnimation,
    OtherShipAnimation,
    ShipParticle,
    AccountWidget,
    CounterWidget,
    DaiIcon
  },
  props: ['account', 'signer', 'provider', 'user', 'sf'],
  mounted() {
    setTimeout( async () => {
      this.cAsteroid = new ethers.Contract(this.$route.params.asteroid, AsteroidStream.abi, this.signer)
      this.cDAIx = new ethers.Contract(SuperToken.addresses[this.sf.networkType].daix, SuperToken.abi, this.signer)
      this.asteroidName = await this.cAsteroid.name()
      this.maxFlow = await this.cAsteroid.maxFlow()
      console.log(this.maxFlow.toString())
      this.asteroidCreator = await this.cAsteroid.creator()
      const superTokenAddress = await this.cAsteroid.superToken2()
      this.cToken = new ethers.Contract(superTokenAddress, SuperToken.abi, this.signer)
      this.balanceToken = await this.cToken.balanceOf(this.account)
      this.currentSupply = await this.cToken.balanceOf(this.$route.params.asteroid)
      this.symbolToken = await this.cToken.symbol()
      this.totalSupply = await this.cToken.totalSupply()
      this.balanceDAIx = await this.cDAIx.balanceOf(this.account)
      const details = await this.user.details();
      this.checkFlows()
      this.balanceDAIDeposited = details.cfa.flows.outFlows.reduce( (acc, flow) => {
         return acc.add(BigNumber.from(flow.flowRate.toString()).mul(60).mul(60))
      }, BigNumber.from(0))
      console.log(details)
      const asteroidUser = await this.sf.user({
        address: this.$route.params.asteroid,
        token: SuperToken.addresses[this.sf.networkType].daix
      });
      this.isLoading = false
      const astrodetails = await asteroidUser.details();
      console.log(asteroidUser, astrodetails )
      this.otherMiners = astrodetails.cfa.flows.inFlows.reduce( (acc, flow) => {
        if (flow.sender == this.account) return acc
        return acc.concat([1])
      }, [])
      if (this.asteroidCreator == this.account) this.isCreator = true
      if (!this.updateInterval) this.updateInterval = setInterval(this.updateBalances, 3000)
      if (this.balanceDAIx.gt(0)) this.isReady = true
      else this.isReady = false
    },500)
  },
  computed: {
    maxFlowInHours() {
      return parseFloat(ethers.utils.formatEther(this.maxFlow.mul(60).mul(60))).toFixed(6)
    },
    displayTotalSupply() {
      return parseFloat(ethers.utils.formatEther(this.totalSupply))
    },
    displayCurrentSupply() {
      return parseInt(this.currentSupply.mul(100).div(this.totalSupply).toString())
    },
    displayBalanceToken() {
      return parseFloat(ethers.utils.formatEther(this.balanceToken))
    },
    displayBalanceDAIx() { 
      return parseFloat(ethers.utils.formatEther(this.balanceDAIx.add(this.balanceDAIDeposited)))
    }
  },
  methods: {
    async startMining() {
      await this.user.flow({
        recipient: this.cAsteroid.address,
        flowRate: this.maxFlow.mul(10).toString()
      });
      if (!this.updateInterval) this.updateInterval = setInterval(this.updateBalances, 3000)
    },
    async stopMining() {
      await this.user.flow({
        recipient: this.cAsteroid.address,
        flowRate: '0'
      });
    },
    async withdrawDAIx() {
      await this.cAsteroid.withdrawDAI()
    },
    async checkFlows() {
      const details = await this.user.details();
      const flows = details.cfa.flows.outFlows.filter( (f) => { return f.receiver.toLowerCase() == this.$route.params.asteroid.toLowerCase() })
      this.balanceDAIDeposited = details.cfa.flows.outFlows.reduce( (acc, flow) => {
         return acc.add(BigNumber.from(flow.flowRate.toString()).mul(60).mul(60))
      }, BigNumber.from(0))
      if (flows.length > 0) {
        this.isMining = true
        this.startParticleInterval()
      } else {
        this.isMining = false
        this.dropParticleInterval()
      }
    },
    async updateBalances() {
      this.checkFlows()
      this.balanceToken = await this.cToken.balanceOf(this.account)
      this.currentSupply = await this.cToken.balanceOf(this.$route.params.asteroid)
      this.balanceDAIx = await this.cDAIx.balanceOf(this.account)
      if (this.balanceDAIx.gt(0)) this.isReady = true
      else this.isReady = false
    },
    startParticleInterval() {
      if (!this.particleInterval)
        this.particleInterval = setInterval(this.spawnParticle, 100)
    },
    dropParticleInterval() {
      if (this.particleInterval) { clearInterval(this.particleInterval) }
      this.particleInterval = undefined
    },
    spawnParticle() {
      this.particles.push({
        target: this.$refs.ship.$el.children[0].getBoundingClientRect(),
        origin: this.$refs.tokens.getBoundingClientRect(),
        index: this.particlesCount
      })
      this.particlesCount = (this.particlesCount+1)%this.particlesMax
    },
    removeParticle() {
      this.particles.shift();
    },
  },
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
.container {
  display: flex;
  justify-content: center;
  flex-direction: column;
  align-items: center;
}
.loading {
  margin: 128px 16px;
}
.asteroid-details {
  font-family: 'Share Tech Mono', monospace;
  width: 100%;
  display: flex;
  flex-wrap: wrap;
  flex-direction: row;
  justify-content: center;
}
.big {
  font-size: 1.4rem;
}
button {
  margin: 16px;
}
.details-item {
  min-width:100px;
  margin: 0px 16px;
}
.details-item:nth-child(even),
 {
  text-align: right;
}
.details-item:nth-child(odd) {
  text-align: left;
}
.steps {
  text-align: left;
  max-width: 400px;
  margin: 16px auto;
}
</style>
