<template>
  <vue3-autocounter 
    class="counter"
    ref="counter"
    :startAmount='from'
    :endAmount='to'
    :duration='duration'
    separator=','
    decimalSeparator='.'
    :decimals='decimals'
    :autoinit='true'
    />
</template>

<script>

import Vue3Autocounter from 'vue3-autocounter';

export default {
  name: 'Counter',
  data() {
      return {
          from: 0,
          duration: 3,
          lastUpdate: 0
      }
  },
  props: ['to', 'decimals'],
  components: {
    'vue3-autocounter': Vue3Autocounter
  },
  watch: {
    to(value, oldValue) {
      this.from = oldValue
      const diff = (Date.now()-this.lastUpdate)*0.001
      if (diff < 30 && diff > 3) this.duration = parseInt((Date.now()-this.lastUpdate)*0.001)
      else this.duration = 3
      this.lastUpdate = Date.now()
      this.$refs.counter.start()
    }
  }
}
</script>