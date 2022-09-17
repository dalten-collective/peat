<template>
  <v-dialog v-model="remakeOpen">
    <template v-slot:activator="{ props }">
      <v-btn v-bind="props" color="success" text="white" @click="openRemake">
        <v-icon start>mdi-content-duplicate</v-icon>
        remake</v-btn
      >
    </template>
    <v-card class="tw-w-96 tw-border-4 tw-border-primary tw-bg-surface tw-p-4">
      <v-card-title>
        <div class="tw-flex tw-flex-row tw-justify-between">
          <h2 class="tw-text-2xl">Remake</h2>
          <div>
            <span
              @click="remakeOpen = !remakeOpen"
              class="tw-text-sm tw-cursor-pointer tw-underline"
              >Close</span
            >
          </div>
        </div>
      </v-card-title>

      <v-card-text>
        <hr class="tw-my-4" />

        <div>
          <div class="tw-mb-2">
            <span class="tw-font-bold">Remake resource</span>
            <v-tooltip location="top">
              <template v-slot:activator="{ props }">
                <v-icon
                  v-bind="props"
                  size="x-small"
                  class="tw-ml-1 tw-cursor-pointer tw-mb-2 tw-opacity-50"
                  >mdi-help-circle-outline</v-icon
                >
              </template>
              <span
                >The resource will be re-created with a new name (which can be
                the same as the old name) in the group of your choosing.</span
              >
            </v-tooltip>
          </div>
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
                  label="New resource name"
                  v-model="newResourceName"
                  :rules="resourceNamePresenceRules.concat(nameRules)"
                  required
                  hide-details="auto"
                />
              </v-col>
            </v-row>
            <v-row>
              <v-col cols="12">
                <div class="tw-mb-1">
                  <v-btn
                    color="success"
                    text="white"
                    @click="remake"
                    :loading="remakePending"
                    :disabled="!formValid"
                    >Remake {{ ship }}'s {{ resource }}</v-btn
                  >
                </div>
                <div class="tw-my-2" v-if="formValid">
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
                <div v-if="remakePending">
                  <v-alert type="info" variant="tonal">
                    Remake has started. You might notice your ship hanging while
                    this completes... You can close this page - or watch.
                  </v-alert>
                </div>
                <div v-if="showDone">
                  <v-alert type="success" variant="tonal">
                    Remake complete! Check Groups.
                  </v-alert>
                </div>
              </v-col>
            </v-row>
          </v-form>
        </div>
      </v-card-text>
    </v-card>
  </v-dialog>
</template>

<script lang="ts">
import { defineComponent } from "vue";
import { mapState } from "vuex";
import { Admin } from "@/types";

export default defineComponent({
  props: ["resource", "ship", "currentGroup"],

  data() {
    return {
      formValid: false,
      remakeOpen: false,
      remakePending: false,
      showDone: false,
      newGroupName: "",
      newResourceName: "",
      existingGroupForResource: null,
      adminPending: false,
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

  watch: {
    remakeOpen(val: boolean) {
      if (val && this.groupOptions.length === 0) {
        this.getAdmin();
      }
      if (!val) {
        // closing
        // reset things
        this.remakePending = false;
        this.showDone = false;
        this.newGroupName = "";
        this.newResourceName = "";
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
      if (this.newGroupName === "" && !this.existingGroupForResource) {
        return ["Enter a group name to create a new group for this import"];
      }
      if (this.groupOptions.map(g => g.name).includes(this.newGroupName)) {
        return ["You already have a group with this name"];
      }
      return [true];
    },
  },

  mounted() {
    // this.newResourceName = this.resource;
  },

  methods: {
    validateForm() {
      this.$refs.form.validate();
    },

    existingGroupAsString(entityNamePair) {
      return `${ entityNamePair.entity } - ${ entityNamePair.name }`
    },

    remake() {
      this.validateForm();

      if (!this.formValid) {
        return;
      }

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

      this.remakePending = true;

      const payload = {
        group: `${sanitizedGroupName}`,
        "new-resource-name": this.newResourceName,
        "remake-resource": `${this.ship} ${this.resource}`,
      };
      this.$store
        .dispatch("peat/remakeResource", payload)
        .then((r) => {
          this.showDone = true;
        })
        .finally(() => {
          this.remakePending = false;
        });
    },

    getAdmin() {
      this.adminPending = true;
      this.$store.dispatch("peat/getAdmin").then((r) => {
        this.adminPending = false;
      });
    },
  },
});
</script>
