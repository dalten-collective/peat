<template>
  <div class="tw-p-2">
    <div class="tw-flex tw-justify-between">
      <div class="tw-basis-1/3 tw-mb-2">
        <div class="tw-flex tw-justify-between">
          <div>
            <span class="tw-font-bold">{{ resource.name }}</span>
          </div>
          <div>
            <v-chip variant="outlined" label size="small" color="info" class="mr-2">
              <v-icon start v-if="shape === 'chat'" icon="mdi-chat-outline">
              </v-icon>
              <v-icon start v-if="shape === 'collection'" icon="mdi-image-multiple">
              </v-icon>
              <v-icon start v-if="shape === 'notebook'" icon="mdi-notebook">
              </v-icon>
              {{ shape }}
            </v-chip>
          </div>
        </div>
      </div>

      <div class="tw-basis-1/3 tw-text-center">
      </div>

      <div class="tw-basis-1/3 tw-text-right">
        <span class="tw-mr-2 tw-text-gray-400">owned by</span>
        <span class="tw-font-mono">{{ resource.ship }}</span>
      </div>
    </div>
    <ExportKnown :resource="resource.name" :ship="resource.ship" />
    <!-- <DoleKnown :resource="resource.name" :ship="resource.ship" /> -->
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
