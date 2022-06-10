<template>
  <input type="text" v-model="exportEntity" />
  <input type="text" v-model="exportName" />
  <div>
    <button @click="exportt">export {{ exportEntity }} {{ exportName }}</button>
  </div>
  <div>
    <button @click="scryAdmins">Scry admin</button>
  </div>
  <div>
    <div class="flex flex-row">
      <Known />

      <pre>
        Admins: {{ admins }}
      </pre>
    </div>

  </div>
  <div class="border-2 border-dashed">
    <Hav />
  </div>
</template>

<script lang="ts">
import { defineComponent } from "vue";
import { mapState } from "vuex"
import * as peatAPI from "@/api/peat"
import Hav from "@/components/Hav.vue";
import Known from "@/components/Known.vue";

export default defineComponent({
  data() {
    return {
      exportEntity: "~zod",
      exportName: "zodchan-2400",
      admins: [],
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
  },

  methods: {
    startAirlock(deskname: string) {
      this.$store.dispatch("ship/openAirlockToAgent", deskname);
    },
    closeAirlocks() {
      this.$store.dispatch("ship/closeAgentAirlocks");
    },

    scryAdmins() {
      peatAPI.scryAdmin().then((r) => {
        this.admins = r
      })
    },

    exportt() {
      console.log("exporting")
      const payload = {
        resource: {
          entity: this.exportEntity,
          name: this.exportName,
        },
        frequency: 'fuck-you',
      }
      this.$store.dispatch("peat/exportResource", payload).then((r) => {
        // TODO: do something with response?
      })
    }

  },

  components: {
    Hav,
    Known
  }
})
</script>


