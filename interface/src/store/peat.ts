// import airlockAPI from "@/api";
import peatAPI from "@/api";
import { scryHav } from "@/api/peat";

import {
  Saved,
  Given,
  Doled,
  Known,
  Hav,
  HavResponse,
  HavResource,
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
    havChats(state): Array<HavResource> {
      const chats = state.hav.find((h: Hav) => h.shape === 'chat');
      if (chats && chats.hasOwnProperty("resources")) {
        return chats.resources
      } else {
        return [];
      }
    },

    havLinks(state) {
      const links = state.hav.find((h: Hav) => h.shape === 'link');
      if (links && links.hasOwnProperty("resources")) {
        return links.resources
      } else {
        return [];
      }
    },

    havPublishes(state) {
      const pubs = state.hav.find((h: Hav) => h.shape === 'publish');
      if (pubs && pubs.hasOwnProperty("resources")) {
        return pubs.resources
      } else {
        return [];
      }
    },
    havDms(state) {
      const dms = state.hav.find((h: Hav) => h.shape === 'dm');
      if (dms && dms.hasOwnProperty("resources")) {
        return dms.resources
      } else {
        return [];
      }
    },
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
          commit("setHav", havs.available); // TODO: Careful callling available
          return havs.available;
        }).catch(err => {
          throw err.response
        })
    }
  },
};
