type Ship = string;
export type GraphTypes = "chat" | "link" | "publish" | "dm"

export enum GroupedOptions {
  Ungrouped = "ungrouped"
}

export interface Entity {
  entity: Ship;
  name: string;
}

export interface Graph {
  group: GroupedOptions.Ungrouped | Entity;
  resources: Array<Entity>;
}

export type Known = {
  [G in GraphTypes]?: Graph;
}
