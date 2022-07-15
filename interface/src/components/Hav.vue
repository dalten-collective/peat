<template>
  <div class="tw-w-screen">
    <div class="tw-flex tw-space-between">
      <div class="tw-grow">
        <h3 class="tw-text-3xl">
          Archived resources on filesystem
        </h3>
      </div>

      <div>
        <v-btn
          :loading="havsPending"
          :disabled="havsPending"
          color="white"
          variant="tonal"
          class="tw-inline-block text-success"
          @click="getHavs"
        >
          <v-icon start>mdi-cached</v-icon>
          refresh
        </v-btn>
      </div>
    </div>

    <div v-if="!havsPending"> <!-- loaded -->
      <div>
        <ul class="tw-my-4">
          <li class="tw-p-4 tw-mb-12 tw-bg-surface tw-border tw-shadow-md tw-rounded-md" > <!-- hav type -->
            <h4 class="tw-mb-4 tw-text-2xl tw-py-4">
              <span class="font-mono">Collections</span>
            </h4>

            <ul class="tw-my-2">
              <ul>
                <li v-for="l in havLinks" :key="l.resource" class="tw-p-2 tw-my-4 tw-bg-white tw-border tw-rounded-sm" >
                  <HavLink :resource="l" />
                </li>
              </ul>
            </ul>
          </li>

          <li
            class="tw-p-4 tw-mb-12 tw-bg-surface tw-border tw-shadow-md tw-rounded-md"
          > <!-- hav type -->
            <h4 class="tw-mb-4 tw-text-2xl tw-py-4">
              <span class="font-mono">Chats</span>
            </h4>

            <ul class="tw-my-2">
              <ul>
                <li
                  v-for="c in havChats"
                  :key="c.resource"
                  class="tw-p-2 tw-my-4 tw-bg-white tw-border tw-rounded-sm"
                >
                  <HavChat :resource="c" />
                </li>
              </ul>
            </ul>
          </li>

          <li
            class="tw-p-4 tw-mb-12 tw-bg-surface tw-border tw-shadow-md tw-rounded-md"
          > <!-- hav type -->
            <h4 class="tw-mb-4 tw-text-2xl tw-py-4">
              <span class="font-mono">Notebooks</span>
            </h4>

            <ul class="tw-my-2">
              <ul>
                <li
                  v-for="p in havPublishes"
                  :key="p.resource"
                  class="tw-p-2 tw-my-4 tw-bg-white tw-border tw-rounded-sm"
                >
                  <HavPublish :resource="p" />
                </li>
              </ul>
            </ul>
          </li>

          <li
            class="tw-p-4 tw-mb-12 tw-bg-surface tw-border tw-shadow-md tw-rounded-md"
          > <!-- hav type -->
            <h4 class="tw-mb-4 tw-text-2xl tw-py-4">
              <span class="font-mono">DMs</span>
            </h4>

            <ul class="tw-my-2">
              <ul>
                <li
                  v-for="d in havDms"
                  :key="d.resource"
                  class="tw-p-2 tw-my-4 tw-bg-white tw-border tw-rounded-sm"
                >
                  <HavDm :resource="d" />
                </li>
              </ul>
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
          <HavSkeleton />
          <HavSkeleton />
        </li>
      </ul>
      <ul class="tw-my-4">
        <li
            class="tw-p-2 tw-mb-8 tw-bg-surface tw-border tw-shadow-md tw-rounded-md"
        >
          <HavSkeleton />
          <HavSkeleton />
          <HavSkeleton />
        </li>
      </ul>
    </div>

  </div>
</template>

<script lang="ts">
import { HavResource } from '@/types';
import { defineComponent } from 'vue';
import { mapState, mapGetters } from 'vuex';
// import * as peatAPI from "@/api/peat"
import HavChat from "@/components/HavChat.vue";
import HavLink from "@/components/HavLink.vue";
import HavPublish from "@/components/HavPublish.vue";
import HavDm from "@/components/HavDm.vue";
import HavSkeleton from "@/components/loading-skeletons/HavSkeleton.vue";

import {
  HavResponse
} from "@/types";

export default defineComponent({
  data() {
    return {
      havsPending: false,
    }
  },

  mounted() {
    this.getHavs();
  },

  computed: {
    ...mapState("peat", ["hav"]),
    ...mapGetters("peat", [
      "havChats",
      "havLinks",
      "havPublishes",
      "havDms",
    ]),
  },

  methods: {
    getHavs() {
      this.havsPending = true;
      this.$store.dispatch("peat/getHav").then((response: HavResponse) => {
        console.log(response)
        this.havsPending = false;
      });
    }
  },

  components: {
    HavChat,
    HavLink,
    HavPublish,
    HavDm,
    HavSkeleton,
  }
})
</script>

