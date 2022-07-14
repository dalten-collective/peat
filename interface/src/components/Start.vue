<template>
  <div>
    <div class="tw-flex tw-flex-row tw-my-8">
      <!-- <Saved class="grow-0"/> -->
      <Known class="tw-grow" />
      <!-- <Admin class="grow"/> -->
    </div>
  </div>

  <div class="tw-border-2 tw-border-dashed">
    <Hav />
  </div>
</template>

<script lang="ts">
import { defineComponent } from "vue";
import { mapState } from "vuex"
import * as peatAPI from "@/api/peat"
import Hav from "@/components/Hav.vue";
import Known from "@/components/Known.vue";
import Admin from "@/components/Admin.vue";
import Saved from "@/components/Saved.vue";

export default defineComponent({
  data() {
    return {}
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

  },

  components: {
    Admin,
    Hav,
    Known,
    Saved,
  }
})
</script>


