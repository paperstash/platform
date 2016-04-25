<template>
  <div class="app">
    <app-navigation></app-navigation>
    <div class="app__view">
      <router-view></router-view>
    </div>
    <app-footer></app-footer>
  </div>
</template>

<script lang="coffee">
  Vue = require "vue"

  module.exports =
    name: 'AppComponent'

    components:
      'app-navigation': require './Navigation.vue'
      'app-footer': require './Footer.vue'

    watch:
      'app.state.title': (title, _) ->
        document.title = title
</script>
