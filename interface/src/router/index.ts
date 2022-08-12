import { createRouter, createWebHistory, createWebHashHistory, RouteRecordRaw } from "vue-router";
import Learn from "../views/Learn.vue";
import Work from "../views/Work.vue";

const routes: Array<RouteRecordRaw> = [
  {
    path: "/",
    name: "work",
    component: Work,
  },
  {
    path: "/learn",
    name: "learn",
    component: Learn,
  },
  //{
  //path: "/about",
  //name: "about",
  //// route level code-splitting
  //// this generates a separate chunk (about.[hash].js) for this route
  //// which is lazy-loaded when the route is visited.
  //component: () =>
  //import([> webpackChunkName: "about" <] "../views/AboutView.vue"),
  //},
];

const router = createRouter({
  history: createWebHistory("/apps/peat/"),
  routes,
});

export default router;
