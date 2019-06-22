<template>
  <div>
    <form v-on:submit.prevent class="form text-left my-3 px-4 py-2">
      <div class="form-group">
        <label class="w-25" for="delegation-file-hash">Delegation File Hash</label>
        <input v-model="delegationFileHash" id="delegation-file-hash" type="text" />
      </div>
      <div class="form-group">
        <label class="w-25" for="delegee-name">Delegee Name</label>
        <input v-model="delegeeName" id="delegee-name" type="text" />
        <small class="form-text text-muted">Name of delegee that is shown when someone verifies the authenticity of a document</small>
      </div>
      <div class="form-group">
        <label class="w-25" for="end-timestamp">End Timestamp</label>
        <input v-model="endTimestamp" id="end-timestamp" type="text" />
      </div>
      <button v-on:click="addVerifiedIssuer()"
              class="btn btn-primary">Create
      </button>
    </form>
  </div>
</template>
<script>

export default {
  name: 'Main',
  data () {
    return {
      delegationFileHash: '',
      delegeeName: '',
      endTimestamp: '',
      sealEvent: null,
      pending: false,
    }
  },
  methods: {
    addVerifiedIssuer() {
      console.log("creating with params")
      console.log(this.delegationFileHash)
      console.log(this.delegeeName)
      console.log(this.endTimestamp)

      let that = this
      let delegeeNameBytes = web3.fromAscii(this.delegeeName)

      this.contract.register(this.delegationFileHash, delegeeNameBytes, this.endTimestamp, {value: 0, gas: 210000}, function(err, result){
      // this.$store.state.contractInstance().register(this.delegationFileHash, this.delegeeName, this.endTimestamp, {value: 0, gas: 2000}, function(err, result){
        if (err) {
          console.log(err)
        } else {
          let SealAdminAdded = that.$store.state.contractInstance().SealAdminAdded()
            SealAdminAdded.watch((err, result) => {
              if (err) {
                console.log('could not get event SealAdminAdded()')
              } else {
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
  },
}

</script>
