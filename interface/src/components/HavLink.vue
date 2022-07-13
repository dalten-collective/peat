<template>
  <div>
    <ul>
      <li>name: {{ resource.resource }}</li>
      <li>length: {{ resource.length }}</li>
      <hr/>
    </ul>
    <form class="tw-w-1/2">
      <div class="tw-form-group">
        <label>
          <span class="tw-form-label">Group Name</span>
          <input type="text" v-model="newGroupName" placeholder="group name"/>
        </label>
      </div>

      <div class="tw-form-group">
        <label>
          <span class="tw-form-label">New Resource Name</span>
          <input type="text" v-model="newResourceName" placeholder="new name"/>
        </label>
      </div>

      <div class="tw-form-action">
        <button @click="importResource" :disabled="importPending">Import {{ `as ${ newResourceName != '' ? `"${ newResourceName }"` : '' }` }} {{ `${ newGroupName != '' ? 'under ' + newGroupName + ' group' : '' }` }}</button>
      </div>

      <div class="tw-form-status" :class="formStatus" v-if="importDoneShow">
        <span>{{ importDoneMessage }}</span>
        <footer v-if="clearStatusShow">
          <a href="javascript:void(0)" @click="resetForm">Okay!</a>
        </footer>
      </div>
    </form>
  </div>
</template>

<script lang="ts">
import { importFromDisk } from '@/api/peat';
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
        this.clearStatusShow = false;
        this.importDoneMessage = "Import started, please wait a moment..."
        this.formStatus = '';
        
        const payload = {
          folder: this.resource.resource,
          groupName: this.newGroupName,
          newResourceName: this.newResourceName,
        }
        this.$store.dispatch("peat/importResource", payload).then((r) => {
          this.importDoneMessage = `Importing ${ this.newResourceName } to the ${ this.newGroupName } group is underway. Check your groups app in a little while`;
          this.formStatus = 'success';
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
