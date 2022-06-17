<template>
  <div>
    <div v-if="!shareOpen">
      <span @click="shareOpen = !shareOpen" class="cursor-pointer text-green-600 underline">Share</span>
    </div>
    <div v-if="shareOpen" class="pa-2">
      <span @click="shareOpen = !shareOpen" class="cursor-pointer text-green-600 underline">Close</span>
      <div>
        <div>
          <span class="font-bold">Share with...</span>
        </div>
        <label class="block">
          <span class="block text-sm font-medium text-blue-700">Ships</span>
          <input type="text" placeholder="12" v-model="shareWithShips" />
        </label>
        <button @click="doShare">share {{ ship }}'s {{ resource }} {{ shareWithShips }}</button>
      </div>
    </div>
  </div>
</template>

<script lang="ts">
import { defineComponent } from 'vue'

export default defineComponent({
  props: [
    'resource',
    'ship',
  ],

  data() {
    return {
      shareOpen: false,
    }
  },

  computed: {
  },

  methods: {
    doShare() {
      console.log("sharing...")
      const payload = {
        resource: {
          entity: this.ship,
          name: this.resource,
        },
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
        frequency: 'm1', // TODO
      }
      this.$store.dispatch("peat/exportResource", payload).then((r) => {
        console.log('exported ', r);
        // TODO: do something with response?
      })
    }
  },
})
</script>
