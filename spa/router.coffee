window.PaperStash.Router = new Vue.Router
  hashbang: true

PaperStash.Router.map
  '/':
    name: 'home'
    component: require './components/Home.vue'

  '/join':
    name: 'join'
    component: require './components/Join.vue'

  '/login':
    name: 'sessions#login'
    component: require './components/Login.vue'

  '/logout':
    name: 'sessions#logout'
    component: require './components/Logout.vue'

  '/email/verify':
    name: 'action'
    component: require './components/Action.vue'
    action: 'email.verify'

  '/password/reset':
    name: 'action'
    component: require './components/Action.vue'
    action: 'password.reset'

  '*':
    name: 'not_found'
    component: require './components/NotFound.vue'

module.exports = PaperStash.Router
