pragma solidity 0.5.9;

import "./IEternalDelegateStorage.sol";

contract EternalDelegateStorage is IEternalDelegateStorage {

    address owner = msg.sender;

    struct Delegation {
        address delegeeAddress;
        bytes32 delegeeName;
        uint[] startTimestamps;
        uint[] endTimestamps;
    }

    mapping(address => Delegation) internal delegations;
    address[] internal delegationList;

    mapping(address => bool) internal sealAdmins;

    constructor() public {
    }

    // List of contract addresses allowed to call this contract
    mapping(address => bool) internal permittedAddresses;

    modifier onlyOwner () {
        require(msg.sender == owner, "Only contract owner can call this function.");
        _;
    }

    modifier onlyPermitted() {
        require(permittedAddresses[msg.sender] == true, "Sender not allowed to call this function.");
        _;
    }

    // *** Access Management Methods ***
    function permitAddress(address _address) public onlyOwner {
        permittedAddresses[_address] = true;
    }

    function denyAddress(address _address) public onlyOwner {
        permittedAddresses[_address] = false;
    }

    // *** Delegation data Methods ***
    function addDelegation(address _delegeeAddress, bytes32 _delegeeName, uint _starttimestamp, uint _endtimestamp) public onlyPermitted returns (bool) {
        Delegation storage delegation = delegations[_delegeeAddress];
        uint256 numDelegations = delegation.startTimestamps.length;
        require(numDelegations == 0 || delegation.endTimestamps[numDelegations-1] != uint(0), "Not possible to register existing non-revoked delegation");
        delegation.delegeeAddress = _delegeeAddress;
        delegation.delegeeName = _delegeeName;
        delegation.startTimestamps.push(_starttimestamp);
        if (_endtimestamp != uint(0)) {
            delegation.endTimestamps.push(_endtimestamp);
        }
        delegationList.push(_delegeeAddress);
        return true;
    }

    function getDelegation(address _delegeeAddress) public view returns(bytes32 _delegeeName, uint[] memory _starttimestamps, uint[] memory _endtimestamps) {
        Delegation memory delegation = delegations[_delegeeAddress];
        _delegeeName =delegation.delegeeName;
        if (_delegeeName[0] == 0) return (bytes32(0), new uint[](0), new uint[](0));
        _starttimestamps = delegation.startTimestamps;
        _endtimestamps = delegation.endTimestamps;
    }

    function removeDelegation(address _delegeeAddress, uint _endtimestamp) public onlyPermitted {
        Delegation storage delegation = delegations[_delegeeAddress];
        uint256 numDelegations = delegation.startTimestamps.length;
        uint256 endTimestamps = delegation.endTimestamps.length;
        require(numDelegations > 0 &&  (endTimestamps==0 || delegation.endTimestamps[numDelegations-1] == uint(0) || delegation.endTimestamps[numDelegations-1] > now), "Not possible to revoke non-existing or already revoked delegation");
        delegation.endTimestamps.push(_endtimestamp);
    }

    function getActiveDelegations() public view returns(address[] memory _delegeeAddress, bytes32[] memory _delegeeName) {
        uint delegationListSize = delegationList.length;
        address[] memory delegeeAddresses = new address[](delegationListSize);
        bytes32[] memory delegeeNames = new bytes32[](delegationListSize);
        uint activeCount = 0;
        for (uint i = 0; i < delegationListSize; i++) {
            Delegation storage delegation = delegations[delegationList[i]];
            uint256 endTimestamps = delegation.endTimestamps.length;
            if (endTimestamps == 0 || delegation.endTimestamps[endTimestamps-1] == uint(0) || delegation.endTimestamps[endTimestamps-1] > now){
                delegeeAddresses[activeCount] = delegation.delegeeAddress;
                delegeeNames[activeCount] = delegation.delegeeName;
                activeCount++;
            }
        }
        address[] memory delegeeAddressesOut = new address[](activeCount);
        bytes32[] memory delegeeNamesOut = new bytes32[](activeCount);
        activeCount = 0;
        for (uint i = 0; i < delegationListSize; i++) {
            if (delegeeAddresses[i] != address(0)){
                delegeeAddressesOut[activeCount] = delegeeAddresses[i];
                delegeeNamesOut[activeCount] = delegeeNames[i];
                activeCount++;
            }
        }
        return (delegeeAddressesOut, delegeeNamesOut);
    }

    // *** Seal Administrator Data ***
    function addSealAdmin(address _sealAdminAddress) public onlyPermitted {
        sealAdmins[_sealAdminAddress] = true;
    }
    function checkSealAdmin(address _sealAdminAddress) public view returns(bool exists) {
        return sealAdmins[_sealAdminAddress];
    }
    function removeSealAdmin(address _sealAdminAddress) public onlyPermitted {
        sealAdmins[_sealAdminAddress] = false;
    }
}
