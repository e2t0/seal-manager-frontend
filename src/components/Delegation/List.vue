<template>
  <div class="pt-5 col-md">
    <h3>Active Delegees</h3>
    <ul class="list-group-flush pt-2">
      <li class="list-group-item" v-for="delegatePubKey in activeDelegates">
          Heisenberg <button @click="removeDelegate(delegatePubKey)" type="button" class="btn btn-link">Revoke</button>
      </li>
    </ul>
  </div>
</template>
<script>

export default {
  name: 'Main',
  data () {
    return {
      polling: null
    }
  },
  methods: {
    pollActiveDelegates () {
      this.polling = setInterval(() => {
        this.getActiveDelegates()
      }, 3000)
    },
    getActiveDelegates() {
      this.$store.dispatch('fetchActiveDelegates')
    },
    removeDelegate(pubKey) {
      console.log('removeDelegate: ', pubKey)
      this.contract.removeDelegate(pubKey, {value: 0, gas: 210000}, function(err, result){
        if (err) {
          console.log(err)
        } else {
          let SealAdminAdded = that.$store.state.contractInstance().DelegationRemoved()
          SealAdminAdded.watch((err, result) => {
            if (err) {
              console.log('could not get event SealAdminAdded()')
            } else {
              console.log("watch SealAdminAdded")
              this.sealEvent = result.args
              this.pending = false
            }
          })
        }
      });
    }
  },
  computed: {
    activeDelegates () {
      return this.$store.getters.activeDelegates
    },
    contract () {
      return this.$store.state.contractInstance()
    }
  },
  beforeDestroy () {
    clearInterval(this.polling)
  },
  created () {

    this.getActiveDelegates() //load on active delegates on component create

    this.pollActiveDelegates()
  }
}

</script>
