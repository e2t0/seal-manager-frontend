import Web3 from 'web3'
import {address, ABI} from '../constants/DelegationContract'

let getContract = new Promise(function (resolve, reject) {
  let web3 = new Web3(window.web3.currentProvider)
  let delegationContract = web3.eth.contract(ABI)

  delegationContract.eth.defaultAccount = web3.eth.accounts[0]

  let delegationContractInstance = delegationContract.at(address)
  resolve(delegationContractInstance)
})
export default getContract
