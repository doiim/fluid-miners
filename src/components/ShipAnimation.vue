<template>
    <div :class="{shipHolder:true, ready}">
        <img :class="{ shipAnimation:true, idle, mining}" src="../assets/ship.png"/>
    </div>
</template>

<script>
export default {
  name: 'ShipAnimation',
  data() {
      return {
          idle: false
      }
  },
  props: ['mining', 'ready'],
  mounted() {
      setTimeout( () => { this.idle = true }, 500)
  }
}
</script>

<style scoped>
@keyframes spin {
    0% { 
        -webkit-transform: rotate(0deg); 
        transform:rotate(0deg);
    } 
    100% { 
        -webkit-transform: rotate(360deg); 
        transform:rotate(360deg); 
    } 
}

@keyframes mining { 
    0% { transform: translate(0px, -100px); }
    50% { transform: translate(0px, -200px); } 
    100% { transform: translate(0px, -100px); } 
}

.shipHolder {
    -webkit-transform: rotate(45deg); 
    transform:rotate(45deg); 
    position: absolute; 
    left: 270px;
    top: 250px;
    transition: all 2s ease-out;
}
.shipHolder.ready {
    animation:spin 20s linear infinite;
}

.shipAnimation {
    position: absolute;
    left: -40px;
    transform: translate(0px, -1000px);
    transition: all 2s ease-out;
}
.shipAnimation.idle { transform: translate(0px, -350px); }
.shipAnimation.mining {
    animation:mining 2s ease-out infinite;
}
</style>
