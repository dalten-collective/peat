<template>
  <div class="tw-w-screen">
    <div class="tw-flex tw-space-between tw-mb-4">
      <div class="tw-grow">
        <h3 class="tw-text-3xl tw-font-silom">Known Resources</h3>
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
      <span
        v-if="filtersHidden"
        href="#"
        class="tw-cursor-pointer tw-text-success tw-underline"
        @click="filtersHidden = !filtersHidden"
      >
        Show Filters
      </span>
      <span
        v-else
        href="#"
        class="tw-cursor-pointer tw-text-success tw-underline"
        @click="filtersHidden = !filtersHidden"
      >
        Hide Filters
      </span>
    </div>

    <div class="tw-flex tw-flex-col tw-space-between" v-if="!filtersHidden">
      <div
        class="tw-flex tw-gap-y-2 tw-grid tw-grid-cols-1 md:tw-grid-cols-3 tw-gap-x-2 tw-flex-col tw-flex-wrap tw-justify-end tw-mb-2"
      >
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

      <div
        class="tw-flex tw-gap-y-2 tw-flex-col md:tw-flex-row tw-flex-wrap tw-justify-end tw-mb-2"
      >
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

    <div v-if="!knownPending">
      <!-- loaded -->
      <div>
        <div class="tw-text-right tw-mb-2">
          <span
            href="#"
            class="tw-cursor-pointer tw-text-success tw-underline"
            @click="toggleExpandCollapseAll"
          >
            Expand/Collapse All
          </span>
        </div>
        <ul class="tw-my-4">
          <p
            v-if="filteredGroups.length === 0"
            class="tw-p-4 tw-mb-12 tw-bg-white tw-border tw-shadow-md tw-rounded-md"
          >
            No resources match these filters
          </p>

          <v-expansion-panels
            v-else
            v-model="openPanels"
            v-for="pair in filteredGroups"
            :key="pair[0]"
            multiple
          >
            <v-expansion-panel
              class="tw-p-4 tw-mb-2 tw-bg-white tw-rounded-md"
              :value="pair[0]"
            >
              <v-expansion-panel-title>
                <div class="tw-w-full tw-flex tw-flex-row tw-justify-between">
                  <div class="tw-flex-grow tw-text-left tw-text-xl">
                    {{ pair[0] }}
                  </div>

                  <div class="tw-flex-shrink tw-flex tw-flex-row tw-flex-wrap">
                    <v-tooltip location="top">
                      <template v-slot:activator="{ props }">
                        <v-chip
                          v-bind="props"
                          v-if="pair[1].chats.length > 0"
                          variant="outlined"
                          label
                          size="small"
                          color="info"
                          class="mr-2"
                        >
                          <v-icon start icon="mdi-chat-outline"> </v-icon>
                          {{ pair[1].chats.length }}
                        </v-chip>
                      </template>
                      <span>
                        {{ pair[1].chats.length }} chat{{
                          pair[1].chats.length === 1 ? `` : `s`
                        }}
                      </span>
                    </v-tooltip>

                    <v-tooltip location="top">
                      <template v-slot:activator="{ props }">
                        <v-chip
                          v-bind="props"
                          v-if="pair[1].links.length > 0"
                          variant="outlined"
                          label
                          size="small"
                          color="info"
                          class="mr-2"
                        >
                          <v-icon start icon="mdi-image-multiple-outline">
                          </v-icon>
                          {{ pair[1].links.length }}
                        </v-chip>
                      </template>
                      <span>
                        {{ pair[1].links.length }} collection{{
                          pair[1].links.length === 1 ? `` : `s`
                        }}
                      </span>
                    </v-tooltip>

                    <v-tooltip location="top">
                      <template v-slot:activator="{ props }">
                        <v-chip
                          v-bind="props"
                          v-if="pair[1].publishes.length > 0"
                          variant="outlined"
                          label
                          size="small"
                          color="info"
                          class="mr-2"
                        >
                          <v-icon start icon="mdi-notebook"> </v-icon>
                          {{ pair[1].publishes.length }}
                        </v-chip>
                      </template>
                      <span>
                        {{ pair[1].publishes.length }} notebook{{
                          pair[1].publishes.length === 1 ? `` : `s`
                        }}
                      </span>
                    </v-tooltip>
                  </div>
                </div>
              </v-expansion-panel-title>

              <v-expansion-panel-text>
                <ul class="tw-my-2">
                  <li
                    v-for="c in filteredResources(pair[1].chats, pair[0])"
                    :key="c.name"
                    class="tw-p-2 tw-my-4 tw-bg-white tw-border tw-rounded-peat"
                  >
                    <KnownResource
                      :resource="c"
                      shape="chat"
                      :group="pair[0]"
                    />
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
              </v-expansion-panel-text>
            </v-expansion-panel>
          </v-expansion-panels>
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
      openPanels: [],
      knownPending: true,
      adminOnly: "all",
      showAllExportStatus: "all",
      textSearch: "",
      groupFilter: "",
      filtersHidden: false,
    };
  },

  mounted() {
    this.getKnown();
  },

  watch: {
    groupFilter(val) {
      if (val == "" || val == null || val == undefined) {
        this.openPanels = [];
      } else {
        this.openPanels = [val];
      }
    },
    textSearch(val) {
      if (val == "" || val == null) {
        this.openPanels = [];
      } else {
        this.openPanels = this.filteredGroups.map(g => g[0])
      }
    },
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
      let g = [];
      if (this.groupFilter) {
        g = this.resourcesByGroup(this.groupFilter);
      } else {
        g = this.resourcesByGroup("");
      }

      g = g.filter((g) => {
        if (this.groupWillBeEmpty(g)) {
          return false;
        }
        return true;
      });

      return g;
    },
  },

  methods: {
    groupResources(group) {
      return (
        group[1].chats.length +
        group[1].links.length +
        group[1].publishes.length
      );
    },

    toggleExpandCollapseAll() {
      if (this.openPanels.length === 0) {
        this.openPanels = this.filteredGroups.map(g => g[0])
      } else {
        this.openPanels = []
      }
    },

    getKnown() {
      this.knownPending = true;
      this.$store
        .dispatch("peat/getKnown")
        .then((r) => {
          this.knownPending = false;
        })
        .catch((err) => {
          console.log(err);
        });
    },
    isAdmin(resource, groupName) {
      return this.amAdmin(resource, groupName);
    },
    isSaved(resource) {
      return this.isRecurringSaved({
        name: resource.name,
        ship: resource.ship,
      });
    },

    filteredResources(resources, groupName) {
      let r = resources;

      if (this.textSearch === "") {
        r = r;
      } else {
        r = r.filter((r) => {
          // remove all heps and spaces from search term
          const searchMashup = this.textSearch.replaceAll(/[-\s]/g, "");
          // compare this to all groups/resources with same treatment
          const resourceNameMashup = r.name.replaceAll(/[-\s]/g, "");
          const groupNameMashup = groupName.replaceAll(/[-\s]/g, "");
          return ( // join group and resource name search
              groupNameMashup.toLowerCase().startsWith(searchMashup.toLowerCase()) ||
              resourceNameMashup.toLowerCase().startsWith(searchMashup.toLowerCase()
            )
          );
        });
      }

      if (this.adminOnly === "all") {
        r = r;
      }
      if (this.adminOnly === "admin") {
        r = r.filter((r) => {
          if (this.isAdmin(r, groupName)) {
            return true;
          }
          return false;
        });
      }
      if (this.adminOnly === "not") {
        r = r.filter((r) => {
          if (this.isAdmin(r, groupName)) {
            return false;
          }
          return true;
        });
      }

      if (this.showAllExportStatus === "all") {
        r = r;
      }
      if (this.showAllExportStatus === "auto") {
        r = r.filter((r) => {
          if (this.isSaved(r)) {
            return true;
          }
          return false;
        });
      }
      if (this.showAllExportStatus === "none") {
        r = r.filter((r) => {
          if (this.isSaved(r)) {
            return false;
          }
          return true;
        });
      }

      return r;
    },

    groupWillBeEmpty(group) {
      if (
        this.filteredResources(group[1].links, group[0]).length === 0 &&
        this.filteredResources(group[1].chats, group[0]).length === 0 &&
        this.filteredResources(group[1].publishes, group[0]).length === 0
      ) {
        return true;
      }
      return false;
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
