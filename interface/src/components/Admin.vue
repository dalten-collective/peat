<template>
  <div>
    <h3>Admin</h3>
    <button @click="getAdmin">Scry Admin</button>
  </div>
  <div v-if="adminPending">
    LOADING
  </div>
  <div v-else>
    <ul>
      <li v-for="a in admin" :key="a">
        {{ a }}
      </li>
    </ul>
  </div>
  
</template>

<script lang="ts">
import { defineComponent } from 'vue';
import { mapState } from 'vuex';

export default defineComponent({
  data() {
    return {
      adminPending: false,
    }
  },

  mounted() {
    this.getAdmin();
  },

  computed: {
    ...mapState("peat", ["admin"]),
  },

  methods: {
    getAdmin() {
      this.adminPending = true;
      this.$store.dispatch("peat/getAdmin")
        .then((r) => {
          this.adminPending = false;
        })
    },
  }

})
</script>
