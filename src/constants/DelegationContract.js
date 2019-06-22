const address = '0x1d2e1134f5b0be738265718328617ecbd7a249bb'
const ABI = [
  {
    "constant": false,
    "inputs": [
      {
        "name": "_delegationHash",
        "type": "bytes32"
      },
      {
        "name": "_delegeeName",
        "type": "bytes32"
      },
      {
        "name": "_endtimestamp",
        "type": "uint256"
      }
    ],
    "name": "register",
    "outputs": [
      {
        "name": "success",
        "type": "bool"
      }
    ],
    "payable": false,
    "stateMutability": "nonpayable",
    "type": "function"
  },
  {
    "constant": false,
    "inputs": [
      {
        "name": "_address",
        "type": "address"
      }
    ],
    "name": "removeSealAdmin",
    "outputs": [],
    "payable": false,
    "stateMutability": "nonpayable",
    "type": "function"
  },
  {
    "constant": true,
    "inputs": [
      {
        "name": "_hash",
        "type": "bytes32"
      }
    ],
    "name": "verifyFile",
    "outputs": [
      {
        "name": "issuer",
        "type": "address"
      },
      {
        "name": "issuerName",
        "type": "bytes32"
      },
      {
        "name": "issuerImg",
        "type": "bytes32"
      },
      {
        "name": "revoked",
        "type": "bool"
      },
      {
        "name": "issuerVerified",
        "type": "bool"
      },
      {
        "name": "startTimestamps",
        "type": "uint256[]"
      },
      {
        "name": "endTimestamps",
        "type": "uint256[]"
      }
    ],
    "payable": false,
    "stateMutability": "view",
    "type": "function"
  },
  {
    "constant": false,
    "inputs": [
      {
        "name": "_delegeeAddress",
        "type": "address"
      }
    ],
    "name": "revoke",
    "outputs": [
      {
        "name": "success",
        "type": "bool"
      }
    ],
    "payable": false,
    "stateMutability": "nonpayable",
    "type": "function"
  },
  {
    "constant": false,
    "inputs": [
      {
        "name": "_eternalDelegateStorage",
        "type": "address"
      }
    ],
    "name": "setEternalDelegateStorage",
    "outputs": [],
    "payable": false,
    "stateMutability": "nonpayable",
    "type": "function"
  },
  {
    "constant": false,
    "inputs": [
      {
        "name": "_certifaction",
        "type": "address"
      }
    ],
    "name": "setCertifaction",
    "outputs": [],
    "payable": false,
    "stateMutability": "nonpayable",
    "type": "function"
  },
  {
    "constant": false,
    "inputs": [
      {
        "name": "_address",
        "type": "address"
      }
    ],
    "name": "addSealAdmin",
    "outputs": [],
    "payable": false,
    "stateMutability": "nonpayable",
    "type": "function"
  },
  {
    "inputs": [],
    "payable": false,
    "stateMutability": "nonpayable",
    "type": "constructor"
  },
  {
    "anonymous": false,
    "inputs": [
      {
        "indexed": true,
        "name": "delegee",
        "type": "address"
      }
    ],
    "name": "SealAdminAdded",
    "type": "event"
  },
  {
    "anonymous": false,
    "inputs": [
      {
        "indexed": true,
        "name": "delegee",
        "type": "address"
      }
    ],
    "name": "SealAdminRemoved",
    "type": "event"
  },
  {
    "anonymous": false,
    "inputs": [
      {
        "indexed": true,
        "name": "delegee",
        "type": "address"
      },
      {
        "indexed": false,
        "name": "delegationdochash",
        "type": "bytes32"
      }
    ],
    "name": "DelegationAdded",
    "type": "event"
  },
  {
    "anonymous": false,
    "inputs": [
      {
        "indexed": true,
        "name": "delegee",
        "type": "address"
      }
    ],
    "name": "DelegationRevoked",
    "type": "event"
  }
]

export {address, ABI}
