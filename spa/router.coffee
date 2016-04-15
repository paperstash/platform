window.PaperStash.Router = new Vue.Router
  hashbang: true

PaperStash.Router.map
  '/':
    name: 'home'
    component: require('./components/Home.vue')

  '*':
    name: 'not_found'
    component: require('./components/NotFound.vue')

module.exports = PaperStash.Router
