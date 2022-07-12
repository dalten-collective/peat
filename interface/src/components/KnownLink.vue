<template>
  <div>
    <span class="mr-2 font-bold">{{ link.name }}</span>
    <span class="p-1 px-2 mr-2 text-gray-400 border rounded-md">collection</span>
    <span class="mr-2 text-gray-400">owned by</span>
    <span class="font-mono">{{ link.ship }}</span>
    <ExportKnown :resource="link.name" :ship="link.ship" />
    <DoleKnown :resource="link.name" :ship="link.ship" />
  </div>
</template>

<script lang="ts">
import { defineComponent } from "vue";
import ExportKnown from "@/components/ExportKnown.vue";
import DoleKnown from "@/components/DoleKnown.vue";

export default defineComponent ({
  props: [
    'link'
  ],
  components: {
    ExportKnown,
    DoleKnown,
  },
})
</script>
