import urbitAPI from "./urbitAPI";
import { Entity, ExportFrequency, DolePayload } from "@/types";

export function doleResource(payload: DolePayload) {
  
  return urbitAPI
    .poke({
      app: "peat",
      mark: "peat-repete",
      json: {
        permit: payload
      }
    }).then((r) => {
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
  return urbitAPI
    .poke({
      app: "peat",
      mark: "peat-repete",
      json: {
        import: transformedPayload,
      }
    })
    .then((r) => {
    })
    .catch((e) => {
      console.log("err ", e);
    });
}

export function reMake(
  payload: {
    group: string,
    'new-resource-name': string,
    'remake-resource': string
  }
) {
  return urbitAPI
    .poke({
      app: "peat",
      mark: "peat-repete",
      json: {
        remake: payload,
      }
    })
    .then((r) => {
    })
    .catch((e) => {
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

