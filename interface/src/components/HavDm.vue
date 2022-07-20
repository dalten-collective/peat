<template>
  <div>
    <ul>
      <li>name: {{ resource.resource }}</li>
      <li>length: {{ resource.length }}</li>
      <hr/>
    </ul>
    <button @click="importResource">Import DMs</button>

    <div v-if="importDoneShow">
      <span>{{ importDoneMessage }}</span>
      <a href="#" @click="importDoneShow = false; importDoneMessage = ''">Okay!</a>
    </div>
  </div>
</template>

<script>
import { defineComponent } from 'vue';

export default defineComponent({
    props: [
      'resource'
    ],

    data() {
      return {
        importPending: false,
        importDoneMessage: '',
        importDoneShow: false,
      }
    },

    methods: {
      // TODO: add warning before clicking.
      importResource() {
        this.importPending = true;
        this.importDoneShow = true;
        this.importDoneMessage = "Importing..."
        
        const payload = {
          folder: this.resource.resource,
          groupName: 'groups',
          newResourceName: 'dms',
        }
        this.$store.dispatch("peat/importResource", payload).then((r) => {
          this.importPending = false;
          this.importDoneMessage = `Importing DMs has begun. Check your groups app in a little while`;
          this.importDoneShow = true;
        });
      }
    }
})
</script>