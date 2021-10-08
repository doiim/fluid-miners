<template>
  <div class="container">
    <AccountWidget :account="account" />
    <div v-if="showAsteroidModal">
      <AsteroidWidget
        :toggleVisibility="toggleAsteroid"
        :deployAsteroid="deployAsteroid"
        :save="saveAsteroidData"
      />
    </div>
    <img class="logo" alt="Fluid Miners Logo" src="../assets/logo.png">
    <h1>Fluid Miners</h1>
    <p class="descriptions">
      Create your own Super Token then fill a mineable asteroid with it. The DAI token is used as energy to drill the asteroid.
      A maximum constant flow is used to allow multiple miners on same asteroid, once the token resource is depleted, mining stops automaticaly.
    </p>
    <h3>Create your Asteroid</h3>
    <p class="descriptions">
      Asteroids allow your token to be mined by other users. You can use this to fund some project, or define a line to receive some prize.
    </p>
    <button @click="toggleAsteroid">Create Asteroid</button>
    <h3>About</h3>
    <p class="descriptions">
      This project is developed by <a href="https://github.com/filipesoccol">Filipe Soccol</a> for <a href="https://online.ethglobal.com">ETHGlobal 2021</a>. The full source code is available at <a href="https://github.com/doiim/fluid-miners">Github repo</a>.
    </p>
  </div>
</template>

<script>
import {ethers} from 'ethers'

import AccountWidget from '../components/AccountWidget.vue'
import AsteroidWidget from '../components/AsteroidWidget.vue'

import FluidMinersFactory from '../contracts/FluidMinersFactory.js'

export default {
  name: 'Home',
  data() {
    return {
      showTokenModal: false,
      showAsteroidModal: false
    }
  },
  props: ['account', 'signer', 'provider', 'user', 'sf'],
  components: {
    AccountWidget,
    AsteroidWidget
  },
  methods: {
    toggleToken() {
      this.showTokenModal =! this.showTokenModal
    },
    saveTokenData(token) {
      this.token = token
    },
    toggleAsteroid() {
      this.showAsteroidModal =! this.showAsteroidModal
    },
    async deployAsteroid(name, symbol, supply, asteroid, maxFlow) {
      const factory = new ethers.Contract(FluidMinersFactory.addresses[this.sf.networkType], FluidMinersFactory.abi, this.signer)
      const tx = await factory.deployAsteroid(supply, maxFlow, asteroid, name, symbol)
      const receipt = await tx.wait();
      this.$router.push(`/${receipt.events[6].args[0]}`)
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
</style>
