<template>
  <div class="account" v-if="account">
  {{account.substring(0,6)}}...{{account.substring(account.length-4, account.length)}}
  </div>
</template>

<script>

export default {
  name: 'App',
  props: {
      account: String
  }
}
</script>

<style scoped>
.account {
    font-family: Avenir, Helvetica, Arial, sans-serif;
    position: absolute;
    top: 20px;
    right: 20px;
}
</style>
