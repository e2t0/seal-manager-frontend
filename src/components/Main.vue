<template>
  <div class="container">
    <img class="mb-4 logo" src="/img/logo.png" />
    <h2>{{ msg }}</h2>
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
  props: {
    msg: String
  },
  beforeCreate () {
    console.log('registerWeb3 Action dispatched from Main.vue')
    this.$store.dispatch('registerWeb3')
  },
  mounted () {
    console.log('dispatching getContractInstance')
    this.$store.dispatch('getContractInstance')
  },
  data () {
    return {
      amount: null,
      pending: false,
      winEvent: null
    }
  },
  methods: {
    clickNumber (event) {
      console.log(event.target.innerHTML, this.amount)
      this.winEvent = null
      this.pending = true
      this.$store.state.contractInstance().bet(event.target.innerHTML, {
        gas: 300000,
        value: this.$store.state.web3.web3Instance().toWei(this.amount, 'ether'),
        from: this.$store.state.web3.coinbase
      }, (err, result) => {
        if (err) {
          console.log(err)
          this.pending = false
        } else {
          let Won = this.$store.state.contractInstance().Won()
          Won.watch((err, result) => {
            if (err) {
              console.log('could not get event Won()')
            } else {
              this.winEvent = result.args
              this.pending = false
            }
          })
        }
      })
    }
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
