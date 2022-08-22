<template>
  <v-dialog v-model="importOpen">
    <template v-slot:activator="{ props }">
      <slot :klick="openImport" >
        <v-btn v-bind="props" color="success" text="white" @click="openImport">
          <v-icon start>mdi-package-up</v-icon>
          import
        </v-btn>
      </slot>
    </template>

    <v-card class="tw-w-96 tw-border-4 tw-border-primary tw-bg-surface tw-p-4">
      <v-card-title>
        <div class="tw-flex tw-flex-row tw-justify-between">
          <h2 class="tw-text-2xl">Import</h2>
          <div>
            <span
              @click="importOpen = false"
              class="tw-text-sm tw-cursor-pointer tw-underline"
              >Close</span
            >
          </div>
        </div>
      </v-card-title>

      <v-card-text v-if="dm">
        <div>
          <div class="tw-my-4">
            <span>Import all DMs</span>
          </div>
          <div class="tw-mb-1">
            <v-btn
              color="success"
              :disabled="importPending"
              :loading="importPending"
              text="white"
              @click="importDMs"
            >
              Import
            </v-btn>
          </div>
          <div v-if="importPending">
            <v-alert type="info" variant="tonal">
              Your import has started. You might notice your ship hanging while this completes... You can close this page - or watch.
            </v-alert>
          </div>
          <div v-if="importDoneShow">
            <v-alert type="success" variant="tonal">
              Import complete! Check Groups.
            </v-alert>
          </div>
        </div>
      </v-card-text>

      <v-card-text v-else>
        <div class="tw-mt-2">

          <div v-show="usingUpload">
            <form ref="upload-form" action="upload" method="POST" enctype="multipart/form-data">
              <v-row>
                <v-file-input
                  required
                  show-size
                  counter
                  multiple
                  label="Select folder containing .jam"
                  accept=".jam,text/jam"
                  webkitdirectory
                  directory
                  mozdirectory
                  name="files"
                  v-model="files"
                  :rules="[(f) => f.length > 0 || 'Select a folder with .jam to import']"
                ></v-file-input>
              </v-row>
              <v-row>
                <v-col cols="12">
                  <v-select
                    :items="groupOptions"
                    label="Import to existing group"
                    v-model="existingGroupForResource"
                    id="uploadGroup"
                    name="group"
                    :loading="adminPending"
                    :disabled="groupOptions.length === 0"
                    persistent-hint
                    clearable
                    :item-title="item => `${ item.entity } - ${ item.name }`"
                    item-value="name"
                    return-object
                    :hint="
                      groupOptions.length === 0
                        ? 'You aren\'t the admin of any groups'
                        : ''
                    "
                    hide-details="auto"
                    :rules="existingGroupRules"
                  />
                </v-col>
              </v-row>

              <v-row>
                <v-col cols="12">
                  <v-text-field
                    v-model="newGroupName"
                    id="uploadNugru"
                    name="nugru"
                    label="Import to new group"
                    :rules="newGroupRules.concat(nameRules)"
                    hint="Peat will create this new group for you"
                  />
                </v-col>
              </v-row>
              <v-row>
                <v-col cols="12">
                  <v-text-field
                    v-model="newResourceName"
                    id="uploadResource"
                    name="resource"
                    label="New resource name"
                    :rules="resourceNamePresenceRules.concat(nameRules)"
                  />
                </v-col>
              </v-row>
            </form>
          </div>

          <div v-show="!usingUpload">
            <v-form ref="form" v-model="formValid">
                <v-row>
                  <v-col cols="12">
                    <v-select
                      :items="groupOptions"
                      label="Import to existing group"
                      v-model="existingGroupForResource"
                      :loading="adminPending"
                      :disabled="groupOptions.length === 0"
                      persistent-hint
                      clearable
                      :item-title="item => `${ item.entity } - ${ item.name }`"
                      item-value="name"
                      return-object
                      :hint="
                        groupOptions.length === 0
                          ? 'You aren\'t the admin of any groups'
                          : ''
                      "
                      hide-details="auto"
                      :rules="existingGroupRules"
                    />
                  </v-col>
                </v-row>

                <v-row>
                  <v-col cols="12">
                    <v-text-field
                      v-model="newGroupName"
                      label="Import to new group"
                      :rules="newGroupRules.concat(nameRules)"
                      hint="Peat will create this new group for you"
                    />
                  </v-col>
                </v-row>
                <v-row>
                  <v-col cols="12">
                    <v-text-field
                      v-model="newResourceName"
                      label="New resource name"
                      :rules="resourceNamePresenceRules.concat(nameRules)"
                    />
                  </v-col>
                </v-row>
            </v-form>
          </div> <!-- no upload -->

            <div>
              <div class="tw-my-4">
                <div v-if="formValid">
                  <span
                    >Import
                    {{
                      `as ${chosenGroup != "" ? `"${newResourceName}"` : ""}`
                    }}
                    {{
                      `${
                        chosenGroup != ""
                          ? "under " + chosenGroup + " group"
                          : ""
                      }`
                    }}</span
                  >
                </div>
              </div>
              <div v-if="usingUpload" class="tw-mb-1">
                <div class="tw-mb-1">
                  <v-btn
                    color="success"
                    :disabled="importPending || !formValid || files.length == 0"
                    :loading="importPending"
                    text="white"
                    @click.prevent="fileUpload"
                  >
                    Upload and Import
                  </v-btn>
                </div>
                <div>
                  <v-alert type="warning" variant="tonal">
                    Upon clicking the above button, you'll be redirected to a different page. Come back to Peat afterwards.
                  </v-alert>
                </div>
              </div>
              <div v-else class="tw-mb-1">
                <v-btn
                  color="success"
                  :disabled="importPending || !formValid"
                  :loading="importPending"
                  text="white"
                  @click="importResource"
                >
                  Import
                </v-btn>
              </div>
              <div v-if="importPending">
                <v-alert type="info" variant="tonal">
                  Your import has started. You might notice your ship hanging while this completes... You can close this page - or watch.
                </v-alert>
              </div>
              <div v-if="importDoneShow">
                <v-alert type="success" variant="tonal">
                  Import complete! Check Groups.
                </v-alert>
              </div>
            </div>
        </div>
      </v-card-text>
    </v-card>
  </v-dialog>
