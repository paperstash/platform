<template>
  <div class="login">
    <form class="login-form" @submit.prevent="attempt">
      <dl class="form-group">
        <dt class="input-label">
          <label for="user[email]" name="user[email]">Email</label>
        </dt>
        <dd>
          <input name="user[email]" v-model="email" size="255" type="email" autofocus required>
        </dd>
      </dl>
      <dl class="form-group">
        <dt class="input-label">
          <label for="user[password]" name="user[password]">Password</label>
        </dt>
        <dd>
          <input name="user[password]" v-model="password" size="255" type="password" required>
        </dd>
      </dl>
      <dl class="form-group">
        <dd>
          <button type="submit">Login</button>
        </dd>
      </dl>
    </form>
  </div>
</template>

<script lang="coffee">
  Vue = require 'vue'

  AuthService = require 'services/auth_service.coffee'

  module.exports = Vue.extend
    name: 'LoginComponent'

    data: ->
      email: ""
      password: ""

    methods:
      attempt: ->
        AuthService.login_via_credentials(@email, @password)
          .done =>
            console.log ":)"
          .fail (reason) =>
            window.alert ":("
</script>
