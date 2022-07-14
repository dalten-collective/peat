<template>
  <div>
    <span class="tw-mr-2 tw-font-bold">{{ resource.name }}</span>
    <span class="tw-py-[2px] tw-px-[6px] tw-mr-2 tw-text-blue-400 tw-border tw-rounded-md tw-border-blue-300 tw-text-xs">{{ shape }}</span>
    <span class="tw-mr-2 tw-text-gray-400">owned by</span>
    <span class="tw-font-mono">{{ resource.ship }}</span>
    <ExportKnown :resource="resource.name" :ship="resource.ship" />
    <DoleKnown :resource="resource.name" :ship="resource.ship" />
    <DisplaySaved :resource="resource" />
    <DisplayAdmin :resource="resource" :group="group" />
  </div>
</template>

<script lang="ts">
import { Entity } from "@/types";

import { defineComponent } from "vue";
import { mapGetters } from "vuex";

import ExportKnown from "@/components/ExportKnown.vue";
import DoleKnown from "@/components/DoleKnown.vue";
import DisplaySaved from "@/components/DisplaySaved.vue";
import DisplayAdmin from "@/components/DisplayAdmin.vue";

export default defineComponent ({
  props: [
    'resource',
    'group',
    'shape'
  ],

  computed: {
  },

  methods: {
  },

  components: {
    ExportKnown,
    DoleKnown,
    DisplaySaved,
    DisplayAdmin
  },
})
</script>
