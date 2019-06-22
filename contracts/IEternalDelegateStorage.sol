pragma solidity 0.5.9;

contract IEternalDelegateStorage {

    // *** Delegation Data ***
    function addDelegation(address _delegeeAddress, bytes32 _delegeeName, uint _starttimestamp, uint _endtimestamp) public returns(bool) {}
    function getDelegation(address _delegeeAddress) public view returns(bytes32 _delegeeName, uint[] memory _starttimestamps, uint[] memory _endtimestamps) {}
    function removeDelegation(address _delegeeAddress, uint _endtimestamp) public {}
    function getActiveDelegations() public view returns(address[] memory _delegeeAddresses, bytes32[] memory _delegeeNames) {}

    // *** Seal Administrator Data ***
    function addSealAdmin(address _sealAdminAddress) public {}
    function checkSealAdmin(address _sealAdminAddress) public view returns(bool exists) {}
    function removeSealAdmin(address _sealAdminAddress) public {}
}
