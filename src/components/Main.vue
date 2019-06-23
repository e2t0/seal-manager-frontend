<template>
  <div class="container">
    <img class="mb-4 logo" src="img/logo.png" />
    <h2>{{ msg }}</h2>
    <div v-if="installMetamask" id="install-metamask" class=" mt-3 mt-3 alert alert-warning" role="alert">
     Metamask not found. Please install and login to your account on the ropsten testnet.
    </div>
    <div v-if="loginMetamask" id="login-metamask" class=" mt-3 mt-3 alert alert-warning" role="alert">
      No logged in account found in Metamask. Please login to your metamask account.<br/>If the problem persists consider closing and opening the browser or try with another browser.
    </div>
    <div class="row mt-5">
      <div class="col-md">
      <DelegationCreate></DelegationCreate>
      </div>
      <div class="col-md">
      <DelegationList></DelegationList>
      </div>
    </div>
  </div>
</template>

<style scoped>

</style>

<script>
import DelegationCreate from './Delegation/Create.vue'
import DelegationList from './Delegation/List.vue'

export default {
  name: 'Main',
  components: {
    DelegationCreate,
    DelegationList
  },
  data () {
    return {
      polling: null,
      installMetamask: false,
      loginMetamask: false
    }
  },
  props: {
    msg: String
  },
  methods: {

    checkMetamaskInterval() {
      this.polling = setInterval(() => {
        this.checkMetamask()
      }, 2000)
    },

    checkMetamask() {
      if (typeof web3 === 'undefined') {
        this.installMetamask = true
      } else {
        this.installMetamask = false

        if(typeof web3.eth.accounts[0] === 'undefined') {
          this.loginMetamask = true
        } else {
          this.loginMetamask = false
        }

      }
    }

  },
  beforeCreate () {
    this.$store.dispatch('registerWeb3')
  },
  mounted () {
    this.$store.dispatch('getContractInstance')
    this.checkMetamaskInterval()
  }
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
h3 {
  margin: 40px 0 0;
}
ul {
  list-style-type: none;
  padding: 0;
}
li {
  display: inline-block;
  margin: 0 10px;
}
a {
  color: #42b983;
}
.logo {
  display: block;
  margin-left: auto;
  margin-right: auto;
  max-width: 15.7%;
}
</style>
