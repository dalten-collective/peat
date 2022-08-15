<template>
  <v-app class="tw-font-silom">
    <v-app-bar extended color="primary">
      <template v-slot:prepend>
        <v-app-bar-nav-icon @click="navDrawer = !navDrawer"></v-app-bar-nav-icon>
      </template>

      <v-app-bar-title>
        <router-link :to="{ name: 'work' }">Peat</router-link>
      </v-app-bar-title>

      <template v-slot:append>
          <a href="https://quartus.co" target="_blank" style="position: relative; top: 25px;">
          <div style="position: relative;">
              <v-img
                :src="logo"
                contain
                height="75"
                width="75"
              />
          </div>
            </a>
      </template>
    </v-app-bar>

    <v-navigation-drawer v-model="navDrawer" bottom temporary color="primary">
      <v-list color="primary">
        <v-list-item color="info" v-for="i in items" :key="i.name" :to="{ name: i.route }">
          {{ i.name }}
        </v-list-item>
      </v-list>
    </v-navigation-drawer>

    <v-main class="tw-container tw-mx-auto tw-mt-8">
      <router-view></router-view>
    </v-main>

  </v-app>
</template>

<script lang="ts">
import { defineComponent } from 'vue'
import logo from "@/assets/quartus-logo-white-square-no-text.png";

export default defineComponent({
  name: 'App',
  data() {
    return {
      logo,
      navDrawer: false,
      items: [
        {
          name: "Work",
          value: "work",
          route: "work",
        },
        {
          name: "Learn",
          value: "learn",
          route: "learn",
        },
      ]
    };
  },
  mounted() {
    const deskname = "peat"
    this.startAirlock(deskname);
  },

  unmounted() {
    this.closeAirlocks();
  },

  methods: {
    startAirlock(deskname: string) {
      this.$store.dispatch("ship/openAirlockToAgent", deskname);
    },
    closeAirlocks() {
      this.$store.dispatch("ship/closeAgentAirlocks");
    },
  },
})
</script>
