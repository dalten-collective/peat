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
      json: payload,
    })
    .then((r) => {
      console.log("res ", r);
    })
    .catch((e) => {
      console.log("err ", e);
    });
}

