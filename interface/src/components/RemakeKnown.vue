<template>
  <v-dialog v-model="remakeOpen">
    <template v-slot:activator="{ props }">
      <v-btn
        v-bind="props" color="success"
        text="white"
        @click="openRemake"
      >
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
              <span>The resource will be re-created with a new name (which can be the same as the old name) in the group of your choosing.</span>
            </v-tooltip>
          </div>
          <v-form ref="form" v-model="formValid">
              <v-row>
                <v-col cols="12">
                  <v-select
                    :items="groupOptions"
                    label="New group"
                    required
                    v-model="newGroup"
                    :loading="adminPending"
                    :disabled="groupOptions.length === 0"
                    :rules="[(v) => !!v || 'Must choose a group']"
                    persistent-hint
                    :hint="groupOptions.length === 0 ? 'You aren\'t the admin of any groups' : ''"
                    hide-details="auto"
                  />
                </v-col>
              </v-row>
              <v-row>
                <v-col cols="12">
                  <v-text-field
                    label="New resource name"
                    v-model="newResourceName"
                    :rules="nameRules"
                    hide-details="auto"
                  />
                </v-col>
              </v-row>
              <v-row>
                <v-col cols="12" class="tw-text-right">
                  <div>
                    <v-btn
                      color="success"
                      text="white"
                      @click="remake"
                      :disabled="!formValid"
                    >Remake {{ ship }}'s {{ resource }}</v-btn
                    >
                  </div>
                </v-col>
              </v-row>
          </v-form>
        </div>
      </v-card-text>
    </v-card>
  </v-dialog>

  <div v-if="false">
    <div>
      <div v-if="!remakeOpen">
        <span
          @click="remakeOpen = !remakeOpen"
          class="tw-cursor-pointer tw-text-green-600 tw-underline"
          >Export</span
        >
      </div>
      <div v-if="remakeOpen" class="tw-pa-2"></div>
    </div>
  </div>
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
      newGroup: '',
      newResourceName: '',
      adminPending: false,
      nameRules: [
        (v: string) => !!v || 'Resource name is required',
        (v: string) => /^[\w-]+$/.test(v) || 'Must use kebab-case-for-name; no special characters',
        (v: string) => /^[a-zA-Z].*$/.test(v) || 'First character must be a letter'
      ],
    };
  },

  watch: {
    remakeOpen(val: boolean) {
      if (val && this.groupOptions.length === 0) {
        this.getAdmin()
      }
    },
    newGroup(val: string) {
      if (val) {
        this.validateForm()
      }
    },
  },

  computed: {
    ...mapState("peat", ["admin"]),
    groupOptions() {
      return this.admin.map((a: Admin) => a.name)
    }
  },

  mounted() {
    this.newResourceName = this.resource
  },

  methods: {
    validateForm() {
      this.$refs.form.validate()
    },

    remake() {
      this.validateForm()

      if (!this.formValid) {
        return
      }

      const payload = {
        group: `~${ window.ship } ${ this.newGroup }`,
        'new-resource-name': this.newResourceName,
        'remake-resource': `${ this.ship } ${ this.resource }`,
      };
      this.$store.dispatch("peat/remakeResource", payload).then((r) => {
        console.log("remade ", r);
        // TODO: do something with response?
      });
    },

    getAdmin() {
      this.adminPending = true;
      this.$store.dispatch("peat/getAdmin")
        .then((r) => {
          this.adminPending = false;
          console.log('r ', r)
        })
    },
  },
});
</script>
