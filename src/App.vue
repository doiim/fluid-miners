<template>
  <img class="logo" alt="Fluid Miners Logo" src="./assets/logo.png">
  <Home/>
</template>

<script>
import Home from './components/Home.vue'

export default {
  name: 'App',
  components: {
    Home
  }
}
</script>

<style>

@import url('https://fonts.googleapis.com/css2?family=Sarpanch:wght@400;700;900&display=swap');

@-webkit-keyframes move-background {
	from {
		background-position: 0px 0px
	}
	to { 
		background-position: -600px 0px
	}
}

body {
  background: url('./assets/background.png');
  -webkit-animation-name: move-background;
	-webkit-animation-duration: 20s;
	-webkit-animation-timing-function: linear;
	-webkit-animation-iteration-count: infinite;
}

#app {
  font-family: Sarpanch, Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #EBEBEB;
  margin-top: 60px;
}

.logo {
  width: 250px;
}
</style>
