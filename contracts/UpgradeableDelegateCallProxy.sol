pragma solidity ^0.4.23;

contract UpgradeableDelegateCallProxy is ProxyAndImplementationCommon {
    /// @notice Deploy this proxy contract with an initial implementation
    /// @param newImplementation The recipient for all calls
    /// @dev This function may only be called be the current implementation
    constructor(address newImplementation) public {
        implementation = newImplementation;
    }

    /// @notice Upgrade this contract to a new implementation
    /// @param newImplementation The new recipient for all calls
    /// @dev This function may only be called be the current implementation
    function upgradeImplementation(address newImplementation) {
        require (msg.sender == implementation);
        implementation = newImplementation;
        Implementation(this).deploy();
    }

    /// @notice Every function call to this contract will be forwarded to
    ///  the implementation (excluding calls to upgradeImplementation).
    /// @dev This function may only be called be the current implementation
    function() external payable {
        bytes memory data = msg.data;
        address target = implementation;
        
        // solium-disable
        assembly {
            let result := delegatecall(gas, target, add(data, 0x20), mload(data), 0, 0)
            let size := returndatasize

            let ptr := mload(0x40)
            returndatacopy(ptr, 0, size)

            switch result
            case 0 { revert(ptr, size) }
            default { return(ptr, size) }
        }
        // solium-enable
    }
}
