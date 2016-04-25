AuthService = require './services/auth_service.coffee'

module.exports =
  title: "PaperStash"

  sync: ->
    AuthService.sync()
      .done (session) ->
        Vue.set PaperStash.state, 'session', session
      .fail () ->
        # Well, that's no good.
        Vue.set PaperStash.state, 'session', {}

  inject: ->
    Vue = require 'vue'
    Vue.mixin
      data: () ->
        app:
          state: PaperStash.state
