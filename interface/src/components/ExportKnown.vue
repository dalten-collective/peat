<template>
  <div>
    <div v-if="!exportOpen">
      <span @click="exportOpen = !exportOpen" class="cursor-pointer text-green-600 underline">Export</span>
    </div>
    <div v-if="exportOpen" class="pa-2">
      <span @click="exportOpen = !exportOpen" class="cursor-pointer text-green-600 underline">Close</span>
      <div class="mt-2">
        <div>
          <span class="font-bold">One-time export</span>
        </div>
        <button class="action" @click="singleExport">Export {{ ship }}'s {{ resource }} once</button>
      </div>
      <hr class="my-2"/>
      <div>
        <div>
          <span class="font-bold">Recurring exports</span>
        </div>
        <form>
          <div class="mb-2">
            <div class="inline-block mr-1">
              <label>
                <span class="form-label">Days</span>
                <select v-model="frequencyDays">
                  <option disabled value="">Days</option>
                  <option v-for="o in daysOptions" :text="o" :value="o">{{ o }}</option>
                </select>
              </label>
            </div>

            <div class="inline-block mr-1">
              <label>
                <span class="form-label">Hours</span>
                <select v-model="frequencyHours">
                    <option disabled value="">Hours</option>
                  <option v-for="o in hoursOptions" :text="o" :value="o">{{ o }}</option>
                </select>
              </label>
            </div>

            <div class="inline-block mr-1">
              <label>
                <span class="form-label">Minutes</span>
                <select v-model="frequencyMinutes">
                    <option disabled value="">Minutes</option>
                  <option v-for="o in minutesOptions" :text="o" :value="o">{{ o }}</option>
                </select>
              </label>
            </div>
          </div>

          <div class="text-right">
            <div class="mb-1">
            <button class="action" @click="frequentExport">export {{ ship }}'s {{ resource }}</button>
            </div>
            <div>
              <span>{{ displayFrequency }}</span> <span class="text-gray-400">({{ hoonedFrequcency }})</span>
            </div>
          </div>
        </form>
      </div>
    </div>
  </div>
</template>

<script lang="ts">
import { defineComponent } from 'vue'

export default defineComponent({
  props: [
    'resource',
    'ship',
  ],

  data() {
    return {
      exportOpen: false,
      frequencyDays: 0,
      frequencyHours: 12,
      frequencyMinutes: 30,
    }
  },

  computed: {
    daysOptions(): Array<number> {
      return [0].concat(Array(30).fill(1).map((x,y) => x + y));
    },
    hoursOptions(): Array<number> {
      return [0].concat(Array(24).fill(1).map((x,y) => x + y).filter(x => x >= 12));
    },
    minutesOptions(): Array<number> {
      return [0].concat(Array(60).fill(1).map((x,y) => x + y));
    },
    displayFrequency(): string {
      if (this.frequencyDays || this.frequencyHours || this.frequencyMinutes) {
        const days = this.frequencyDays ? `${ this.frequencyDays } day${ this.frequencyDays == 1 ? '' : 's' }` : ''
        const hours = this.frequencyHours ? `${ this.frequencyHours } hour${ this.frequencyHours == 1 ? '' : 's' }` : ''
        const minutes = this.frequencyMinutes ? `${ this.frequencyMinutes } minute${ this.frequencyMinutes == 1 ? '' : 's' }` : ''
        return `Every ${ days } ${ hours } ${ minutes }`
      } else {
        return ""
      }
    },

    hoonedFrequcency(): string {
      const days = this.frequencyDays ? `${ 'd' + this.frequencyDays  }` : ''
      const hours = this.frequencyHours ? `${ 'h' + this.frequencyHours }` : ''
      const minutes = this.frequencyMinutes ? `${ 'm' + this.frequencyMinutes }` : ''
      const worm = [days, hours, minutes].filter(Boolean)  // trim out empties
      return `~${ worm.join('.') }`;
    }
  },

  methods: {
    singleExport() {
      console.log("exporting")
      const payload = {
        resource: {
          entity: this.ship,
          name: this.resource,
        },
        frequency: 'fuck-you',
      }
      this.$store.dispatch("peat/exportResource", payload).then((r) => {
        console.log('exported ', r);
        // TODO: do something with response?
      })
    },

    frequentExport() {
      console.log("exporting")
      const payload = {
        resource: {
          entity: this.ship,
          name: this.resource,
        },
        frequency: this.hoonedFrequcency,
      }
      this.$store.dispatch("peat/exportResource", payload).then((r) => {
        console.log('exported ', r);
        // TODO: do something with response?
        // TODO: update the `saved` with this new guy?
      })
    }
  },
})
</script>
