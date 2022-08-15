<template>
  <div>
    <div v-if="!shareOpen">
      <span @click="shareOpen = !shareOpen" class="tw-cursor-pointer tw-text-green-600 tw-underline">Share</span>
    </div>
    <div v-if="shareOpen" class="tw-pa-2">
      <span @click="shareOpen = !shareOpen" class="tw-cursor-pointer tw-text-green-600 tw-underline">Close</span>
      <div>
        <div>
          <span class="tw-font-bold">Share with...</span>
        </div>
        <label class="tw-block">
          <span class="tw-block tw-text-sm tw-font-medium tw-text-blue-700">Ships</span>
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
      const payload = {
        resource: {
          entity: this.ship,
          name: this.resource,
        },
      }
      this.$store.dispatch("peat/exportResource", payload).then((r) => {
        // TODO: do something with response?
      })
    },

    frequentExport() {
      const payload = {
        resource: {
          entity: this.ship,
          name: this.resource,
        },
        frequency: 'm1', // TODO
      }
      this.$store.dispatch("peat/exportResource", payload).then((r) => {
        // TODO: do something with response?
      })
    }
  },
})
</script>
