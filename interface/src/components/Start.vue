<template>
  <input type="text" v-model="exportEntity" />
  <input type="text" v-model="exportName" />
  <div>
    <button @click="exportt">export {{ exportEntity }} {{ exportName }}</button>
  </div>
  <div>
    <button @click="scryHavs">Scry havs</button>
    <button @click="scryAdmins">Scry admin</button>
  </div>
  <pre>
    Known: {{ known }}
  </pre>
</template>

<script lang="ts">
import { defineComponent } from "vue";
import { mapState } from "vuex"
import * as peatAPI from "@/api/peat"

export default defineComponent({
  data() {
    return {
      exportEntity: "~zod",
      exportName: "zodchan-2400",
    }
  },
  mounted() {
    const deskname = "peat"
    this.startAirlock(deskname);
  },

  unmounted() {
    this.closeAirlocks();
  },

  computed: {
    ...mapState("peat", ["known"]),
  },

  methods: {
    startAirlock(deskname: string) {
      this.$store.dispatch("ship/openAirlockToAgent", deskname);
    },
    closeAirlocks() {
      this.$store.dispatch("ship/closeAgentAirlocks");
    },

    scryHavs() {
      peatAPI.scryHav();
    },
    scryAdmins() {
      peatAPI.scryAdmin();
    },

    exportt() {
      peatAPI.exportToDisk({
        resource: {
          entity: this.exportEntity,
          name: this.exportName
        },
        frequency: "fuck-you"
      })
    },
  },
})
</script>


