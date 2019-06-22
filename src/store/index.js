import Vue from 'vue'
import Vuex from 'vuex'
import state from './state'
import getWeb3 from '../util/getWeb3'
import getContract from '../util/getContract'

Vue.use(Vuex)
export const store = new Vuex.Store({
  strict: true,
  state,
  mutations: {
    registerContractInstance (state, payload) {
      state.contractInstance = () => payload
    },
    registerWeb3Instance (state, payload) {
      let result = payload
      let web3Copy = state.web3
      web3Copy.coinbase = result.coinbase
      web3Copy.networkId = result.networkId
      web3Copy.balance = parseInt(result.balance, 10)
      web3Copy.isInjected = result.injectedWeb3
      web3Copy.web3Instance = result.web3
      state.web3 = web3Copy
    },
    setActiveDelegates (state, delegates) {
      state.activeDelegates = delegates
    }
  },
  actions: {
    getContractInstance ({commit}) {
      getContract.then(result => {
        commit('registerContractInstance', result)
      }).catch(e => console.log(e))
    },
    registerWeb3 ({commit}) {
      getWeb3.then(result => {
        commit('registerWeb3Instance', result)
      }).catch(e => {
        console.log('error in action registerWeb3', e)
      })
    },

    setActiveDelegates ({ commit }, delegates) {
      commit('setActiveDelegates', delegates)
    }

  },
  getters: {
    activeDelegates: (state) => {
      return state.activeDelegates
    }
  }
})
