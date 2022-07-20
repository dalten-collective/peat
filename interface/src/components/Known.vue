<template>
  <div class="tw-w-screen">

    <div class="tw-flex tw-space-between tw-mb-4">
      <div class="tw-grow">
        <h3 class="tw-text-3xl tw-font-silom">
          Known Resources
        </h3>
      </div>
      <div>
        <v-btn
          :loading="knownPending"
          :disabled="knownPending"
          color="white"
          variant="tonal"
          class="tw-inline-block text-success"
          @click="getKnown"
        >
          <v-icon start>mdi-cached</v-icon>
          refresh
        </v-btn>
      </div>
    </div>

    <div class="tw-text-right tw-mb-2">
      <span v-if="filtersHidden" href="#" class="tw-cursor-pointer tw-text-success tw-underline" @click="filtersHidden = !filtersHidden">
        Show Filters
      </span>
      <span v-else href="#" class="tw-cursor-pointer tw-text-success tw-underline" @click="filtersHidden = !filtersHidden">
        Hide Filters
      </span>
    </div>

    <div class="tw-flex tw-flex-col tw-space-between" v-if="!filtersHidden">
      <div class="tw-flex tw-gap-y-2 tw-grid tw-grid-cols-1 md:tw-grid-cols-3 tw-gap-x-2 tw-flex-col tw-flex-wrap tw-justify-end tw-mb-2">
        <div class="md:tw-basis-1/3">
          <v-select
            color="info"
            v-model="groupFilter"
            label="Group"
            hide-details="auto"
            clearable
            placeholder="All groups"
            :items="filterableGroups"
          ></v-select>
        </div>
        <div class="md:tw-basis-1/3">
          <v-select
            color="info"
            v-model="adminOnly"
            label="Admin status"
            hide-details="auto"
            :items="[
              { title: 'All resources', value: 'all' },
              { title: 'Only show resources I admin', value: 'admin' },
              { title: 'Hide resources I admin', value: 'not' },
            ]"
          ></v-select>
        </div>
        <div class="md:tw-basis-1/3">
          <v-select
            color="info"
            v-model="showAllExportStatus"
            label="Export status"
            hide-details="auto"
            :items="[
              { title: 'All resources', value: 'all' },
              { title: 'Only auto-exporting', value: 'auto' },
              { title: 'Hide auto-exporting', value: 'none' },
            ]"
          ></v-select>
        </div>
      </div>

      <div class="tw-flex tw-gap-y-2 tw-flex-col md:tw-flex-row tw-flex-wrap tw-justify-end tw-mb-2">
        <div class="md:tw-basis-2/3">
          <v-text-field
            prepend-inner-icon="mdi-magnify"
            v-model="textSearch"
            label="Search"
            hide-details="auto"
            clearable
            color="info"
          ></v-text-field>
        </div>
      </div>
    </div>

    <div v-if="!knownPending"> <!-- loaded -->
      <div>
        <ul class="tw-my-4">
          <li v-if="filteredGroups.length === 0"
            class="tw-p-4 tw-mb-12 tw-bg-white tw-border tw-shadow-md tw-rounded-md"
          >
            No resources match these filters
          </li>
          <li
            v-else
            v-for="pair in filteredGroups"
            :key="pair[0]"
            class="tw-p-4 tw-mb-12 tw-bg-white tw-border tw-shadow-md tw-rounded-md"
          > <!-- group -->
              <h4 class="tw-mb-4 tw-text-2xl tw-py-4">
                <span class="font-mono">{{ pair[0] }}</span>
              </h4>

              <ul class="tw-my-2">
                <li
                  v-for="c in filteredResources(pair[1].chats, pair[0])"
                  :key="c.name"
                  class="tw-p-2 tw-my-4 tw-bg-white tw-border tw-rounded-peat"
                >
                  <KnownResource :resource="c" shape="chat" :group="pair[0]" />
                </li>
              </ul>

              <ul class="tw-my-2">
                <li
                  v-for="l in filteredResources(pair[1].links, pair[0])"
                  :key="l.name"
                  class="tw-p-2 tw-my-4 tw-bg-white tw-border tw-rounded-peat"
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
                  v-for="p in filteredResources(pair[1].publishes, pair[0])"
                  :key="p.name"
                  class="tw-p-2 tw-my-4 tw-bg-white tw-border tw-rounded-peat"
                >
                  <KnownResource
                    :resource="p"
                    shape="notebook"
                    :group="pair[0]"
                  />
                </li>
              </ul>

          </li> <!-- group -->
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
      adminOnly: 'all',
      showAllExportStatus: 'all',
      textSearch: '',
      groupFilter: '',
      filtersHidden: false,
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
      "amAdmin",
      "isRecurringSaved",
    ]),
    filterableGroups() {
      return this.knownGroups;
    },
    filteredGroups() {
      let g = []
      if (this.groupFilter) {
        g = this.resourcesByGroup(this.groupFilter)
      } else {
        g = this.resourcesByGroup('')
      }

      g = g.filter((g) => {
        if (this.groupWillBeEmpty(g)) {
          return false
        }
        return true
      })

      return g
    },
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
    isAdmin(resource, groupName) {
      return this.amAdmin(resource, groupName)
    },
    isSaved(resource) {
      return this.isRecurringSaved({ name: resource.name, ship: resource.ship })
    },

    filteredResources(resources, groupName) {
      let r = resources

      if (this.textSearch === '') {
        r = r
      } else {
        r = r.filter((r) => {
          const bits = r.name.split('-')
          return bits.filter((s: string) => {
            return s.toLowerCase().startsWith(this.textSearch.toLowerCase())
          }).length > 0
        })
      }

      if (this.adminOnly === 'all') {
        r = r
      }
      if (this.adminOnly === 'admin') {
        r = r.filter((r) => {
          if (this.isAdmin(r, groupName)) {
            return true
          }
          return false
        })
      }
      if (this.adminOnly === 'not') {
        r = r.filter((r) => {
          if (this.isAdmin(r, groupName)) {
            return false
          }
          return true
        })
      }

      if (this.showAllExportStatus === 'all') {
        r = r
      }
      if (this.showAllExportStatus === 'auto') {
        r = r.filter((r) => {
          if (this.isSaved(r)) {
            return true
          }
          return false
        })
      }
      if (this.showAllExportStatus === 'none') {
        r = r.filter((r) => {
          if (this.isSaved(r)) {
            return false
          }
          return true
        })
      }

      return r
    },

    groupWillBeEmpty(group) {
      if (
        this.filteredResources(group[1].links, group[0]).length     === 0 &&
        this.filteredResources(group[1].chats, group[0]).length     === 0 &&
        this.filteredResources(group[1].publishes, group[0]).length === 0
      ) { return true }
      return false
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
