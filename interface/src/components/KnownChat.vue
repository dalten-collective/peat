<template>
  <div>
    <span class="mr-2 font-bold">{{ chat.name }}</span>
    <span class="p-1 px-2 mr-2 text-gray-400 border rounded-md">chat</span>
    <span class="mr-2 text-gray-400">owned by</span>
    <span class="font-mono">{{ chat.ship }}</span>
    <ExportKnown :resource="chat.name" :ship="chat.ship" />
    <DoleKnown :resource="chat.name" :ship="chat.ship" />
  </div>
</template>

<script lang="ts">
import { defineComponent } from "vue";
import ExportKnown from "@/components/ExportKnown.vue";
import DoleKnown from "@/components/DoleKnown.vue";

export default defineComponent ({
  props: [
    'chat'
  ],
  components: {
    ExportKnown,
    DoleKnown,
  },
})
</script>
