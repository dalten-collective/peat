import urbitAPI from "./urbitAPI";
import * as airlock from "./airlock";
import * as peat from "./peat";

export default {
  ...airlock,
  ...peat,
  ...urbitAPI,
};
