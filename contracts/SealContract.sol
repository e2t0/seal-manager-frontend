pragma solidity 0.5.9;
//Smart Contract managing delegation data for the Federation of Offical Seal challenge (E2TO SB Hackathon Submission 2019)

import "./IEternalDelegateStorage.sol";

contract ICertifaction {
    //Source: https://github.com/blockfactory-ag/verification/blob/master/packages/verification-client/src/SmartContract.abi.js
    function verifyFile(bytes32 _hash) public view returns(address issuer, uint expiry, bool revoked, bool issuerVerified, bytes32 issuerName, bytes32 issuerImg) {}
}


contract SealContract {

    ICertifaction internal certifaction;
    IEternalDelegateStorage internal eternalDelegateStorage;

    event SealAdminAdded(address indexed delegeeAddress);
    event SealAdminRemoved(address indexed delegeeAddress);
    event DelegationAdded(address indexed delegeeAddress, bytes32 delegationRegistrationHash);
    event DelegationRemoved(address indexed delegeeAddress);

    address internal owner;

    constructor() public {
        owner = msg.sender;
        setCertifaction(0xB6f7E84f4070242B88150138be95b98682566991);
    }

    // Contract Linkage
    function setCertifaction(address _certifaction) public onlyOwner {
        certifaction = ICertifaction(_certifaction);
    }

    function setEternalDelegateStorage(address _eternalDelegateStorage) public onlyOwner {
        eternalDelegateStorage = IEternalDelegateStorage(_eternalDelegateStorage);
    }


    // Access Control
    modifier onlyOwner() {
        require(msg.sender == owner, "Only contract owner can call this function.");
        _;
    }

    modifier onlySealAdmins() {
        require(eternalDelegateStorage.checkSealAdmin(msg.sender) == true, "Only seal admins can call this function.");
        _;
    }

    function addSealAdmin(address _address) public onlyOwner {
        eternalDelegateStorage.addSealAdmin(_address);
        emit SealAdminAdded(_address);
    }

    function removeSealAdmin(address _address) public onlyOwner {
        eternalDelegateStorage.removeSealAdmin(_address);
        emit SealAdminRemoved(_address);
    }

    // Delegations
    function getActiveDelegates() public view returns (address[] memory, bytes32[] memory) {
        return eternalDelegateStorage.getActiveDelegations();
    }

    function registerDelegate(bytes32 _delegationHash, bytes32 _delegeeName, uint _endtimestamp) public onlySealAdmins returns (bool success) {
        require(_delegeeName != bytes32(0));
        (address issuerAddress, bool revoked)=verifyFileCertifaction(_delegationHash);
        require(issuerAddress != address(0) && revoked == false, "Delegation not verifiable");

        if (eternalDelegateStorage.addDelegation(issuerAddress, _delegeeName, now, _endtimestamp) == true) {
            emit DelegationAdded(issuerAddress, _delegationHash);
            return true;
        }
    }

    function removeDelegate(address _delegeeAddress) public onlySealAdmins returns (bool success) {
        eternalDelegateStorage.removeDelegation(_delegeeAddress, now);
        emit DelegationRemoved(_delegeeAddress);
        return true;
    }

    // Hash Verification
    function verifyFile(bytes32 _hash) public view returns (address issuer, bytes32 issuerName, bytes32 issuerImg, bool revoked, bool issuerVerified, uint[] memory startTimestamps, uint[] memory endTimestamps) {
        (issuer, revoked) = verifyFileCertifaction(_hash);
        if (issuer == address(0)) return (issuer, bytes32(0),bytes32(0), false, false, new uint[](0), new uint[](0));
        (issuerName, startTimestamps, endTimestamps) = eternalDelegateStorage.getDelegation(issuer);
        if (issuerName[0] == 0) return (address(0), bytes32(0),bytes32(0), false, false, new uint[](0), new uint[](0));
        return (issuer, issuerName, bytes32(0), revoked, true, startTimestamps, endTimestamps);
    }

    function verifyFileCertifaction(bytes32 _hash) internal view returns (address issuer, bool revoked) {
        (issuer, , revoked, , , ) = certifaction.verifyFile(_hash);
    }
}