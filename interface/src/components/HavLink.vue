<template>
  <div class="tw-p-2 tw-flex tw-flex-col tw-justify-between">
    <header class="tw-flex tw-justify-between tw-mb-6 tw-items-center tw-flex-grow">
      <div class="tw-flex tw-flex-row tw-items-center tw-mb-2">
        <div class="tw-border-l tw-border-b tw-border-t tw-rounded-sm tw-p-2">
          <span class="tw-text-xl">{{ resource.resource }}</span>
        </div>
      </div>

    </header>

    <footer class="tw-flex tw-flex-row tw-justify-between tw-items-center">
      <div class="tw-flex tw-flex-col tw-align-middle">
        <div>
          <ImportHav :resource="resource" />
        </div>
      </div>
      <div class="tw-basis-1/3 tw-text-right">
        <div class="tw-flex tw-items-center tw-flex-row tw-justify-end">
          <span class="tw-mr-2 tw-text-gray-400">length</span>
          <span class="">{{ resource.length }}</span>
        </div>
      </div>
    </footer>
  </div>

</template>

<script lang="ts">
import { importFromDisk } from '@/api/peat';
import { defineComponent } from 'vue';
import ImportHav from '@/components/ImportHav.vue'

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
    },

    components: {
      ImportHav,
    },
})
</script>
