<template>
  <div>
    <h3>Saved</h3>
  </div>
  <div v-if="savedPending">
    LOADING
  </div>
  <div v-else>
    <div v-if="saved && saved.length == 0">
    </div>
    <div v-else>
      <ul>
        <li v-for="s in saved" :key="s">
          {{ s }}
        </li>
      </ul>
    </div>
  </div>
  
</template>

<script lang="ts">
import { defineComponent } from 'vue';
import { mapState } from 'vuex';

export default defineComponent({
  data() {
    return {
      savedPending: false,
    }
  },

  mounted() {
    this.getSaved();
  },

  computed: {
    ...mapState("peat", ["saved"]),
  },

  methods: {
    getSaved() {
      this.savedPending = true;
      this.$store.dispatch("peat/getSaved")
        .then((r) => {
          this.savedPending = false;
          console.log('r ', r)
        })
    },
  }

})
</script>
