import urbitAPI from "./urbitAPI";
import * as airlockAPI from "./airlock";
import * as peatAPI from "./peat";

export default {
  ...airlockAPI,
  ...peatAPI,
  ...urbitAPI,
};
