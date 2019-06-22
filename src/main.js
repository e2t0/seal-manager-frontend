import Vue from 'vue'
import App from './App'
import router from './router'
import { store } from './store/'
import BootstrapVue from 'bootstrap-vue'
import 'bootstrap/dist/css/bootstrap.css'
import 'bootstrap-vue/dist/bootstrap-vue.css'
import i18n from './i18n'

Vue.use(BootstrapVue)

Vue.config.productionTip = false

//eslint-disable-next-line no-new
new Vue({
  el: '#app',
  i18n,
  router,
  store,
  components: { App },
  template: '<App/>'
})
