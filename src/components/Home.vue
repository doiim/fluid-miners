<template>
  <div class="container">
    <img class="logo" alt="Fluid Miners Logo" src="../assets/logo.png">
    <h1>Fluid Miners</h1>
    <p class="descriptions">
      Create your own Super Token then fill a mineable asteroid with it. The DAI token is used as energy to drill the asteroid.
      A maximum constant flow is used to allow multiple miners on same asteroid, once the token resource is depleted, mining stops automaticaly.
    </p>
    <h3>1st : Create your own Super Token</h3>
    <p class="descriptions">
      Create your own Super Token to serve as a resource inside asteroids.
    </p>
    <button @click="toggleToken">Let's do This!</button>
    <h3>2nd : Create your Asteroid</h3>
    <p class="descriptions">
      Asteroids allow your token to be mined by other users. You can use this to fund some project, or define a line to receive some prize.
    </p>
    <button :disabled="step == 0" @click="toggleAsteroid">Create Asteroid</button>
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
export default {
  name: 'Home',
  props: {
    toggleToken: Function,
    toggleAsteroid: Function,
    step: Number
  }
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
