pragma solidity ^0.4.23;

contract Implementation is ProxyAndImplementationCommon {
    modifier deployedFromProxy() {
        require(implementation == address(this));
        _;
    }
    
    function deploy() external deployedFromProxy;
}
