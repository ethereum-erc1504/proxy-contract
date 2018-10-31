pragma solidity ^0.4.23;

/// @author William Entriken
/// @dev The proxy and implementation must reserve the same storage location for
///  this shared variable.
/// @dev The proxy and implementation must inherit this contract BEFORE any
///  other inheritances. For example:
///
///  contract YourContract is ProxyAndImplementationCommon, Put, Others, Here
///
contract ProxyAndImplementationCommon {
    /// @dev The current forwarding address for all calls to the proxy
    address private implementation;
}
