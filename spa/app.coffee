window.PaperStash ?= {}

window.Vue = require 'vue'

Vue.Router = require 'vue-router'
Vue.use Vue.Router

Vue.Resource = require 'vue-resource'
Vue.use Vue.Resource

# TODO(mtwilliams): Setup Vuex.
# Vuex = require 'vuex'
# Vue.use Vuex

PaperStash.start = ->
  $document.ready =>
    app = require './components/App.vue'
    router = require './router.coffee'
    router.start app, '#spa'
