// import airlockAPI from "@/api";
import peatAPI from "@/api";
import { scryHav } from "@/api/peat";

import {
  AdminResponse,
  Saved,
  Given,
  Graph,
  Doled,
  Known,
  Hav,
  HavResponse,
  HavResource,
  KnownResponse,
  SavedResponse,
  Entity,
  ExportFrequency,
  GroupedOptions,
  DolePayload,
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
      admin: [] as Array<Entity>,
    };
  },

  getters: {
    knownGroups(state): Array<string> {
      return Array.from(
        new Set(
          state.known.map((k: Known) => {
            if (k.hasOwnProperty("chat")) {
              if (k.chat.group === GroupedOptions.Ungrouped) {
                return "ungrouped"
              } else {
                return k.chat.group.name
              }

            }
            if (k.hasOwnProperty("link")) {
              if (k.link.group === GroupedOptions.Ungrouped) {
                return "ungrouped"
              } else {
                return k.link.group.name
              }
            }
            if (k.hasOwnProperty("publish")) {
              if (k.publish.group === GroupedOptions.Ungrouped) {
                return "ungrouped"
              } else {
                return k.publish.group.name
              }
            }
          })
        )
      ).filter(g => g) as Array<string> // filter out null
    },

    knownChats(state): Array<Known> {
      return state.known
        .filter((k: Known) => { 
          if (k.hasOwnProperty("chat")) {
            return k.chat
          }
        })
    },

    knownShapeByGroup: (state) => (shape: string, groupName: string | undefined): Array<Entity> => {
      if (groupName && groupName !== '') {
        return state.known
          .filter((k: Known) => { 
            if (k.hasOwnProperty(shape)) {
              return k[shape].group.name === groupName
            }
          }).map(g => g[shape].resources)
      }
      return state.known
        .filter((k: Known) => { 
          if (k.hasOwnProperty("chat")) {
            return k.chat
          }
        }).map(g => g.chat.resources)
    },

    knownChatsByGroup: (state) => (groupName: string | undefined): Array<Entity> => {
      if (groupName && groupName !== '') {
        return state.known
          .filter((k: Known) => { 
            if (k.hasOwnProperty("chat")) {
              return k.chat.group.name === groupName
            }
          }).map(g => g.chat.resources)
      }
      return state.known
        .filter((k: Known) => { 
          if (k.hasOwnProperty("chat")) {
            return k.chat
          }
        }).map(g => g.chat.resources)
    },

    knownLinks(state): Array<Known> {
      return state.known
        .filter((k: Known) => { 
          if (k.hasOwnProperty("link")) {
            return k.link
          }
        })
    },
    knownPublishes(state): Array<Known> {
      return state.known
        .filter((k: Known) => { 
          if (k.hasOwnProperty("publish")) {
            return k.publish
          }
        })
    },

    filterResourcesByGroup: (state, getters) => (groupName: string) => {
      // knownResourcesByGroup find where 0 == name
      if (!groupName || groupName === '') {
        return getters.knownResourcesByGroup
      }
      return getters.knownResourcesByGroup.filter((pair) => {
        return pair[0] === groupName
      })
    },

    knownResourcesByGroup(state, getters):
      Array<
        Array<
          string | { chats: Array<Graph> }
        >
      > {
      return getters.knownGroups.map((groupName) => {
        return [
          groupName,
          {
            chats: getters.knownShapeByGroup('chat', groupName).flat(),
            links: getters.knownShapeByGroup('link', groupName).flat(),
            publishes: getters.knownShapeByGroup('publish', groupName).flat(),
          }
        ]
      })

      //return getters.knownChats.map((k: Known) => {
        //const chat = k.chat as Graph
        //if (chat.group === GroupedOptions.Ungrouped) {
          //return {
            //group: {
              //entity: '~',
              //name: 'ungrouped'
            //},
            //resources: chat.resources as Array<Entity>
          //}
        //} else {
          //return {
            //group: chat.group,
            //resources: chat.resources as Array<Entity>,
          //}
        //}
      //})
    },

    // knownChatsByGroup(state, getters): Array<Graph> {
    //   return getters.knownChats.map((k: Known) => {
    //     const chat = k.chat as Graph
    //     if (chat.group === GroupedOptions.Ungrouped) {
    //       return {
    //         group: {
    //           entity: '~',
    //           name: 'ungrouped'
    //         },
    //         resources: chat.resources as Array<Entity>
    //       }
    //     } else {
    //       return {
    //         group: chat.group,
    //         resources: chat.resources as Array<Entity>,
    //       }
    //     }
    //   })
    // },

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
    setAdmin(state, payload: Array<Entity>) {
      state.admin = payload;
    },
  },

  actions: {
    getKnown({ commit }) {
      return peatAPI.scryKnown()
        .then((knownResponse: KnownResponse) => {
          const knowns = knownResponse.known
          commit("setKnown", knowns);
          return knowns;
        })
    },

    setKnown({ commit }, payload: Array<Known>) {
      commit("setKnown", payload);
    },

    getSaved({ commit }) {
      return peatAPI.scrySaved()
        .then((response: SavedResponse) => {
          commit("setSaved", response.saved);
          return response.saved;
        })
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
    },

    getAdmin({ commit }) {
      return peatAPI.scryAdmin()
        .then((adminResponse: AdminResponse) => {
          const entities = adminResponse["am-admin"];
          console.log('admin ', entities);
          commit("setAdmin", entities);
          return entities
        }).catch(err => {
          throw err.response
        })
    },

    importResource({commit},
      payload: { groupName: string, newResourceName: string, folder: string }) {
      return peatAPI.importFromDisk(payload)
        .then((r) => {
          return r
        }).catch(err => {
          return err
          throw err.response
        })
    },

    exportResource({commit},
      payload: { resource: Entity, frequency: ExportFrequency }) {
      return peatAPI.exportToDisk(payload)
        .then((r) => {
          return r
        }).catch(err => {
          throw err.response
        })
    },

    doleResource({commit}, payload: DolePayload) {
      return peatAPI.doleResource(payload)
        .then((r) => {
          return r
        }).catch(err => {
          throw err.response
        })
    },
  },
};
