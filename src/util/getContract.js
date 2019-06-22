import Web3 from 'web3'
import {address, ABI} from '../constants/DelegationContract'

let getContract = new Promise(function (resolve, reject) {
  let web3 = new Web3(window.web3.currentProvider)
  let delegationContract = web3.eth.contract(ABI)

  // delegationContract.eth.defaultAccount = web3.eth.coinbase
  console.log("account: ", web3.eth.accounts[0])
  delegationContract.eth.defaultAccount = web3.eth.accounts[0]
  // web3.eth.personal.unlockAccount(web3.eth.defaultAccount)

  let casinoContractInstance = delegationContract.at(address)
  // casinoContractInstance = () => casinoContractInstance
  resolve(casinoContractInstance)
})
export default getContract