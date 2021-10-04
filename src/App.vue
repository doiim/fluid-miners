<template>
  <router-view/>
  <h3>Powered by</h3>
  <ul>
    <li><a href="https://makerdao.io"><img class="powered" src="./assets/dai.png" alt="Dai"/></a></li>
    <li><a href="https://superfluid.finance"><img class="powered" src="./assets/superfluid.png" alt="Superfluid"/></a></li>
    <li><a href="https://doiim.com"><img class="powered" src="./assets/doiim.png" alt="Doiim"/></a></li>
  </ul>
</template>

<script>
  export default {
    name: 'App',
    data: function () {
      return {
        account: undefined,
        signer: undefined,
        provider: undefined,
      }
    }
  }
</script>

<style>

  @import url('https://fonts.googleapis.com/css2?family=Share+Tech+Mono&display=swap');
  @import url('https://fonts.googleapis.com/css2?family=Sarpanch:wght@400;700;900&display=swap');

  @-webkit-keyframes move-background {
    from {
      background-position: 0px 0px
    }
    to { 
      background-position: -600px 0px
    }
  }

  .fade-enter-active,
  .fade-leave-active {
    transition: all 0.3s ease-in-out;
  }

  .fade-enter-from,
  .fade-leave-to {
    transform: scale(0);
  }

  .scale-slide-enter-active,
  .scale-slide-leave-active {
    transition: all 0.5s ease;
  }
  .scale-slide-enter-from {
    transform: translate(-100vw);
  }
  .scale-slide-enter-to,
  .scale-slide-leave-from {
    transform: translate(0px);
  }
  .scale-slide-leave-to {
    transform: translate(100vw);
  }

  html {
    background: #2F181D;
  }

  body {
    overflow-x: clip;
    background: url('./assets/background.png');
    -webkit-animation-name: move-background;
    -webkit-animation-duration: 20s;
    -webkit-animation-timing-function: linear;
    -webkit-animation-iteration-count: infinite;
    min-height: 100vh;
    padding: 0px;
    margin: 0px;
  }

  #app {
    font-family: Sarpanch, Avenir, Helvetica, Arial, sans-serif;
    -webkit-font-smoothing: antialiased;
    -moz-osx-font-smoothing: grayscale;
    text-align: center;
    color: #EBEBEB;
    padding-top: 60px;
  }

  .logo {
    width: 250px;
  }

  button {
    border-radius: 32px;
    padding:16px;
    font-family: inherit;
    font-size: 1rem;
    cursor: pointer;
  }
  input {
    border-radius: 16px;
    border: solid 1px #EBEBEB;
    background: transparent;
    color: #EBEBEB;
    padding:16px;
    margin: 8px;
    font-family: inherit;
    font-size: 1rem;
    cursor: pointer;
    outline:0;
    transition: box-shadow 0.3s;
  }
  input:focus {
    box-shadow: 0px 0px 10px #EBEBEB;
    background: #2F181D;
  }
  .modal-container {
    position: fixed;
    margin: 0px;
    padding: 0px;
    display: flex;
    align-items: center;
    justify-content: center;
    top: 0px;
    left: 0px;
    right: 0px;
    bottom: 0px;
  }
  .modal {
    background: url('./assets/background.png');
    -webkit-animation-name: move-background;
    -webkit-animation-duration: 20s;
    -webkit-animation-timing-function: linear;
    -webkit-animation-iteration-count: infinite;
    filter: drop-shadow(0 0 8rem #EBEBEB);
    border-radius: 32px;
    max-width: 300px;
    transition: all 0.3s;
    padding: 32px;
  }
  a {
    color: #ED6849;
  }
  h1 {
    font-size: 3rem;
  }
  h3 {
    margin: 40px 0 0;
  }
  ul {
    list-style-type: none;
    padding: 0;
  }
  li {
    display: inline-block;
    margin: 0 10px;
  }
  .descriptions {
    max-width: 640px;
    padding: 0px 16px;
  }
  .powered {
    height: 32px;
  }
  .small {
    font-size: 0.8rem;
  }
</style>
