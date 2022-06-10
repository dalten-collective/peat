<template>
  <button @click="scryHavs">Scry havs</button>
  <div v-if="havsPending">
    LOADING
  </div>
  <div v-else>
    <pre>
    Havs: {{ hav }}
    </pre>
  </div>
</template>

<script lang="ts">
import { HavResource } from '@/types';
import { defineComponent } from 'vue';
import { mapState } from 'vuex';
// import * as peatAPI from "@/api/peat"

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
    this.havsPending = true;
    this.$store.dispatch("peat/getHav").then((response: HavResponse) => {
      console.log(response)
      this.havsPending = false;
    });
  },

  computed: {
    ...mapState("peat", ["hav"]),
  },

  methods: {
  }
})
</script>

