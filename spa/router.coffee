window.PaperStash.Router = new Vue.Router
  hashbang: true

PaperStash.Router.map
  '/':
    name: 'home'
    component: require('./components/Home.vue')

  '*':
    name: '404'
    component: require('./components/404.coffee')

module.exports = PaperStash.Router
