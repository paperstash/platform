<template>
  <div class="join">
    <form class="join-form" @submit.prevent="join">
      <dl class="form-group">
        <dt class="input-label">
          <label for="user[name]" name="user[name]">Name</label>
        </dt>
        <dd>
          <input name="user[name]" v-model="user.name" size="255" type="text" autocapitalize autofocus required>
          <p class="note">Use your full name, please.</p>
        </dd>
      </dl>
      <template v-if="user.name">
        <dl class="form-group">
          <dt class="input-label">
            <label for="user[nickname]" name="user[nickname]">Nickname</label>
          </dt>
          <dd>
            <template v-if="automagicallyDetermineNickname">
              <p class="note">Can we call you {{user.nickname}}? <a @click="useAutomaticNickname">Yes</a>/<a @click="useCustomNickname">No</a></p>
            </template>
            <template v-else>
              <template v-if="usingAutomaticNickname">
                Cool. We'll call you {{user.nickname}}!
              </template>
              <template v-else>
                <input name="user[nickname]" v-model="user.nickname" size="255" type="text" autocapitalize required>
              </template>
            </template>
          </dd>
        </dl>
      </template>
      <dl class="form-group">
        <dt class="input-label">
          <label for="user[email]" name="user[email]">Email</label>
        </dt>
        <dd>
          <input name="user[email]" v-model="user.email" size="255" type="email" required>
          <p class="note">We'll never spam you. Nor will we ever share your email with anyone.</p>
        </dd>
      </dl>
      <dl class="form-group">
        <dt class="input-label">
          <label for="user[password]" name="user[password]">Password</label>
        </dt>
        <dd>
          <input name="user[password]" v-model="user.password" size="255" type="password" required>
          <p class="note">Guard this with your life. Or knife. <a href="https://www.youtube.com/watch?v=XnSeKHnB_k8">Maybe a bananna?</a></p>
        </dd>
      </dl>
      <dl class="form-group">
        <dd>
          <button type="submit">Join</button>
        </dd>
      </dl>
    </form>
    <div class="join-spiel">
      <h1>You'll love PaperStash</h1>
      <p>It's full of dank memes.</p>
      <ul>
        <li>Open-source, of course</li>
        <li>Pink-per-capita is always increasing</li>
        <li>Probably other stuff, too</li>
      </ul>
    </div>
  </div>
</template>

<script lang="coffee">
  Vue = require "vue"

  UsersService = require 'services/users_service.coffee'

  module.exports = Vue.extend
    name: 'JoinComponent'

    data: ->
      automagicallyDetermineNickname: true
      usingAutomaticNickname: null
      user:
        name: ""
        nickname: ""
        email: ""
        password: ""

    methods:
      join: (e) ->
        UsersService.join(@user.name, @user.nickname, @user.email, @user.password)
          .done ->
            console.log ":)"
          .fail(reason) ->
            window.alert reason

      useAutomaticNickname: (e) ->
        @usingAutomaticNickname = true
        @automagicallyDetermineNickname = false
        e.preventDefault()

      useCustomNickname: (e) ->
        @usingAutomaticNickname = false
        @automagicallyDetermineNickname = false
        e.preventDefault()

    watch:
      'user.name': (name, _) ->
        if @automagicallyDetermineNickname
          @user.nickname = name.split(' ')[0]
        else if @usingAutomaticNickname
          @automagicallyDetermineNickname = true

</script>
