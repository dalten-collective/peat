<template>
  <div v-if="!!isAdmin">ADNIN!</div>
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
