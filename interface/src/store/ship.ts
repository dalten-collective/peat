import airlock from "../api";

import {
  AgentSubscription,
} from "@/types";

export default {
  namespaced: true,
  state() {
    return {
      subscriptions: [] as Array<AgentSubscription>,
    };
  },

  getters: {
    agentSubscriptions(state): Array<AgentSubscription> | [] {
      return state.subscriptions
    },
  },

  mutations: {
    addSubscription(state, payload: AgentSubscription) {
      state.subscriptions.push(payload);
    },

    unsetSubscription(state, subscription: AgentSubscription) {
      const sub = state.subscriptions.find((s) => s === subscription);
      state.subscriptions = state.subscriptions.filter((s) => s != sub);
    },
  },

  actions: {
    openAirlockToAgent({ dispatch }, agentName: string) {
      airlock.openAirlockTo(
        agentName,
        (data) => {
          if ('known' in data) {
            dispatch("peat/setKnown", data.known, { root: true })
          }
          if ('saved' in data) {
            dispatch("peat/setSaved", data.saved, { root: true })
          }
          if ('status' in data) {
            console.log('status: ', data)
          }
        },
        (subscriptionNumber: number) => {
          dispatch("addSubscription", {
            agentName,
            subscriptionNumber,
          } as AgentSubscription);
        }
      );
    },

    removeSubscription({ commit }, subscription: AgentSubscription) {
      commit("unsetSubscription", subscription);
    },

    addSubscription({ state, commit, dispatch }, payload: AgentSubscription) {
      const existing:
        | Array<AgentSubscription>
        | [] = state.subscriptions.filter((s: AgentSubscription) => {
        return s.agentName === payload.agentName;
      });
      existing.forEach((sub) => {
        dispatch("removeSubscription", sub);
      });
      commit("addSubscription", payload);
    },

    closeAgentAirlocks({ commit, getters }) {
      const agentSubscriptions: Array<AgentSubscription> | [] =
        getters.agentSubscriptions;
      agentSubscriptions.forEach((sub) => {
        airlock.closeAirlock(sub.subscriptionNumber, [
          commit("unsetSubscription", sub),
        ]);
      });
    },
  },
};
