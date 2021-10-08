<template>
    <div :style="holderStyle">
        <div class="shipHolder ready">
            <img class="shipAnimation mining" src="../assets/shipOther.png"/>
        </div>
    </div>
</template>

<script>
export default {
  name: 'OtherShipAnimation',
  props: ['rot'],
  methods: {
      holderStyle() {
          return { transform:`rotate(${this.rot}deg);` }
      }
  },
}
</script>

<style scoped>
@keyframes spin {
    0% { 
        -webkit-transform: rotate(360deg); 
        transform:rotate(360deg);
    } 
    100% { 
        -webkit-transform: rotate(0deg); 
        transform:rotate(0deg); 
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
    animation:mining 2s ease-out infinite;
}
</style>
