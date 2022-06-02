import airlock from "../api";

import {
  Saved,
  Given,
  Doled,
  Known,
} from "@/types";

export default {
  namespaced: true,
  state() {
    return {
      saved: [] as Array<Saved>,
      given: [] as Array<Given>,
      doled: [] as Array<Doled>,
      known: [] as Array<Known>,
    };
  },

  getters: {
  },

  mutations: {
    setKnown(state, payload: Array<Known>) {
      state.known = payload;
    },
    setSaved(state, payload: Array<Saved>) {
      state.saved = payload;
    },
  },

  actions: {
    setKnown({ commit }, payload: Array<Known>) {
      commit("setKnown", payload);
    },
    setSaved({ commit }, payload: Array<Saved>) {
      commit("setSaved", payload);
    },
  },
};
