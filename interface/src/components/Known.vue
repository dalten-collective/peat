<template>
  <div>
    <pre>
      Known: {{ known }}
    </pre>
  </div>
</template>

<script lang="ts">
import { defineComponent } from 'vue'
import { mapState } from 'vuex';
import * as peatAPI from "@/api/peat"

export default defineComponent({
  data() {
    return {
      knownPending: true,
    }
  },

  computed: {
    ...mapState("peat", ["known"]),
  },

  methods: {
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

