<template>
  <div>
    <div>
      <h3>Known</h3>
      <button @click="getKnown">Scry Known</button>
    </div>
    <div v-if="knownPending">LOADING</div>
    <div v-else>
      <div>
        <ul>
          <li v-for="pair in filterResourcesByGroup('')" :key="pair[0]" class="mb-8">
            <h4 class="mb-4 text-lg">
              Resources in <span class="font-mono">{{ pair[0] }}</span>
            </h4>

<!-- TODO: make components per: -->

            <ul class="my-2">
              <li
                v-for="c in pair[1].chats"
                :key="c.name"
                class="p-2 my-4 border rounded-sm"
              >
                <div>
                  <span class="mr-2 font-bold">{{ c.name }}</span>
                  <span class="p-1 px-2 mr-2 text-gray-400 border rounded-md">chat</span>
                  <span class="mr-2 text-gray-400">owned by</span>
                  <span class="font-mono">{{ c.ship }}</span>
                  <ExportKnown :resource="c.name" :ship="c.ship" />
                  <DoleKnown :resource="c.name" :ship="c.ship" />
                </div>
              </li>
            </ul>

            <ul class="my-2">
              <li
                v-for="c in pair[1].links"
                :key="c.name"
                class="p-2 my-4 border rounded-sm"
              >
                <div>
                  <span class="mr-2 font-bold">{{ c.name }}</span>
                  <span class="p-1 px-2 mr-2 text-gray-400 border rounded-md">collection</span>
                  <span class="font-mono">{{ c.ship }}</span>
                  <ExportKnown :resource="c.name" :ship="c.ship" />
                  <DoleKnown :resource="c.name" :ship="c.ship" />
                </div>
              </li>
            </ul>

            <ul class="my-2">
              <li
                v-for="c in pair[1].publishes"
                :key="c.name"
                class="p-2 my-4 border rounded-sm"
              >
                <div>
                  <span class="mr-2 font-bold">{{ c.name }}</span>
                  <span class="p-1 px-2 mr-2 text-gray-400 border rounded-md">notebook</span>
                  <span class="font-mono">{{ c.ship }}</span>
                  <ExportKnown :resource="c.name" :ship="c.ship" />
                  <DoleKnown :resource="c.name" :ship="c.ship" />
                </div>
              </li>
            </ul>
            <hr />
          </li>
        </ul>
      </div>
    </div>
  </div>
</template>

<script lang="ts">
import { defineComponent } from "vue";
import { mapState, mapGetters } from "vuex";
import * as peatAPI from "@/api/peat";
import ExportKnown from "@/components/ExportKnown.vue";
import DoleKnown from "@/components/DoleKnown.vue";

export default defineComponent({
  data() {
    return {
      knownPending: true,
    };
  },

  mounted() {
    this.getKnown();
  },

  computed: {
    ...mapState("peat", ["known"]),
    ...mapGetters("peat", [
      "knownChatsByGroup",
      "knownGroups",
      "knownResourcesByGroup",
      "knownChatsByGroup",
      "knownShapeByGroup",
      "filterResourcesByGroup",
    ]),
  },

  methods: {
    getKnown() {
      this.knownPending = true;
      this.$store
        .dispatch("peat/getKnown")
        .then((r) => {
          this.knownPending = false;
          console.log("known r ", r);
        })
        .catch((err) => {
          console.log(err);
        });
    },
    chatsByGroup(groupName: string) {
      return this.knownChatsByGroup(groupName)
    },
    shapeByGroup(shape: string, groupName: string) {
      return this.knownShapeByGroup(shape, groupName)
    },
    resourcesByGroup(groupName: string) {
      return this.filterResourcesByGroup(groupName)
    },
  },

  components: {
    ExportKnown,
    DoleKnown,
  },
});
</script>
