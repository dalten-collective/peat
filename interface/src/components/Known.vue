<template>
  <div>
    <div>
      <h3>Known</h3>
      <button @click="getKnown">Scry Known</button>
    </div>
    <div v-if="knownPending">
      LOADING
    </div>
    <div v-else>
      <div>
        <ul>
          <li v-for="g in knownChatsByGroup" :key="g.group.name" class="mb-8">
            <h4 class="text-lg mb-4">Resources in <span class="font-mono">{{ g.group.name }}</span></h4>
            <ul class="my-2">
              <li v-for="r in g.resources" :key="r.name" class="my-4 border rounded-sm p-2">
                <div>
                  <span class="font-bold mr-2">{{ r.name }}</span>
                  <span class="text-gray-400 mr-2">owned by</span>
                  <span class="font-mono">{{ r.ship }}</span>
                  <ExportKnown :resource="r.name" :ship="r.ship" />
                  <DoleKnown :resource="r.name" :ship="r.ship" />
                </div>
              </li>
            </ul>
            <hr/>
          </li>
        </ul>
      </div>
    </div>

  </div>
</template>

<script lang="ts">
import { defineComponent } from 'vue'
import { mapState, mapGetters } from 'vuex';
import * as peatAPI from "@/api/peat"
import ExportKnown from "@/components/ExportKnown.vue"
import DoleKnown from "@/components/DoleKnown.vue"

export default defineComponent({
  data() {
    return {
      knownPending: true,
    }
  },

  mounted() {
    this.getKnown();
  },

  computed: {
    ...mapState("peat", ["known"]),
    ...mapGetters("peat", ["knownChatsByGroup"]),
  },

  methods: {
    getKnown() {
      this.knownPending = true;
      this.$store.dispatch("peat/getKnown").then((r) => {
          this.knownPending = false;
          console.log('known r ', r)
        })
        .catch(err => {
          console.log(err)
        })
    },
  },

  components: {
    ExportKnown,
    DoleKnown,
  },

})
</script>

