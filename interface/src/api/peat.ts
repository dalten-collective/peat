import urbitAPI from "./urbitAPI";
import { Entity, ExportFrequency } from "@/types";

export function exportToDisk(
  payload: {
    resource: Entity,
    frequency: ExportFrequency
  }
) {
  // TODO: return this and then return it in the store
  return urbitAPI
    .poke({
      app: "peat",
      mark: "peat-repete",
      json: {
        export: payload,
      }
    })
    .then((r) => {
      console.log("res ", r);
    })
    .catch((e) => {
      console.log("err ", e);
    });
}

export function importFromDisk(
  payload: {
    groupName: string,
    newResourceName: string,
    folder: string,
  }
) {
  const transformedPayload = {
    folder: `/${ payload.folder }`,
    group: payload.groupName,
    'new-resource-name': payload.newResourceName,
  }
  console.log('payload ', payload)
  console.log('trsm payload ', transformedPayload)
  return urbitAPI
    .poke({
      app: "peat",
      mark: "peat-repete",
      json: {
        import: transformedPayload,
      }
    })
    .then((r) => {
      console.log("res ", r);
    })
    .catch((e) => {
      console.log("err ", e);
    });
}

export function scryHav() {
  return urbitAPI.scry({ app: 'peat', path: '/hav' })
}

export function scrySaved() {
  return urbitAPI.scry({ app: 'peat', path: '/saved' })
}

export function scryKnown() {
  return urbitAPI.scry({ app: 'peat', path: '/known' })
}

export function scryAdmin() {
  return urbitAPI.scry({ app: 'peat', path: '/admin' })
}