</template>

<script lang="ts">
import { defineComponent } from "vue";
import { mapGetters, mapState } from "vuex";
import { Admin } from "@/types";

export default defineComponent({
  props: ["resource", "dm", "usingUpload"],

  data() {
    return {
      files: [],
      importOpen: false,
      adminPending: false,
      importStarted: false,
      importPending: false,
      importDoneShow: false,
      newGroupName: "",
      existingGroupForResource: null,
      newResourceName: "",
      formValid: false,
      resourceNamePresenceRules: [
        (v: string) => !!v || "Resource name is required",
      ],
      nameRules: [
        (v: string) =>
          (!v || /^[\w-]+$/.test(v)) ||
          "Must use kebab-case-for-name; no special characters",
        (v: string) =>
          (!v || /^[a-zA-Z].*$/.test(v)) || "First character must be a letter",
      ],
    };
  },

  computed: {
    ...mapState("peat", ["admin"]),
    groupOptions() {
      return this.admin.slice()
    },

    chosenGroup() {
      if (this.existingGroupForResource) {
        return this.existingGroupAsString(this.existingGroupForResource);
      }
      if (this.newGroupName !== "") {
        return this.newGroupName;
      }
      return "";
    },

    existingGroupRules() {
      if (this.chosenGroup !== "") {
        return [true];
      }
      if (!this.existingGroupForResource) {
        return ["Choose an existing group or create a new one"];
      }
      return [true];
    },

    newGroupRules() {
      const tasRegex = /^[\w-]+$/
      if (this.newGroupName === "" && !this.existingGroupForResource) {
        return ["Enter a group name to create a new group for this import"];
      }
      return [true];
    },
  },

  watch: {
    importOpen(val: boolean) {
      // opening
      if (val && this.groupOptions.length === 0) {
        this.getAdmin();
      } else { // closing
        // reset things
        this.importStarted = false;
        this.newGroupName = "";
        this.importPending = false;
        this.existingGroupForResource = null;
        this.newResourceName = "";
        this.importDoneShow = false;
      }
    },
    newGroupName(val: string) {
      if (val) {
        this.existingGroupForResource = null;
        this.validateForm();
      }
    },
    existingGroupForResource(val: string) {
      if (val) {
        this.newGroupName = "";
        this.validateForm();
      }
    },
    newResourceName(val: string) {
      this.validateForm();
    },
  },

  methods: {
    openImport() {
      this.importOpen = true;
    },

    existingGroupAsString(entityNamePair) {
      return `${ entityNamePair.entity } - ${ entityNamePair.name }`
    },

    validateForm() {
      this.$refs.form.validate();
    },

    getAdmin() {
      this.adminPending = true;
      this.$store.dispatch("peat/getAdmin").then((r) => {
        this.adminPending = false;
      });
    },

    importDMs() {
      this.importPending = true;
      this.importStarted = true;
      this.importDoneShow = true;
      this.importDoneMessage = "Importing...";
      // this.clearStatusShow = false;
      this.importDoneMessage = "Import started, please wait a moment...";
      this.formStatus = "";

      let folder;
      if (this.usingUpload) {
        folder = ''
      } else {
        folder = this.resource.resource
      }
      const payload: {
        folder: string;
        groupName: string;
        newResourceName: string;
      } = {
        folder: this.resource.resource,
        groupName: "groups",
        newResourceName: "dms",
      };

      this.doImport(payload);
    },

    importResource() {
      this.validateForm();
      if (!this.formValid) {
        return;
      }

      this.importPending = true;
      this.importDoneShow = false;
      this.formStatus = "";

      let sanitizedGroupName = '';
      if (
          this.existingGroupForResource &&
          this.existingGroupForResource.hasOwnProperty("entity") &&
          this.existingGroupForResource.hasOwnProperty("name")
        ) {
        sanitizedGroupName = `${ this.existingGroupForResource.entity } ${ this.existingGroupForResource.name }`
      } else {
        sanitizedGroupName = `${ this.chosenGroup }`
      }

      const payload: {
        folder: string;
        groupName: string;
        newResourceName: string;
      } = {
        folder: this.resource.resource,
        groupName: sanitizedGroupName,
        newResourceName: this.newResourceName,
      };

      this.doImport(payload);
    },

    fileUpload() {
      this.importPending = true;
      this.importDoneShow = false;

      if (this.newGroupName) { // using new group, remove existing from DOM
        // remove unused form field:
        document.getElementById('uploadGroup').remove()
      } else { // using existing group, remove new group from DOM, clean up name
        // Make group name conform to ~ship|group-name format:
        const extGroupName = document.getElementById('uploadGroup').value
        document.getElementById('uploadGroup').value = `~${ window.ship}|${ extGroupName }`
        // remove unused form field:
        document.getElementById('uploadNugru').remove()
      }
      // will trigger 'redirect' to sail page:
      this.$refs['upload-form'].submit()
    },

    doImport(payload) {
      this.importStarted = true;
      this.$store
        .dispatch("peat/importResource", payload)
        .then((r) => {
          this.formStatus = "success";
          this.importDoneShow = true;
        })
        .catch((e) => {
          this.formStatus = "error";
          this.importDoneShow = true;
          this.importDoneMessage = `Something went wrong`;
        })
        .finally(() => {
          this.importPending = false;
          this.clearStatusShow = true;
        });
    },
  },
});
</script>
