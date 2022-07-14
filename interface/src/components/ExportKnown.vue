<template>
  <v-dialog v-model="exportOpen">
    <template v-slot:activator="{ props }">
      <v-btn
        v-bind="props" color="success"
        text="white"
        @click="openExport"
      >
        <v-icon start>mdi-content-save</v-icon>
        export</v-btn
      >
    </template>
    <v-card class="tw-border-4 tw-border-primary tw-bg-surface tw-w-96">
      <v-card-title>
        <div class="tw-flex tw-flex-row tw-justify-between">
          <h2 class="tw-text-2xl">Export</h2>
          <div>
            <span
              @click="exportOpen = !exportOpen"
              class="tw-text-sm tw-cursor-pointer tw-underline"
              >Close</span
            >
          </div>
        </div>
      </v-card-title>

      <v-card-text>
        <div class="tw-mt-2">
          <div class="tw-mb-2">
            <span class="tw-font-bold">One-time export</span>
            <v-tooltip location="top">
              <template v-slot:activator="{ props }">
                <v-icon
                  v-bind="props"
                  size="x-small"
                  class="tw-ml-1 tw-cursor-pointer tw-mb-2 tw-opacity-50"
                  >mdi-help-circle-outline</v-icon
                >
              </template>
              <span
                >After exporting, you'll find a file in your ship's
                <span class="tw-font-mono">put</span> directory, like:
                <span class="tw-font-mono">.urb/put/{{ resource }}.</span></span
              >
            </v-tooltip>
          </div>
          <div>
            <v-btn color="success" text="white" @click="singleExport"
              >Export {{ ship }}'s {{ resource }} once</v-btn
            >
          </div>
        </div>

        <hr class="tw-my-4" />

        <div>
          <div>
            <span class="tw-font-bold">Recurring exports</span>
            <v-tooltip location="top">
              <template v-slot:activator="{ props }">
                <v-icon
                  v-bind="props"
                  size="x-small"
                  class="tw-ml-1 tw-cursor-pointer tw-mb-2 tw-opacity-50"
                  >mdi-help-circle-outline</v-icon
                >
              </template>
              <span
                >An export will be performed at the selected interval, rewriting the previous file (see one-time export tooltip above).
                <span class="tw-font-mono">put</span> directory, like:
                <span class="tw-font-mono">.urb/put/{{ resource }}.</span></span
              >
            </v-tooltip>
          </div>
          <v-form>
            <v-container>
              <v-row>
                <v-col cols="12" lg="4">
                  <v-select
                    :items="daysOptions"
                    label="Days"
                    v-model="frequencyDays"
                  />
                </v-col>
                <v-col cols="12" lg="4">
                  <v-select
                    :items="hoursOptions"
                    label="Hours"
                    v-model="frequencyHours"
                  />
                </v-col>
                <v-col cols="12" lg="4">
                  <v-select
                    :items="minutesOptions"
                    label="Minutes"
                    v-model="frequencyMinutes"
                  />
                </v-col>
              </v-row>
              <div class="tw-text-right">
                <div class="tw-mb-1">
                  <v-btn color="success" text="white" @click="frequentExport"
                    >export {{ ship }}'s {{ resource }}</v-btn
                  >
                </div>
                <div>
                  <span>{{ displayFrequency }}</span>
                  <span class="tw-text-gray-400">({{ hoonedFrequcency }})</span>
                </div>
              </div>
            </v-container>
          </v-form>
        </div>
      </v-card-text>
    </v-card>
  </v-dialog>

  <div v-if="false">
    <div>
      <div v-if="!exportOpen">
        <span
          @click="exportOpen = !exportOpen"
          class="tw-cursor-pointer tw-text-green-600 tw-underline"
          >Export</span
        >
      </div>
      <div v-if="exportOpen" class="tw-pa-2"></div>
    </div>
  </div>
</template>

<script lang="ts">
import { defineComponent } from "vue";

export default defineComponent({
  props: ["resource", "ship"],

  data() {
    return {
      exportOpen: false,
      frequencyDays: 0,
      frequencyHours: 12,
      frequencyMinutes: 30,
    };
  },

  computed: {
    daysOptions(): Array<number> {
      return [0].concat(
        Array(30)
          .fill(1)
          .map((x, y) => x + y)
      );
    },
    hoursOptions(): Array<number> {
      return [0].concat(
        Array(24)
          .fill(1)
          .map((x, y) => x + y)
          .filter((x) => x >= 12)
      );
    },
    minutesOptions(): Array<number> {
      return [0].concat(
        Array(60)
          .fill(1)
          .map((x, y) => x + y)
      );
    },
    displayFrequency(): string {
      if (this.frequencyDays || this.frequencyHours || this.frequencyMinutes) {
        const days = this.frequencyDays
          ? `${this.frequencyDays} day${this.frequencyDays == 1 ? "" : "s"}`
          : "";
        const hours = this.frequencyHours
          ? `${this.frequencyHours} hour${this.frequencyHours == 1 ? "" : "s"}`
          : "";
        const minutes = this.frequencyMinutes
          ? `${this.frequencyMinutes} minute${
              this.frequencyMinutes == 1 ? "" : "s"
            }`
          : "";
        return `Every ${days} ${hours} ${minutes}`;
      } else {
        return "";
      }
    },

    hoonedFrequcency(): string {
      const days = this.frequencyDays ? `${"d" + this.frequencyDays}` : "";
      const hours = this.frequencyHours ? `${"h" + this.frequencyHours}` : "";
      const minutes = this.frequencyMinutes
        ? `${"m" + this.frequencyMinutes}`
        : "";
      const worm = [days, hours, minutes].filter(Boolean); // trim out empties
      return `~${worm.join(".")}`;
    },
  },

  methods: {
    singleExport() {
      console.log("exporting");
      const payload = {
        resource: {
          entity: this.ship,
          name: this.resource,
        },
        frequency: "fuck-you",
      };
      this.$store.dispatch("peat/exportResource", payload).then((r) => {
        console.log("exported ", r);
        // TODO: do something with response?
      });
    },

    frequentExport() {
      console.log("exporting");
      const payload = {
        resource: {
          entity: this.ship,
          name: this.resource,
        },
        frequency: this.hoonedFrequcency,
      };
      this.$store.dispatch("peat/exportResource", payload).then((r) => {
        console.log("exported ", r);
        // TODO: do something with response?
        // TODO: update the `saved` with this new guy?
      });
    },
  },
});
</script>
