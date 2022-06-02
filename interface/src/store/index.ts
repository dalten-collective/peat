import { createStore as createVuexStore } from "vuex";

import ship from "./ship";
import peat from "./peat";

export const createStore = () => {
  return createVuexStore({
    modules: {
      ship,
      peat
    },
  });
};
