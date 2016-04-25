window.PaperStash ?= {}

# TODO(mtwilliams): Have PaperStash.App.Spa inject PaperStash.environment?
PaperStash.environment ||= 'development'

window.Vue = require 'vue'

Vue.config.debug = (PaperStash.environment == 'development')
Vue.config.silent = !Vue.config.debug

Vue.Router = require 'vue-router'
Vue.use Vue.Router

Vue.Resource = require 'vue-resource'
Vue.use Vue.Resource

# TODO(mtwilliams): Setup Vuex.
# Vuex = require 'vuex'
# Vue.use Vuex

# HACK(mtwilliams): Setup for cross-origin requests until we move to vue-resource.
$.ajaxSetup
  crossDomain: true
  xhrFields:
    withCredentials: true

require "./api.coffee"

# Inject global application state.
PaperStash.state = require './state.coffee'
PaperStash.state.inject()

PaperStash.start = ->
  app = require './components/App.vue'
  router = require './router.coffee'
  router.start app, '#spa'

$(document).ready ->
  PaperStash.start()

require "./app.scss"
