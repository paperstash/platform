class SessionsService
  current: ->
    if @session
      @session.promise()
    else
      $.Deferred().reject({error: 'unauthenticated', details: 'Have yet to login!'})

  start: (using) ->
    if using.strategy == 'credentials'
      this.start_via_credentials(using.email, using.password)
    else if using.strategy == 'token'
      this.start_via_token(using.token)
    else
      $.Deferred().reject({error: 'unimplemented', details: 'No such strategy exists!'})

  start_via_credentials: (email, password) ->
    @session = $.Deferred()
    $.post "#{PaperStash.API.BASE}/login/via/credentials", {email: email, password: password}
      .done (session) =>
        @session.resolve(session)
      .fail () =>
        @session.reject()
    @session.promise()

  start_via_token: (token) ->
    @session = $.Deferred()
    $.post "#{PaperStash.API.BASE}/login/via/token", {token: token}
      .done (session) =>
        @session.resolve(session)
      .fail () =>
        @session.reject()
    @session.promise()

  end: () ->
    dfd = $.Deferred()
    $.post "#{PaperStash.API.BASE}/logout"
      .done () =>
        @session = $.Deferred().reject()
        dfd.resolve()
      .fail () =>
        dfd.reject()
    dfd.promise()

module.exports = new SessionsService
