<template>
  <!-- <div class="my-8 tw-flex" :class="mobileClasses"> -->
  <v-card>
    <div class="d-flex" :class="mobileClasses">
      <div class="flex-row d-flex">
        <v-tabs
          v-model="tab"
          :direction="onSmall ? 'horizontal' : 'vertical'"
          color="info"
          class="tw-bg-secondary"
        >
          <v-tab value="known">
            <v-icon start>mdi-flare</v-icon>
            Live
          </v-tab>
          <v-tab value="hav">
            <v-icon start>mdi-folder</v-icon>
            On Disk
          </v-tab>
        </v-tabs>
      </div>

      <v-window v-model="tab">
        <v-window-item value="known" class="tw-w-xl">
          <v-card class="tw-grow tw-p-4 tw-bg-white tw-border-r tw-border-t tw-border-l tw-border-b tw-border-secondary tw-rounded-none tw-rounded-r-lg">
            <div class="tw-flex tw-flex-row tw-my-8">
              <!-- <Saved class="grow-0"/> -->
              <Known class="tw-grow" />
              <!-- <Admin class="grow"/> -->
            </div>
          </v-card>
        </v-window-item>

        <v-window-item value="hav" class="tw-w-xl">
          <v-card class="tw-grow tw-p-4 tw-bg-white tw-border-r tw-border-t tw-border-l tw-border-b tw-border-secondary tw-rounded-none tw-rounded-r-lg">
            <div class="tw-flex tw-flex-row tw-my-8">
              <Hav />
            </div>
          </v-card>
        </v-window-item>
      </v-window>
    </div>
  </v-card>
  <!-- </div> -->
</template>

<script lang="ts">
import { useDisplay } from 'vuetify'

import { defineComponent } from "vue";
import { mapState } from "vuex"
import * as peatAPI from "@/api/peat"
import Hav from "@/components/Hav.vue";
import Known from "@/components/Known.vue";
import Admin from "@/components/Admin.vue";
import Saved from "@/components/Saved.vue";


export default defineComponent({
  data() {
    return {
      tab: 'known',
    }
  },
  mounted() {
    this.getAdmin()
  },
  computed: {
    mobileClasses() {
      const smol = this.onSmall ? true : false
      return {
        'tw-flex-col': smol,
        'tw-flex-row': !smol,
      }
    },

    onSmall() {
      const display = useDisplay()
      return display.smAndDown.value
    },
  },

  methods: {
    startAirlock(deskname: string) {
      this.$store.dispatch("ship/openAirlockToAgent", deskname);
    },
    closeAirlocks() {
      this.$store.dispatch("ship/closeAgentAirlocks");
    },

    getAdmin() {
      this.adminPending = true;
      this.$store.dispatch("peat/getAdmin")
        .then((r) => {
          this.adminPending = false;
        })
    },
  },

  components: {
    Admin,
    Hav,
    Known,
    Saved,
  }
})
</script>


