<template>
  <v-dialog v-model="importOpen">
    <template v-slot:activator="{ props }">
      <v-btn v-bind="props" color="success" text="white" @click="openImport">
        <v-icon start>mdi-package-up</v-icon>
        import
      </v-btn>
    </template>

    <v-card class="tw-w-96 tw-border-4 tw-border-primary tw-bg-surface tw-p-4">
      <v-card-title>
        <div class="tw-flex tw-flex-row tw-justify-between">
          <h2 class="tw-text-2xl">Import</h2>
          <div>
            <span
              @click="importOpen = !importOpen"
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
          <div class="tw-form-status" :class="formStatus" v-if="importDoneShow">
            <span>{{ importDoneMessage }}</span>
            <footer v-if="clearStatusShow">
              <a href="javascript:void(0)" @click="resetForm">Okay!</a>
            </footer>
          </div>
        </div>
      </v-card-text>

      <v-card-text v-else>
        <div class="tw-mt-2">
          <v-form ref="form" v-model="formValid">
            <v-row>
              <v-col cols="12">
                <v-select
                  :items="groupOptions"
                  label="Import to existing group"
                  required
                  v-model="existingGroupForResource"
                  :loading="adminPending"
                  :disabled="groupOptions.length === 0"
                  persistent-hint
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
                  :rules="newGroupRules"
                  hint="Peat will create this new group for you"
                />
              </v-col>
            </v-row>
            <v-row>
              <v-col cols="12">
                <v-text-field
                  v-model="newResourceName"
                  label="New resource name"
                  :rules="nameRules"
                />
              </v-col>
            </v-row>

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
              <div class="tw-mb-1">
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
              <div
                class="tw-form-status"
                :class="formStatus"
                v-if="importDoneShow"
              >
                <span>{{ importDoneMessage }}</span>
                <footer v-if="clearStatusShow">
                  <a href="javascript:void(0)" @click="resetForm">Okay!</a>
                </footer>
              </div>
            </div>
          </v-form>
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
  props: ["resource", "dm"],

  data() {
    return {
      importOpen: false,
      adminPending: false,
      newGroupName: "",
      existingGroupForResource: "",
      newResourceName: "",
      formValid: false,
      nameRules: [
        (v: string) => !!v || "Resource name is required",
        (v: string) =>
          /^[\w-]+$/.test(v) ||
          "Must use kebab-case-for-name; no special characters",
        (v: string) =>
          /^[a-zA-Z].*$/.test(v) || "First character must be a letter",
      ],
    };
  },

  computed: {
    ...mapState("peat", ["admin"]),
    groupOptions() {
      return this.admin.map((a: Admin) => a.name);
    },

    chosenGroup() {
      if (this.existingGroupForResource !== "") {
        return this.existingGroupForResource;
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
      if (this.existingGroupForResource === "") {
        return ["Choose an existing group or create a new one"];
      }
      return [true];
    },

    newGroupRules() {
      if (this.newGroupName === "" && this.existingGroupForResource === "") {
        return ["Enter a group name to create a new group for this import"];
      }
      return [true];
    },
  },

  watch: {
    importOpen(val: boolean) {
      if (val && this.groupOptions.length === 0) {
        this.getAdmin();
      }
    },
    newGroupName(val: string) {
      if (val) {
        this.existingGroupForResource = "";
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

    validateForm() {
      this.$refs.form.validate();
    },

    getAdmin() {
      this.adminPending = true;
      this.$store.dispatch("peat/getAdmin").then((r) => {
        this.adminPending = false;
        console.log("r ", r);
      });
    },

    importDMs() {
      this.importPending = true;
      this.importDoneShow = true;
      this.importDoneMessage = "Importing...";
      // this.clearStatusShow = false;
      this.importDoneMessage = "Import started, please wait a moment...";
      this.formStatus = "";

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
      this.importDoneShow = true;
      this.importDoneMessage = "Importing...";
      // this.clearStatusShow = false;
      this.importDoneMessage = "Import started, please wait a moment...";
      this.formStatus = "";

      const payload: {
        folder: string;
        groupName: string;
        newResourceName: string;
      } = {
        folder: this.resource.resource,
        groupName: this.chosenGroup,
        newResourceName: this.newResourceName,
      };

      this.doImport(payload);
    },

    doImport(payload) {
      this.$store
        .dispatch("peat/importResource", payload)
        .then((r) => {
          this.formStatus = "success";
          this.importDoneMessage = `Importing ${this.newResourceName} to the ${this.newGroupName} group has begun. Check your groups app in a little while`;
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
