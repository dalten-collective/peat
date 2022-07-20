<template>
  <div>
    <span class="tw-mr-2 tw-font-bold">{{ chat.name }}</span>
    <span class="tw-p-1 tw-px-2 tw-mr-2 tw-text-gray-400 tw-border tw-rounded-md">chat</span>
    <span class="tw-mr-2 tw-text-gray-400">owned by</span>
    <span class="tw-font-mono">{{ chat.ship }}</span>
    <ExportKnown :resource="chat.name" :ship="chat.ship" />
    <DoleKnown :resource="chat.name" :ship="chat.ship" />
    <DisplaySaved :resource="chat" />
    <DisplayAdmin :resource="chat" :group="group" />
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
    'chat',
    'group',
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
