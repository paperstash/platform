<template>
  <div class="navigation-actions">
    <template v-if="app.state.session.valid">
      <ul>
        <li>+</li>
        <li>[]</li>
      </ul>
    </template>
    <template v-else>
      <a class="btn btn--primary" v-link="'join'">Join</a>
    </template>
  </div>
</template>

<script lang="coffee">
  Vue = require "vue"

  module.exports =
    name: 'AppNavigationActionsComponent'
</script>
