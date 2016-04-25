SessionsService = require './sessions_service.coffee'

class AuthService
  contructor: ->
    this.sync()

  login_with_credentials: (email, password) ->
    SessionsService.start({strategy: 'credentials', email: email, password: password})

  login_via_token: (token) ->
    SessionsService.start({strategy: 'token', token: token})

  logout: () ->
    SessionsService.end()

  sync: ->
    SessionsService.current()

module.exports = new AuthService
