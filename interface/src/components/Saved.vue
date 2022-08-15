<template>
  <div>
    <div>
      <h3>Saved</h3>
      <button @click="getSaved">Scry Saved</button>
    </div>
    <div v-if="savedPending">
      LOADING
    </div>
    <div v-else>
      <div v-if="saved && saved.length == 0">
      </div>
      <div v-else>
        <ul>
          <li v-for="s in saved" :key="s" class="tw-my-4 tw-border tw-rounded-sm tw-p-2">
            <ul>
              <li>{{ s.entity }}</li>
              <li>{{ s.name }}</li>
              <li>{{ s['last-index-captured'] }}</li>
              <li>{{ s.frequency }}</li>
            </ul>
          </li>
        </ul>
      </div>
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
        })
    },
  }

})
</script>
