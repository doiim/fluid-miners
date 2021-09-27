<template>
  <div class="container">
    <h2>{{$route.params.asteroid}}</h2>
    <AsteroidAnimation/>
  </div>
</template>

<script>

import AsteroidAnimation from '../components/AsteroidAnimation.vue'

export default {
  name: 'Asteroid',
  components: {
    AsteroidAnimation
  },
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
</style>
