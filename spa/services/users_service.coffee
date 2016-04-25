class UsersService
  join: (name, nickname, email, password) ->
    dfd = $.Deferred()
    $.post "/join", {name: name, nickname: nickname, email: email, password: password}
      .done ->
        dfd.resolve()
      .fail ({error: error, details: details}) ->
        # TODO(mtwilliams): Translate errors.
        # REFACTOR(mtwilliams): Extract error translation.
        dfd.reject({reason: 'unknown'})
    dfd.promise()

module.exports = new UsersService
