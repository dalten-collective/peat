<template>
  <div>
    <ul>
      <li>name: {{ resource.resource }}</li>
      <li>length: {{ resource.length }}</li>
      <hr/>
    </ul>
    <input type="text" v-model="newGroupName" placeholder="group name"/>
    <input type="text" v-model="newResourceName" placeholder="new name"/>
    <button @click="importResource">Import {{ `${ newGroupName != '' ? 'under ' + newGroupName + ' group' : '' }` }}</button>

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
        newGroupName: '',
        newResourceName: '',
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
          groupName: this.newGroupName,
          newResourceName: this.newResourceName,
        }
        this.$store.dispatch("peat/importResource", payload).then((r) => {
          this.importPending = false;
          this.importDoneMessage = `Importing ${ this.newResourceName } to the ${ this.newGroupName } group has begun. Check your groups app in a little while`;
          this.importDoneShow = true;
        });
      }
    }
})
</script>