<template>
  <div class="modal-container">
    <div class="modal-container" @click="close"> </div>
    <transition name="fade">
        <div v-if="show" class="modal" >
            How will be your token?
            <input v-model="name" placeholder="Token Name" />
            <input v-model="symbol" placeholder="Token Symbol" />
            <input v-model="supply" placeholder="Total Supply" />
            <button @click="createToken">Create Token</button>
        </div>
    </transition>
  </div>
</template>

<script>

export default {
  name: 'TokenWidget',
  data() {
      return {
        show:false,
        name:"",
        symbol:"",
        supply:0,
      }
  },
  props: {
      toggleVisibility: Function,
      save: Function
  },
  mounted() {
      this.show=true
  },
  methods: {
      close() {
          this.show=false
          setTimeout(() => { this.toggleVisibility() }, 300)
      },
      createToken() {
          console.log(this.name, this.symbol, this.supply)
          this.save({
              name: this.name,
              symbol: this.symbol,
              supply: this.supply
          })
          this.close()
      }
  },
}
</script>
