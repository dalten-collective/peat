import airlock from "../api";

import {
  Known,
} from "@/types";

export default {
  namespaced: true,
  state() {
    return {
      known: [] as Array<Known>,
    };
  },

  getters: {
  },

  mutations: {
    setKnown(state, payload: Array<Known>) {
      state.known.push(payload);
    },
  },

  actions: {
    setKnown({ commit }, payload: Array<Known>) {
      commit("setKnown", payload);
    },
  },
};
