import Vue from 'vue'
import App from './App.vue'
import { router } from './router/main_router.js'
import Paginate from 'vuejs-paginate'
Vue.component('paginate', Paginate)

new Vue({
  el: '#app',
  render: h => h(App),
  router
})
