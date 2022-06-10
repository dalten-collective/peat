<template>
  <div>
    <pre>{{ resource }}</pre>
  </div>
</template>

<script>
import { defineComponent } from 'vue';

export default defineComponent({
    props: [
      'resource'
    ]
})
</script>