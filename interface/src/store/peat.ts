// import airlockAPI from "@/api";
import peatAPI from "@/api";

import {
  Saved,
  Given,
  Doled,
  Known,
  Hav,
  HavResponse,
} from "@/types";

export default {
  namespaced: true,
  state() {
    return {
      saved: [] as Array<Saved>,
      given: [] as Array<Given>,
      doled: [] as Array<Doled>,
      known: [] as Array<Known>,
      hav: [] as Array<Hav>,
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
    setHav(state, payload: Array<Hav>) {
      state.hav = payload;
    },
  },

  actions: {
    setKnown({ commit }, payload: Array<Known>) {
      commit("setKnown", payload);
    },
    setSaved({ commit }, payload: Array<Saved>) {
      commit("setSaved", payload);
    },
    getHav({ commit }) {
      return peatAPI.scryHav()
        .then((havs: HavResponse) => {
          commit("setHav", havs);
          return havs;
        }).catch(err => {
          throw err.response
        })
    }
  },
};
