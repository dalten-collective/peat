<template>
  <button @click="singleExport">export {{ ship }}'s {{ resource }}</button>
</template>

<script lang="ts">
import { defineComponent } from 'vue'

export default defineComponent({
  props: [
    'resource',
    'ship',
  ],

  methods: {
    singleExport() {
      console.log("exporting")
      const payload = {
        resource: {
          entity: this.ship,
          name: this.resource,
        },
        frequency: 'fuck-you',
      }
      this.$store.dispatch("peat/exportResource", payload).then((r) => {
        console.log('exported ', r);
        // TODO: do something with response?
      })
    },

    frequentExport() {
      console.log("exporting")
      const payload = {
        resource: {
          entity: this.ship,
          name: this.resource,
        },
        frequency: 'fuck-you', // TODO
      }
      this.$store.dispatch("peat/exportResource", payload).then((r) => {
        console.log('exported ', r);
        // TODO: do something with response?
      })
    }
  },
})
</script>
