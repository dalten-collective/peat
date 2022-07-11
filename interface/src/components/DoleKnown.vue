<template>
  <div>
    <div v-if="!doleOpen">
      <span @click="doleOpen = !doleOpen" class="cursor-pointer text-green-600 underline">Dole</span>
    </div>
    <div v-if="doleOpen" class="pa-2">
      <span @click="doleOpen = !doleOpen" class="cursor-pointer text-green-600 underline">Close</span>
      <div class="mt-2">
        <div>
          <span class="font-bold">Dole</span>
        </div>
        <button class="action" @click="doDole">Dole</button>
      </div>
    </div>
  </div>
</template>

<script lang="ts">
import { defineComponent } from 'vue'
import { DolePayload } from '@/types';

export default defineComponent({
  props: [
    'resource',
    'ship',
  ],

  data() {
    return {
      doleOpen: false,
      doleShips: ["~sum"],
    }
  },

  computed: {
  },

  methods: {
    doDole() {
      console.log("doling")
      const payload: DolePayload = {
        ships: ['~sum'],
        resources: [{ entity: this.ship, name: this.resource }],
      }
      this.$store.dispatch("peat/doleResource", payload).then((r) => {
        console.log('doled ', r);
        // TODO: do something with response?
      })
    },

  },
})
</script>
