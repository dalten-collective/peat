<template>
  <div>
    <div>
      <h3 class="tw-text-2xl">
        Known [tk: name for this]
        <v-btn
          icon="mdi-cached"
          size="xs-small"
          :loading="knownPending"
          :disabled="knownPending"
          variant="outlined"
          color="info"
          class="tw-inline-block"
          @click="getKnown"
        ></v-btn>
      </h3>
    </div>

    <div v-if="!knownPending"> <!-- loaded -->
      <div>
        <ul class="tw-my-4">
          <li
            v-for="pair in filterResourcesByGroup('')"
            :key="pair[0]"
            class="tw-p-4 tw-mb-12 tw-bg-surface tw-border tw-shadow-md tw-rounded-md"
          > <!-- group -->
            <h4 class="tw-mb-4 tw-text-xl tw-py-4">
              <span class="font-mono">{{ pair[0] }}</span>
            </h4>

            <ul class="tw-my-2">
              <li
                v-for="c in pair[1].chats"
                :key="c.name"
                class="tw-p-2 tw-my-4 tw-bg-white tw-border tw-rounded-sm"
              >
                <KnownResource :resource="c" shape="chat" :group="pair[0]" />
              </li>
            </ul>

            <ul class="tw-my-2">
              <li
                v-for="l in pair[1].links"
                :key="l.name"
                class="tw-p-2 tw-my-4 tw-bg-white tw-border tw-rounded-sm"
              >
                <KnownResource
                  :resource="l"
                  shape="collection"
                  :group="pair[0]"
                />
              </li>
            </ul>

            <ul class="tw-my-2">
              <li
                v-for="p in pair[1].publishes"
                :key="p.name"
                class="tw-p-2 tw-my-4 tw-bg-white tw-border tw-rounded-sm"
              >
                <KnownResource
                  :resource="p"
                  shape="notebook"
                  :group="pair[0]"
                />
              </li>
            </ul>
          </li>
        </ul>
      </div>
    </div>

    <div v-else>
      <ul class="tw-my-4">
        <li
            class="tw-p-2 tw-mb-8 tw-bg-surface tw-border tw-shadow-md tw-rounded-md"
        >
          <KnownSkeleton />
          <KnownSkeleton />
        </li>
      </ul>
      <ul class="tw-my-4">
        <li
            class="tw-p-2 tw-mb-8 tw-bg-surface tw-border tw-shadow-md tw-rounded-md"
        >
          <KnownSkeleton />
          <KnownSkeleton />
          <KnownSkeleton />
        </li>
      </ul>
    </div>

  </div>
</template>

<script lang="ts">
import { Entity } from "@/types";

import { defineComponent } from "vue";
import { mapState, mapGetters } from "vuex";

import KnownResource from "@/components/KnownResource.vue";
import KnownSkeleton from "@/components/loading-skeletons/KnownSkeleton.vue";

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
      return this.knownChatsByGroup(groupName);
    },
    shapeByGroup(shape: string, groupName: string) {
      return this.knownShapeByGroup(shape, groupName);
    },
    resourcesByGroup(groupName: string) {
      return this.filterResourcesByGroup(groupName);
    },
  },

  components: {
    KnownResource,
    KnownSkeleton,
  },
});
</script>
