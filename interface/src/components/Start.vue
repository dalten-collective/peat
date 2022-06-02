<template>
  <pre>
    Known: {{ known }}
  </pre>
</template>

<script lang="ts">
import { defineComponent } from "vue";
import { mapState } from "vuex"

export default defineComponent({
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
    startAirlock(deskname) {
      this.$store.dispatch("ship/openAirlockToAgent", deskname);
    },
    closeAirlocks() {
      this.$store.dispatch("ship/closeAgentAirlocks");
    },
  },
})
</script>


