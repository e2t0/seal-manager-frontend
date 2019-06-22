<template>
  <div>
    <verification-drop-box @fileDropped="verify"/> 
    <form v-on:submit.prevent class="form text-left my-3 px-4 py-2">
      <div class="form-group">HELLO {{foobar}} FOOBAR
        <label for="delegation-file-hash">Delegation File Hash *</label>
        <input  class="form-control" v-model="delegationFileHash" id="delegation-file-hash" type="text" required/>
        <small class="form-text text-muted">Filehash of the certified document of the delegee</small>
      </div>
      <div class="form-group">HELLO {{delegeeName}} FOOBAR
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
import hashingService from '../../lib/hashing-service.js'

export default {
  name: 'Main',
  components: {
    Datepicker,
    VerificationDropBox
  },
  data () {
    return {
      delegationFileHash: '',
      foobar:'',
      delegeeName: '',
      deactivateDate: '',
      sealEvent: null,
      pending: false,
      verificationItems: [],
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

        this.verificationItems.forEach(async (item, i) => {
          const hash = await hashingService.hashFile(item.file)
          Vue.set(this.foobar, hash)
          console.log(hash)
        })
      } catch (e) {
        console.log(e)
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
