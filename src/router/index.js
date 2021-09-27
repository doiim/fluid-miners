import { createWebHashHistory, createRouter } from "vue-router";
import Home from "../views/Home.vue";
import Asteroid from "../views/Asteroid.vue";

const routes = [
  {
    path: "/",
    name: "Home",
    component: Home,
  },
  {
    path: "/:asteroid",
    name: "Asteroid",
    component: Asteroid,
  },
];

const router = createRouter({
  history: createWebHashHistory(),
  routes,
});

export default router;