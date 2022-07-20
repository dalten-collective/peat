import { createStore } from "vuex";

import ship from "./ship";
import peat from "./peat";

const store = createStore({
    modules: {
      ship,
      peat
    },
  })

export default store
