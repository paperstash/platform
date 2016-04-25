<template>
  <div class="navigation">
    <div class="navigation-inner">
      <div class="navigation-branding" v-link="{'name': 'home'}">
        <div class="branding">
          PaperStash
        </div>
      </div>
      <app-navigation-search></app-navigation-search>
      <app-navigation-actions></app-navigation-actions>
    </div>
  </div>
</template>

<script lang="coffee">
  Vue = require "vue"

  module.exports =
    name: 'AppNavigationComponent'

    components:
      'app-navigation-search':  require './Navigation/Search.vue'
      'app-navigation-actions':  require './Navigation/Actions.vue'
</script>
