<template>
  <div>
    <div v-if="!exportOpen">
      <span @click="exportOpen = !exportOpen" class="cursor-pointer text-green-600 underline">Export</span>
    </div>
    <div v-if="exportOpen" class="pa-2">
      <span @click="exportOpen = !exportOpen" class="cursor-pointer text-green-600 underline">Close</span>
      <div class="mt-2">
        <div>
          <span class="font-bold">One-time export</span>
        </div>
        <button @click="singleExport">Export {{ ship }}'s {{ resource }} once</button>
      </div>
      <hr class="my-2"/>
      <div>
        <div>
          <span class="font-bold">Recurring exports</span>
        </div>
        <label class="block">
          <span class="block text-sm font-medium text-blue-700">Hours</span>
          <input type="text" placeholder="12" v-model="frequencyHours" />
        </label>

        <label class="block">
          <span class="block text-sm font-medium text-blue-700">Days</span>
          <input type="text" placeholder="1" v-model="frequencyDays" />
        </label>
        <button @click="singleExport">export {{ ship }}'s {{ resource }} {{ displayFrequency }}</button>
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
      exportOpen: false,
      frequencyHours: null,
      frequencyDays: null,
    }
  },

  computed: {
    displayFrequency(): string {
      if (this.frequencyDays || this.frequencyHours) {
        const days = this.frequencyDays ? `${ this.frequencyDays } days` : ''
        const hours = this.frequencyHours ? `${ this.frequencyHours } hours` : ''
        return `Every ${ days } ${ hours }`
      } else {
        return ""
      }
    },
  },

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
        frequency: 'd1', // TODO
      }
      this.$store.dispatch("peat/exportResource", payload).then((r) => {
        console.log('exported ', r);
        // TODO: do something with response?
      })
    }
  },
})
</script>
