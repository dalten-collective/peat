<template>
  <div>
    <ul>
      <li>name: {{ resource.resource }}</li>
      <li>length: {{ resource.length }}</li>
      <hr/>
    </ul>

    <form class="w-1/2">
      <div class="form-group">
        <label>
          <span class="form-label">Group Name</span>
          <input type="text" v-model="newGroupName" placeholder="group name"/>
        </label>
      </div>

      <div class="form-group">
        <label>
          <span class="form-label">Resource Name</span>
          <input type="text" v-model="newResourceName" placeholder="new name"/>
        </label>
      </div>

      <div class="form-action">
        <button @click="importResource">Import {{ `${ newGroupName != '' ? 'under ' + newGroupName + ' group' : '' }` }}</button>
      </div>

      <div class="form-status" :class="formStatus" v-if="importDoneShow">
        <span>{{ importDoneMessage }}</span>
        <footer v-if="clearStatusShow">
          <a href="javascript:void(0)" @click="resetForm">Okay!</a>
        </footer>
      </div>

    </form>
  </div>
</template>

<script lang="ts">
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
        clearStatusShow: false,
        formStatus: '',
      }
    },

    methods: {
      // TODO: add warning before clicking.
      importResource() {
        this.importPending = true;
        this.importDoneShow = true;
        this.importDoneMessage = "Importing..."
        this.clearStatusShow = false;
        this.importDoneMessage = "Import started, please wait a moment..."
        this.formStatus = '';
        
        const payload = {
          folder: this.resource.resource,
          groupName: this.newGroupName,
          newResourceName: this.newResourceName,
        }
        this.$store.dispatch("peat/importResource", payload).then((r) => {
          this.formStatus = 'success';
          this.importDoneMessage = `Importing ${ this.newResourceName } to the ${ this.newGroupName } group has begun. Check your groups app in a little while`;
          this.importDoneShow = true;
        }).catch(e => {
          this.formStatus = 'error';
          this.importDoneShow = true;
          this.importDoneMessage = `Something went wrong`;
        }).finally(() => {
          this.importPending = false;
          this.clearStatusShow = true;
        });
      },

      resetForm() {
        this.importDoneMessage = '';
        this.importDoneShow = false;
        this.importPending = false;
        this.formStatus = '';
      },
    }
})
</script>