<template>
  <div class="tw-p-2">
    <header class="tw-flex tw-flex-col md:tw-flex-row tw-justify-between md:tw-items-center tw-mb-10">

      <div class="tw-mb-2">
        <div class="tw-flex tw-items-center tw-border-l tw-border-b tw-border-t tw-rounded-sm tw-p-2">
          <div class="tw-w-28">
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
          <div>
            <span class="tw-text-xl">{{ resource.name }}</span>
          </div>
        </div>
      </div>

      <div class="tw-basis-1/3 tw-text-center">
      </div>

      <div class="tw-basis-1/3 md:tw-text-right">
        <div class="tw-flex tw-flex-row md:tw-justify-end">
          <DisplayAdmin :resource="resource" :group="group" class="tw-mr-2"/>
          <span class="tw-mr-2 tw-text-gray-400">owned by</span>
          <span class="tw-font-mono">{{ resource.ship }}</span>
        </div>
      </div>
    </header>

    <footer class="tw-flex tw-flex-col md:tw-flex-row tw-justify-between">
      <div class="tw-flex tw-flex-col tw-align-middle tw-mb-4 md:tw-mb-0">
        <ExportKnown :resource="resource.name" :ship="resource.ship" />
        <DisplaySaved
          :resource="resource"
          class="tw-text-sm tw-mt-2 tw-font-mono tw-opacity-50"
        />
      </div>
      <RemakeKnown
        :resource="resource.name"
        :ship="resource.ship"
        :current-group="group"
        :current-ship="resource.ship"
      />
    </footer>
    <!-- <DoleKnown :resource="resource.name" :ship="resource.ship" /> -->
  </div>
</template>

<script lang="ts">
import { Entity } from "@/types";

import { defineComponent } from "vue";
import { mapGetters } from "vuex";

import ExportKnown from "@/components/ExportKnown.vue";
import RemakeKnown from "@/components/RemakeKnown.vue";
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
    RemakeKnown,
    DoleKnown,
    DisplaySaved,
    DisplayAdmin
  },
})
</script>
