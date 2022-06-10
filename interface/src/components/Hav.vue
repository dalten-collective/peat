<template>
  <button @click="getHavs">Scry havs</button>
  <div v-if="havsPending">
    LOADING
  </div>
  <div v-else>
    <h3>Links</h3>
    <ul>
      <li v-for="l in havLinks" :key="l.resource">
        <HavLink :resource="l" />
      </li>
    </ul>

    <h3>Chats</h3>
    <ul>
      <li v-for="c in havChats" :key="c.resource">
        <HavChat :resource="c" />
      </li>
    </ul>

    <h3>Notebooks</h3>
    <ul>
      <li v-for="p in havPublishes" :key="p.resource">
        <HavPublish :resource="p" />
      </li>
    </ul>

    <h3>DMs</h3>
    <ul>
      <li v-for="d in havDms" :key="d.resource">
        <HavDm :resource="d" />
      </li>
    </ul>
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
  }
})
</script>

