export type Ship = `~${ string }`;
type ResourceName = string;

export type GraphTypes = "chat" | "link" | "publish" | "dm";
export type ShapeTypes = "%chat" | "%link" | "%publish" | "%dm";

export enum GroupedOptions {
  Ungrouped = "ungrouped",
}

export interface Entity {
  entity: Ship;
  name: string;
}

export interface Graph {
  group: GroupedOptions.Ungrouped | Entity;
  resources: Array<Entity>;
}

export interface HavResource {
  resource: ResourceName;
  length: number;
}

export interface KnownResponse {
  known: Array<Known>;
}
export interface SavedResponse {
  saved: Array<Saved>;
}

export type SavedDetails = {
  entity: Ship;
  name: string;
  frequency: number;
  "last-index-captured": number;
};

export type GivenDetails = {
  shape: ShapeTypes;
  resources: Array<Entity>
}

export type HavResponse = {
  available: Array<Hav>;
}

export type AdminResponse = {
  'am-admin': Array<Entity>;
}

export type ExportFrequency = string;

export type Saved = {
  number: SavedDetails;
};
export interface SavedState {
  [key: number]: Saved
};

export type Given = {
  Ship: GivenDetails;
};
export type Doled = {
  Ship: GivenDetails;
};
export type Known = {
  [G in GraphTypes]?: Graph;
};
export type Hav = {
  shape: GraphTypes;
  resources: Array<HavResource>
}

// this poke works:
// peat &peat-repete [%permit per=(sy [~sum ~]) rys=(sy [[~zod %chatty-cathies] ~])]


export interface DolePayload {
  ships: Array<Ship>,
  resources: Array<Entity>
}
