<template>
  <div v-if="!!isSaved">Last saved index: {{ isSaved['last-index-captured'] }}</div>
</template>

<script lang="ts">
import { defineComponent } from "vue";
import { mapGetters } from "vuex";

export default defineComponent ({
  props: [
    'resource',
  ],

  computed: {
    ...mapGetters("peat", ["isRecurringSaved"]),
    isSaved() {
      return this.isRecurringSaved(this.resource)
    },
  },
})
</script>
