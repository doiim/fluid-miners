<template>
    <div class="asteroid-holder">
        <img class="asteroid-fixed-center asteroid-drop-shadow" alt="test" src="../assets/asteroid-light.png"/>
        <img class="asteroid-fixed-center" alt="test" src="../assets/asteroid-shadow.png"/>
        <div class="asteroid-fixed-center asteroid-light"></div>
        <div class="asteroid-fixed-center asteroid-shadow"></div>
    </div>
</template>

<script>
export default {
  name: 'AsteroidAnimation'
}
</script>

<style scoped>

@-webkit-keyframes move-background-inverse {
  from {
    background-position: 0px 80px
  }
  to { 
    background-position: 2114px 80px
  }
}

.asteroid-holder {
  position: relative; 
  transform: scale(0.5);
  left: -125px;
}
.asteroid-fixed-center {
  position: absolute;
}
.asteroid-drop-shadow {
  filter: drop-shadow(0 0 5rem #EBEBEB);
}
.asteroid-light {
  width: 540px;
  height: 520px;
  -webkit-mask-image: url("../assets/asteroid-mask-light.png");
  background: url('../assets/cratters-light.png');
  -webkit-animation-name: move-background-inverse;
  -webkit-animation-duration: 20s;
  -webkit-animation-timing-function: linear;
  -webkit-animation-iteration-count: infinite;
}
.asteroid-shadow {
  width: 540px;
  height: 520px;
  -webkit-mask-image: url("../assets/asteroid-mask-dark.png");
  background: url('../assets/cratters-shadow.png');
  -webkit-animation-name: move-background-inverse;
  -webkit-animation-duration: 20s;
  -webkit-animation-timing-function: linear;
  -webkit-animation-iteration-count: infinite;
}
</style>
