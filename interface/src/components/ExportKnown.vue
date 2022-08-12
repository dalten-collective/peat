<template>
  <v-dialog v-model="exportOpen">
    <template v-slot:activator="{ props }">

      <v-hover v-if="isSaved" v-slot="{ isHovering, props }">
        <v-btn
          v-bind="props" color="success"
          text="white"
          @click="openExport"
          v-if="isHovering"
        >
          <v-icon start>mdi-content-save</v-icon>
          Export once or change frequency
        </v-btn>
        <v-btn
          v-bind="props" color="success"
          text="white"
          @click="openExport"
          v-else
        >
          <v-icon start>mdi-cached</v-icon>
          exporting every {{ formatFreqAsHoon(isSaved.frequency) }}
        </v-btn>
      </v-hover>

      <v-btn
        v-else
        v-bind="props" color="success"
        text="white"
        @click="openExport"
      >
        <v-icon start>mdi-content-save</v-icon>
        export
      </v-btn>

    </template>
    <v-card class="tw-w-96 tw-border-4 tw-border-primary tw-bg-surface tw-p-4">
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
            <div class="tw-my-2">
              <span class="tw-italic">Export <span class="tw-font-mono tw-not-italic">{{ ship }}</span>'s "{{ resource }}" once</span>
            </div>
            <v-btn color="success" text="white" :loading="exportPending" @click="singleExport">
              Export
            </v-btn
            >
          </div>
        </div>

        <hr class="tw-my-4" />

        <div>
          <div class="tw-mb-2">
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
                >An export will be performed at the selected interval, rewriting the previous file (see one-time export tooltip above) in the
                <span class="tw-font-mono">put</span> directory, like:
                <span class="tw-font-mono">.urb/put/{{ resource }}.</span></span
              >
            </v-tooltip>
          </div>

          <v-form>
              <v-row>
                <v-col cols="12">
                  <v-select
                    :items="daysOptions"
                    label="Days"
                    v-model="frequencyDays"
                    hide-details="auto"
                  />
                </v-col>
              </v-row>
              <v-row>
                <v-col cols="12">
                  <v-select
                    :items="hoursOptions"
                    label="Hours"
                    v-model="frequencyHours"
                    hide-details="auto"
                  />
                </v-col>
              </v-row>
              <v-row>
                <v-col cols="12">
                  <v-select
                    :items="minutesOptions"
                    label="Minutes"
                    v-model="frequencyMinutes"
                    hide-details="auto"
                  />
                </v-col>
              </v-row>

              <div>
                <div class="tw-my-4">
                  <div>
                    <span class="tw-mr-2">{{ displayFrequency }}</span>
                    <span class="tw-text-gray-400">({{ hoonedFrequcency }})</span>
                  </div>
                </div>
                <div class="tw-mb-1">
                  <v-btn color="success" :loading="exportPending" text="white" @click="frequentExport">
                    Export frequently
                  </v-btn>
                </div>
              </div>
              <div v-if="exportPending">
                <v-alert type="info" variant="tonal">
                  Export has started. You might notice your ship hanging while this completes... You can close this page - or watch.
                </v-alert>
              </div>
              <div v-if="showDone">
                <v-alert type="success" variant="tonal">
                  Export complete! Check your 
                  <span class="tw-font-mono">.urb/put/{{ resource }}.</span> directory.
                </v-alert>
              </div>
          </v-form>
        </div>
      </v-card-text>
    </v-card>
  </v-dialog>
</template>

<script lang="ts">
import { defineComponent } from "vue";
import { mapGetters } from "vuex";

export default defineComponent({
  props: ["resource", "ship"],

  data() {
    return {
      exportOpen: false,
      exportPending: false,
      showDone: false,
      frequencyDays: 0,
      frequencyHours: 12,
      frequencyMinutes: 30,
    };
  },

  watch: {
    exportOpen(val) {
      if (!val) { // closing
        // reset things
        this.exportPending = false;
        this.showDone = false;
      }
    },
  },

  computed: {
    ...mapGetters("peat", ["isRecurringSaved"]),
    isSaved() {
      if (this.isRecurringSaved) {
        return this.isRecurringSaved({ name: this.resource, ship: this.ship })
      }
      return false
    },
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
      return this.formatFreqAsHoon({
        days: this.frequencyDays,
        hours: this.frequencyHours,
        minutes: this.frequencyMinutes
      })
    },
  },

  methods: {
    openExport() {
      this.exportOpen = true;
    },

    formatFreqAsHoon(freq: { days: number, minutes: number, hours: number }) {
      const d = freq.days ? `${"d" + freq.days}` : "";
      const h = freq.hours ? `${"h" + freq.hours}` : "";
      const m = freq.minutes
        ? `${"m" + freq.minutes}`
        : "";
      const worm = [d, h, m].filter(Boolean); // trim out empties
      return `~${worm.join(".")}`;
    },

    singleExport() {
      this.exportPending = true;
      const payload = {
        resource: {
          entity: this.ship,
          name: this.resource,
        },
        frequency: "fuck-you",
      };
      this.$store.dispatch("peat/exportResource", payload)
        .then((r) => {
        }).finally(() => {
          this.exportPending = false;
          this.showDone = true;
        });
    },

    frequentExport() {
      this.exportPending = true;
      const payload = {
        resource: {
          entity: this.ship,
          name: this.resource,
        },
        frequency: this.hoonedFrequcency,
      };
      this.$store.dispatch("peat/exportResource", payload)
        .then((r) => {
        }).finally(() => {
          this.exportPending = false;
          this.showDone = true;
          // TODO: update the `saved` with this new guy?
        });
    },
  },
});
</script>
