import urbitAPI from "./urbitAPI";
import { Entity, ExportFrequency, DolePayload } from "@/types";

export function doleResource(payload: DolePayload) {
  console.log('p ', payload);
  
  return urbitAPI
    .poke({
      app: "peat",
      mark: "peat-repete",
      json: {
        permit: payload
      }
    }).then((r) => {
      console.log("permit res: ", r)
      return r
    }).catch(e => {
      console.log('permit error: ', e)
      return e
    })
}

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
      console.log("export res ", r);
    })
    .catch((e) => {
      console.log("export err ", e);
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

