<template>
  <div>
    <span class="mr-2 font-bold">{{ publish.name }}</span>
    <span class="p-1 px-2 mr-2 text-gray-400 border rounded-md">notebook</span>
    <span class="mr-2 text-gray-400">owned by</span>
    <span class="font-mono">{{ publish.ship }}</span>
    <ExportKnown :resource="publish.name" :ship="publish.ship" />
    <DoleKnown :resource="publish.name" :ship="publish.ship" />
    <DisplaySaved :resource="publish" />
    <DisplayAdmin :resource="publish" :group="group" />
  </div>
</template>

<script lang="ts">
import { defineComponent } from "vue";
import ExportKnown from "@/components/ExportKnown.vue";
import DoleKnown from "@/components/DoleKnown.vue";
import DisplaySaved from "@/components/DisplaySaved.vue";
import DisplayAdmin from "@/components/DisplayAdmin.vue";

export default defineComponent ({
  props: [
    'publish',
    'group',
  ],
  components: {
    ExportKnown,
    DoleKnown,
    DisplaySaved,
    DisplayAdmin
  },
})
</script>
