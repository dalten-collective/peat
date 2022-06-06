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
  urbitAPI
    .scry({ app: 'peat', path: '/hav' })
    .then((r) => {
      console.log("scry res ", r);
    })
    .catch((e) => {
      console.log("err ", e);
    });
}

export function scryAdmin() {
  urbitAPI
    .scry({ app: 'peat', path: '/admin' })
    .then((r) => {
      console.log("scry res ", r);
    })
    .catch((e) => {
      console.log("err ", e);
    });
}

