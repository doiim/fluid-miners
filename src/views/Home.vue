<template>
  <div class="container">
    <div v-if="showTokenModal"><TokenWidget :toggleVisibility="toggleToken" :save="saveTokenData" /></div>
    <div v-if="showAsteroidModal"><AsteroidWidget :toggleVisibility="toggleAsteroid" :tokenInfo="token" :save="saveAsteroidData"/></div>
    <img class="logo" alt="Fluid Miners Logo" src="../assets/logo.png">
    <h1>Fluid Miners</h1>
    <p class="descriptions">
      Create your own Super Token then fill a mineable asteroid with it. The DAI token is used as energy to drill the asteroid.
      A maximum constant flow is used to allow multiple miners on same asteroid, once the token resource is depleted, mining stops automaticaly.
    </p>
    <h3>1st : Configure your own Super Token</h3>
    <p class="descriptions">
      Choose your Super Token properties to serve as a resource inside asteroids.
    </p>
    <button @click="toggleToken">Let's do This!</button>
    <h3>2nd : Create your Asteroid</h3>
    <p class="descriptions">
      Asteroids allow your token to be mined by other users. You can use this to fund some project, or define a line to receive some prize.
    </p>
    <button :disabled="token == undefined" @click="toggleAsteroid">Create Asteroid</button>
    <button @click="goToAsteroid">Go to Asteroid</button>
    <h3>About</h3>
    <p class="descriptions">
      This project is developed for <a href="https://github.com/filipesoccol">Filipe Soccol</a> for <a href="https://online.ethglobal.com">ETHGlobal 2021</a>. The full source code is available at <a href="https://github.com/doiim/fluid-miners">Github repo</a>.
    </p>
    <h3>Powered by</h3>
    <ul>
      <li><a href="https://makerdao.io"><img class="powered" src="../assets/dai.png" alt="Dai"/></a></li>
      <li><a href="https://superfluid.finance"><img class="powered" src="../assets/superfluid.png" alt="Superfluid"/></a></li>
      <li><a href="https://doiim.com"><img class="powered" src="../assets/doiim.png" alt="Doiim"/></a></li>
    </ul>
  </div>
</template>

<script>
 import TokenWidget from '../components/TokenWidget.vue'
 import AsteroidWidget from '../components/AsteroidWidget.vue'

export default {
  name: 'Home',
  data() {
    return {
      showTokenModal: false,
      showAsteroidModal: false,
      token: undefined,
      asteroid: {}
    }
  },
  components: {
    AsteroidWidget,
    TokenWidget
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
    saveAsteroidData(asteroid) {
      this.asteroid = asteroid
    },
    goToAsteroid() {
      this.$router.push('/asdasdasasdasdd')
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
h1 {
  font-size: 3rem;
}
h3 {
  margin: 40px 0 0;
}
ul {
  list-style-type: none;
  padding: 0;
}
li {
  display: inline-block;
  margin: 0 10px;
}
.descriptions {
  max-width: 640px;
}
.powered {
  height: 32px;
}
</style>
