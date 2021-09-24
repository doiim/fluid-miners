<template>
  <div class="modal-container">
    <div class="modal-container" @click="close"> </div>
    <transition name="fade">
        <div v-if="show" class="modal" >
            How will be your Asteroid?
            <input v-model="name" placeholder="Asteroid Name" />
            <p>What will be the max flow per second:</p>
            <input v-model="maxFlow" placeholder="Max Flow / Sec"/>
            <p v-if="maxFlow">With the flow selected a single miner depletes the {{tokenInfo.supply}} {{tokenInfo.symbol}} in:</p>
            <h3 v-if="maxFlow">{{minutes}} hours</h3>
            <h3 v-if="maxFlow">or {{hours}} days</h3>
            <h3 v-if="maxFlow">or {{days}} months</h3>
            <button v-if="maxFlow" @click="createToken">Create Asteroid</button>
        </div>
    </transition>
  </div>
</template>

<script>

export default {
  name: 'AsteroidWidget',
  data() {
      return {
        show:false,
        name:'',
        maxFlow: '',
        minutes: 0,
        hours: 0,
        days: 0,
      }
  },
  props: {
      toggleVisibility: Function,
      tokenInfo: Object
  },
  watch: {
    maxFlow(value) {
      this.minutes = (parseFloat(this.tokenInfo.supply)/(parseFloat(value)*60)).toFixed(2)
      this.hours = (parseFloat(this.tokenInfo.supply)/(parseFloat(value)*60*60)).toFixed(2)
      this.days = (parseFloat(this.tokenInfo.supply)/(parseFloat(value)*60*60*24)).toFixed(2)
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
      createAsteroid() {
          console.log(this.tokenInfo)
          this.close()
      }
  },
}
</script>
