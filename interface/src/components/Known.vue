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

            <ul class="my-2">
              <li
                v-for="c in pair[1].chats"
                :key="c.name"
                class="p-2 my-4 border rounded-sm"
              >
                <KnownChat :chat="c" :group="pair[0]" />
              </li>
            </ul>

            <ul class="my-2">
              <li
                v-for="l in pair[1].links"
                :key="l.name"
                class="p-2 my-4 border rounded-sm"
              >
                <KnownLink :link="l" :group="pair[0]" />
              </li>
            </ul>

            <ul class="my-2">
              <li
                v-for="p in pair[1].publishes"
                :key="p.name"
                class="p-2 my-4 border rounded-sm"
              >
                <KnownPublish :publish="p" :group="pair[0]" />
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
import { Entity } from "@/types";

import { defineComponent } from "vue";
import { mapState, mapGetters } from "vuex";

import ExportKnown from "@/components/ExportKnown.vue";
import DoleKnown from "@/components/DoleKnown.vue";
import KnownChat from "@/components/KnownChat.vue";
import KnownLink from "@/components/KnownLink.vue";
import KnownPublish from "@/components/KnownPublish.vue";

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
    KnownChat,
    KnownLink,
    KnownPublish,
  },
});
</script>
