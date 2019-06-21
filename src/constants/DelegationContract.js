const address = '0xc11e40bb7940f49e81992e08048ad42029229aaf'
const ABI = [
  {
    "constant": false,
    "inputs": [
      {
        "name": "_number",
        "type": "uint256"
      }
    ],
    "name": "bet",
    "outputs": [],
    "payable": true,
    "stateMutability": "payable",
    "type": "function"
  },
  {
    "constant": false,
    "inputs": [],
    "name": "kill",
    "outputs": [],
    "payable": false,
    "stateMutability": "nonpayable",
    "type": "function"
  },
  {
    "inputs": [
      {
        "name": "_minBet",
        "type": "uint256"
      },
      {
        "name": "_houseEdge",
        "type": "uint256"
      }
    ],
    "payable": true,
    "stateMutability": "payable",
    "type": "constructor"
  },
  {
    "payable": false,
    "stateMutability": "nonpayable",
    "type": "fallback"
  },
  {
    "anonymous": false,
    "inputs": [
      {
        "indexed": false,
        "name": "_status",
        "type": "bool"
      },
      {
        "indexed": false,
        "name": "_amount",
        "type": "uint256"
      }
    ],
    "name": "Won",
    "type": "event"
  },
  {
    "constant": true,
    "inputs": [],
    "name": "checkContractBalance",
    "outputs": [
      {
        "name": "",
        "type": "uint256"
      }
    ],
    "payable": false,
    "stateMutability": "view",
    "type": "function"
  }
]
export {address, ABI}
