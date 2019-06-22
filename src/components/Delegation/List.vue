<template>
  <div class="pt-5 col-md">
    <h3>Active Delegees</h3>
    <ul class="list-group-flush pt-2">
      <li class="list-group-item" v-for="delegate in activeDelegates">
        {{delegate.name}} <button @click="removeDelegate(delegate.address)" type="button" class="btn btn-link">Revoke</button>
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
      }, 2000)
    },
    getActiveDelegates() {
      let that = this
      this.contract.getActiveDelegates.call(function (err, result) {
        let i = 0
        let activeDelegates = []
        result[0].forEach((address) => {
          let activeDelegate = {
            'address': address,
            'name': web3.toAscii(result[1][i])
          }
          activeDelegates[i] = activeDelegate
          i++
        })
        that.$store.dispatch('setActiveDelegates', activeDelegates)
      })
    },
    removeDelegate(pubKey) {
      this.contract.removeDelegate(pubKey, {value: 0, gas: 210000}, function(err){
        if (err) {
          console.log(err)
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
    this.pollActiveDelegates()
  }
}

</script>
