## Contract Deployment Procedure

For inital setup or if a new EternalStorage is needed
1. Deploy EternalDelegateStorage

Steps, in order to deploy new Seal Contract
2. Deploy SealContract
3. On EternalStorage: permitAddress(<address of SealContract>)
4. On SealContract: setEternalStorage(<address of EternalStorage>)
5. On SealContract: addSealAdmin(<address of Seal Admin to be added>)
