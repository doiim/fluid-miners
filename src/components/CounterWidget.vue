<template>
  <vue3-autocounter 
    class="counter"
    ref="counter"
    :startAmount='from'
    :endAmount='to'
    :duration='3'
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
          from: 0
      }
  },
  props: ['reference', 'to', 'decimals'],
  components: {
    'vue3-autocounter': Vue3Autocounter
  },
  watch: {
    to(value, oldValue) {
      this.from = oldValue
      this.$refs.counter.start()
    }
  }
}
</script>