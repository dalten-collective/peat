import urbitAPI from "./urbitAPI";
import { Entity, ExportFrequency } from "@/types";

export function exportToDisk(
  payload: {
    resource: Entity,
    frequency: ExportFrequency
  }
) {
  console.log(payload)
  urbitAPI
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

export function scryHav() {
  return urbitAPI.scry({ app: 'peat', path: '/hav' })
}

export function scryAdmin() {
  return urbitAPI.scry({ app: 'peat', path: '/admin' })
}

