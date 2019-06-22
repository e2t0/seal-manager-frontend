<template>
  <div>
    <verification-drop-box @fileDropped="verify" @drop="drop"/> 
    <form v-on:submit.prevent class="form text-left my-3 px-4 py-2">
      <div class="form-group">
        <label for="delegation-file-hash">Delegation File Hash *</label>
        <input  class="form-control" v-model="delegationFileHash" id="delegation-file-hash" type="text" required/>
        <small class="form-text text-muted">Filehash of the certified document of the delegee</small>
      </div>
      <div class="form-group">
        <label for="delegee-name">Delegee Name *</label>
        <input maxlength="32" class="form-control" v-model="delegeeName" id="delegee-name" type="text" required/>
        <small class="form-text text-muted">Name of delegee that is shown when someone verifies the authenticity of a document</small>
      </div>
      <div class="form-group">
        <label>Revokation date</label>
        <datepicker input-class="datepicker form-control w-50" v-model="deactivateDate"></datepicker>
        <small class="form-text text-muted">Date when to deactivate delegee. If left empty there is no automatic revocation.</small>
      </div>
      <button v-on:click="registerDelegate()"
              class="btn btn-primary">Create
      </button>
    </form>
  </div>
</template>

<style>
  .datepicker.form-control[readonly] {
    background-color: white;
  }
</style>

<script>

import Datepicker from 'vuejs-datepicker';
import '../../assets/styles/styles.scss'
import VerificationDropBox from './VerificationDropBox.vue'

export default {
  name: 'Main',
  components: {
    Datepicker,
    VerificationDropBox
  },
  data () {
    return {
      delegationFileHash: '',
      delegeeName: '',
      deactivateDate: '',
      sealEvent: null,
      pending: false,
    }
  },
  methods: {
    registerDelegate() {
      if (this.delegationFileHash === '' ||
        this.delegeeName === '') {
        return
      }

      let endTimestamp = 0
      if (this.deactivateDate !== '') {
        endTimestamp = this.deactivateDate.getTime();
      }
      let delegeeNameBytes = web3.fromAscii(this.delegeeName)

      this.contract.registerDelegate(this.delegationFileHash, delegeeNameBytes, endTimestamp, {value: 0, gas: 210000}, function(err){
        if (err) {
          console.log(err)
        }
      });

      this.delegationFileHash = ''
      this.delegeeName = ''
      this.deactivateDate = ''

    },
    async verify (files) {
      this.verificationItems = []
      try {
        for (const file of files) {
          this.verificationItems.push({file, name: file.name})
        }

        VueScrollTo.scrollTo(this.$refs.results, 400)

        this.verificationItems.forEach(async (item, i) => {
          const hash = await hashingService.hashFile(item.file)
          const verification = await client.verifyFile(hash)
          Vue.set(this.verificationItems, i, {...this.verificationItems[i], hash, ...verification})

          if (verification.issuer !== null) {
            let [registrationEvent, registrationBlock] = await Promise.all(
              [client.getRegistrationEvent(hash), client.getRegistrationTxBlock(hash)],
            )

            Vue.set(this.verificationItems, i, {...this.verificationItems[i], registrationEvent, registrationBlock})

            if (verification.revoked === true) {
              let [revocationEvent, revocationBlock] = await Promise.all(
                [client.getRevocationEvent(hash), client.getRevocationTxBlock(hash)],
              )
              Vue.set(this.verificationItems, i, {...this.verificationItems[i], revocationEvent, revocationBlock})
            }
          }

          Vue.set(this.verificationItems[i], 'loaded', true)
        })
      } catch (e) {
        console.log(e)
      }
    },
    drop () {
      if (this.draggingDemoDoc) {
        switch (this.draggingDemoDoc) {
          case 'verified':
            this.demoVerified()
            break
          case 'unverified':
            this.demoUnverified()
            break
        }

      }
    },
  },
  computed: {
    contract () {
      return this.$store.state.contractInstance()
    }
  },
}

</script>
