<template>
  <div v-if="!!isAdmin">
    <v-chip variant="outlined" label size="small" color="info">
      ADMIN
    </v-chip>
  </div>
</template>

<script lang="ts">
import { defineComponent } from "vue";
import { mapGetters } from "vuex";

export default defineComponent ({
  props: [
    'resource',
    'group',
  ],

  computed: {
    ...mapGetters("peat", ["amAdmin"]),
    isAdmin() {
      return this.amAdmin(this.resource, this.group)
    },
  },
})
</script>
