<template>
  <div class="pt-5 col-md">
    <h3>Delegees</h3>
    <ul class="pt-2">
      <li v-for="delegatePubKey in getActiveDelegates()">
          Heisenberg <button @click="removeDelegate(delegatePubKey)" type="button" class="btn btn-link">Revoke</button>
      </li>
    </ul>
  </div>
</template>
<script>

export default {
  name: 'Main',
  methods: {
    getActiveDelegates() {
      let persons = [];
      persons[0] = "0x1";
      persons[1] = "0x2";
      persons[2] = "0x3";
      console.log(persons)
      return persons
      // this.contract.getActiveDelegates(function(error, result){
      //   if (err) {
      //     console.log(err)
      //   } else {
      //     console.log(result)
      //   }
      // });
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
    contract () {
      return this.$store.state.contractInstance()
    }
  }
}

</script>
