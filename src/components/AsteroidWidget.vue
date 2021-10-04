<template>
  <div class="modal-container">
    <div class="modal-container" @click="close"> </div>
    <transition name="fade">
        <div v-if="show" class="modal" >
          <div v-if="!isLoading">
            <div class="small">How will be your token?</div>
            <input v-model="name" placeholder="Token Name" />
            <input v-model="symbol" placeholder="Token Symbol" />
            <input v-model="supply" placeholder="Total Supply" />
            <div class="small">How will be your Asteroid?</div>
            <input v-model="asteroid" placeholder="Asteroid Name" />
            <div class="small">What will be the max flow per day:</div>
            <input v-model="maxFlow" placeholder="Max Flow / Sec"/>
            <p v-if="maxFlow" class="small">With the flow selected a single miner depletes the {{supply}} {{symbol}} in:</p>
            <p v-if="maxFlow" class="small">{{minutes}} minutes or {{hours}} hours or {{days}} days.</p>
            <button v-if="maxFlow" @click="createAsteroid">Create Asteroid</button>
          </div>
          <div v-if="isLoading">
            <div>Deploying Asteroid...</div>
          </div>
        </div>
    </transition>
  </div>
</template>

<script>
import {BigNumber} from '@ethersproject/bignumber'
import {ethers} from 'ethers'

export default {
  name: 'AsteroidWidget',
  data() {
      return {
        isLoading:false,
        show:false,
        name:"",
        symbol:"",
        supply:0,
        bigSupply: BigNumber.from('0'),
        asteroid:'',
        maxFlow: '1',
        bigFlow: BigNumber.from(ethers.utils.parseEther('1')).div('60').div('60').div('24'),
        minutes: 0,
        hours: 0,
        days: 0,
      }
  },
  props: {
      toggleVisibility: Function,
      deployAsteroid: Function
  },
  watch: {
    maxFlow(value) {
      try {
        this.bigFlow = BigNumber.from(ethers.utils.parseEther(value)).div('60').div('60').div('24')
        this.recalculatePeriods()
      } catch (err) {
        //console.log(err)
      }
    },
    supply(value) {
      try {
        this.bigSupply = BigNumber.from(ethers.utils.parseEther(value))
        this.recalculatePeriods()
      } catch (err) {
        //console.log(err)
      }
    }
  },
  mounted() {
      this.show=true
      console.log(this.tokenInfo)
  },
  methods: {
      close() {
          this.show=false
          setTimeout(() => { this.toggleVisibility() }, 300)
      },
      recalculatePeriods() {
        this.minutes = this.bigSupply.div(this.bigFlow.mul('60')).toString()
        this.hours = this.bigSupply.div(this.bigFlow.mul('60').mul('60')).toString()
        this.days = this.bigSupply.div(this.bigFlow.mul('60').mul('60').mul('24')).toString()
      },
      createAsteroid() {
          this.isLoading = true
          this.deployAsteroid(
            this.name,
            this.symbol,
            this.bigSupply,
            this.asteroid,
            this.bigFlow
          )
      }
  },
}
</script>
