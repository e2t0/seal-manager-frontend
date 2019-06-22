## Contract Deployment Procedure

For inital setup or if a new EternalStorage is needed
1. Deploy EternalDelegateStorage

Steps, in order to deploy new Seal Contract
1. Deploy SealContract
2. On EternalStorage: permitAddress(&lt;address of SealContract>)
3. On SealContract: setEternalStorage(&lt;address of EternalStorage>)
4. On SealContract: addSealAdmin(&lt;address of Seal Admin to be added>)
