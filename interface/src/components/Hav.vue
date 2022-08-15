<template>
  <div class="tw-w-screen">
    <div class="tw-flex tw-flex-wrap tw-space-between tw-mb-8">
        <div class="tw-grow tw-mb-4">
          <h3 class="tw-text-3xl">Archived resources on filesystem</h3>
        </div>

        <div class="tw-flex-shrink">
          <ImportHav :usingUpload="true" :resource="{}" v-slot="slotProps">
            <v-btn
              color="white"
              variant="tonal"
              class="tw-mr-2 tw-inline-block text-success"
              @click="slotProps.klick"
            >
              <v-icon start>mdi-upload</v-icon>
              upload from disk
            </v-btn>
          </ImportHav>

          <div v-if="false">
            <v-dialog model="uploadOpen">
              <template v-slot:activator="{ props }">
                <v-btn
                  v-bind="props"
                  color="white"
                  variant="tonal"
                  class="tw-mr-2 tw-inline-block text-success"
                  @click="openUpload"
                >
                  <v-icon start>mdi-upload</v-icon>
                  upload from disk
                </v-btn>
              </template>
              <v-card
                class="tw-w-96 tw-border-4 tw-border-primary tw-bg-surface tw-p-4"
              >
                <v-card-title>
                  <div class="tw-flex tw-flex-row tw-justify-between">
                    <h2 class="tw-text-2xl">Upload and Import</h2>
                    <div>
                      <span
                        @click="uploadOpen = !uploadOpen"
                        class="tw-text-sm tw-cursor-pointer tw-underline"
                        >Close</span
                      >
                    </div>
                  </div>
                </v-card-title>
                <v-card-text>
                  <v-file-input
                    show-size
                    counter
                    multiple
                    label="Select .jam files"
                    accept=".jam,text/jam"
                  ></v-file-input>

                  <!--
                  <form action="/apps/peat/upload" method="post" enctype="multipart/form-data">
                    <label
                      >Import Folder:
                      <input
                        type="file"
                        name="files"
                        required=""
                        directory=""
                        mozdirectory=""
                        webkitdirectory="" /></label
                    ><br /><label
                      >Extant Group:
                      <select name="group" required="">
                        <option value="" hidden="">Import to Groups:</option>
                        <option name="group" value="~zod|import-created-group">
                          ~zod %import-created-group
                        </option>
                        <option name="group" value="~zod|first-zod-group">
                          ~zod %first-zod-group
                        </option>
                      </select></label
                    ><br /><label
                      >New Graph Name:
                      <input name="resource" type="text" required="" /></label
                    ><br /><button type="submit">
                      Create Graph -&gt; Add to Group -&gt; Import
                    </button>
                  </form>
                  -->
                </v-card-text>
              </v-card>
            </v-dialog>
          </div> <!-- TODO: remove -->

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

    <div v-if="!havsPending">
      <!-- loaded -->
      <div>
        <ul class="tw-my-4">
          <li
            class="tw-p-4 tw-mb-12 tw-bg-surface tw-border tw-shadow-md tw-rounded-md"
          >
            <!-- hav type -->
            <h4 class="tw-mb-4 tw-text-2xl tw-py-4">
              <span class="font-mono">Collections</span>
            </h4>

            <ul class="tw-my-2">
              <ul class="tw-flex tw-flex-row tw-flex-wrap tw-justify-start">
                <li
                  v-for="l in havLinks"
                  :key="l.resource"
                  class="tw-p-2 tw-w-60 tw-mx-2 tw-my-4 tw-bg-white tw-border tw-rounded-sm"
                >
                  <HavResourceComponent :resource="l" shape="link" />
                </li>
              </ul>
            </ul>
          </li>

          <li
            class="tw-p-4 tw-mb-12 tw-bg-surface tw-border tw-shadow-md tw-rounded-md"
          >
            <!-- hav type -->
            <h4 class="tw-mb-4 tw-text-2xl tw-py-4">
              <span class="font-mono">Chats</span>
            </h4>

            <ul class="tw-my-2">
              <ul>
                <li
                  v-for="c in havChats"
                  :key="c.resource"
                  class="tw-p-2 tw-w-60 tw-mx-2 tw-my-4 tw-bg-white tw-border tw-rounded-sm"
                >
                  <HavResourceComponent :resource="c" shape="chat" />
                </li>
              </ul>
            </ul>
          </li>

          <li
            class="tw-p-4 tw-mb-12 tw-bg-surface tw-border tw-shadow-md tw-rounded-md"
          >
            <!-- hav type -->
            <h4 class="tw-mb-4 tw-text-2xl tw-py-4">
              <span class="font-mono">Notebooks</span>
            </h4>

            <ul class="tw-my-2">
              <ul>
                <li
                  v-for="p in havPublishes"
                  :key="p.resource"
                  class="tw-p-2 tw-w-60 tw-mx-2 tw-my-4 tw-bg-white tw-border tw-rounded-sm"
                >
                  <HavResourceComponent :resource="p" shape="publish" />
                </li>
              </ul>
            </ul>
          </li>

          <li
            class="tw-p-4 tw-mb-12 tw-bg-surface tw-border tw-shadow-md tw-rounded-md"
          >
            <!-- hav type -->
            <h4 class="tw-mb-4 tw-text-2xl tw-py-4">
              <span class="font-mono">DMs</span>
            </h4>

            <ul class="tw-my-2">
              <ul>
                <li
                  v-for="d in havDms"
                  :key="d.resource"
                  class="tw-p-2 tw-w-60 tw-mx-2 tw-my-4 tw-bg-white tw-border tw-rounded-sm"
                >
                  <HavResourceComponent :resource="d" shape="dm" />
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
          <ul class="tw-flex tw-flex-row tw-flex-wrap tw-justify-start">
            <li class="tw-p-2 tw-w-60 tw-mx-2">
              <HavSkeleton />
            </li>
            <li class="tw-p-2 tw-w-60 tw-mx-2">
              <HavSkeleton />
            </li>
            <li class="tw-p-2 tw-w-60 tw-mx-2">
              <HavSkeleton />
            </li>
            <li class="tw-p-2 tw-w-60 tw-mx-2">
              <HavSkeleton />
            </li>
            <li class="tw-p-2 tw-w-60 tw-mx-2">
              <HavSkeleton />
            </li>
          </ul>
        </li>
      </ul>
      <ul class="tw-my-4">
        <li
          class="tw-p-2 tw-mb-8 tw-bg-surface tw-border tw-shadow-md tw-rounded-md"
        >
          <ul class="tw-flex tw-flex-row tw-flex-wrap tw-justify-start">
            <li class="tw-p-2 tw-w-60 tw-mx-2">
              <HavSkeleton />
            </li>
            <li class="tw-p-2 tw-w-60 tw-mx-2">
              <HavSkeleton />
            </li>
          </ul>
        </li>
      </ul>
    </div>
  </div>
</template>

<script lang="ts">
import { HavResource } from "@/types";
import { defineComponent } from "vue";
import { mapState, mapGetters } from "vuex";
// import * as peatAPI from "@/api/peat"
import HavResourceComponent from "@/components/HavResource.vue";
import ImportHav from "@/components/ImportHav.vue";
import HavSkeleton from "@/components/loading-skeletons/HavSkeleton.vue";

import { HavResponse } from "@/types";

export default defineComponent({
  data() {
    return {
      havsPending: false,
      uploadOpen: false,
    };
  },

  mounted() {
    this.getHavs();
  },

  computed: {
    ...mapState("peat", ["hav"]),
    ...mapGetters("peat", ["havChats", "havLinks", "havPublishes", "havDms"]),
  },

  methods: {
    getHavs() {
      this.havsPending = true;
      this.$store.dispatch("peat/getHav").then((response: HavResponse) => {
        console.log(response);
        this.havsPending = false;
      });
    },

    openUpload() {
      this.uploadOpen = true;
    },
  },

  components: {
    HavResourceComponent,
    HavSkeleton,
    ImportHav,
  },
});
</script>
