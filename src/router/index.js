import { createWebHashHistory, createRouter } from "vue-router";
import {ethers} from 'ethers'
import SuperFluid from '@superfluid-finance/js-sdk'
const { Web3Provider } = require("@ethersproject/providers");

import Home from "../views/Home.vue";
import Asteroid from "../views/Asteroid.vue";

import SuperToken from '../contracts/SuperToken';


let provider;
let signer;
let account;
let user;
let sf;

const routes = [
  {
    path: "/",
    name: "Home",
    component: Home,
    props: () => { return {provider, signer, account, user, sf} }
  },
  {
    path: "/:asteroid",
    name: "Asteroid",
    component: Asteroid,
    props: () => { return {provider, signer, account, user, sf} }
  },
];

const router = createRouter({
  history: createWebHashHistory(),
  routes,
});

router.beforeEach( async () => {
  try {
    await window.ethereum.enable()
    const providerSF = new Web3Provider(window.ethereum)
    provider = new ethers.providers.Web3Provider(window.ethereum);
    signer = await provider.getSigner();
    account = await signer.getAddress();
    sf = new SuperFluid.Framework({ ethers: providerSF });
    await sf.initialize()
    user = await sf.user({
      address: account,
      token: SuperToken.addresses[sf.networkType].daix
    });
  } catch (err) {
    console.log('Wallet not connected', err)
  }
  return true
})

export default router;