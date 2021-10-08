<template>
  <div class="circle" :style="{top: this.origintop+'px', left: this.originleft+'px', transform: transform}"></div>
</template>

<script>
  export default {
    name: 'ShipParticle',
    data () {
      return {
        top: 0,
        left: 0,
        origintop: 0,
        originLeft: 0,
        transform: 'translate3d(0, 0, 0px)'
      }
    },
    props: ['origin','target','killMe'],
    mounted () {
      this.update()
      setTimeout( () => {
        // remove the element from the DOM
        this.killMe();
      }, 1000);
    },
    methods : {
      update: function() {
        this.origintop = this.origin.top+(this.origin.bottom-this.origin.top)/2
        this.originleft = this.origin.left+(this.origin.right-this.origin.left)/2
        this.top = this.target.top+(this.target.bottom-this.target.top)/2
        this.left = this.target.left+(this.target.right-this.target.left)/2
        this.transform = 'translate3d('+(this.left-this.originleft)+'px, '+(this.top-this.origintop)+'px, 0px)';
      }
    }
  }
</script>

<style scoped>
.circle {
  position: absolute;
  opacity: 0;
  border-radius: 50%;
  animation: follow 0.5s ease-out;
  background-color: #EBEBEB;
  width: 10px;
  height: 10px;
  animation-iteration-count: 1;
}
@keyframes follow {
  1% {
    opacity: 1;
  }
  100% {
    transform: translate3d(0, 0, 0px);
    opacity: 1;
  }
}
</style>