// SPDX-License-Identifier: MIT
// Code from: https://github.com/fracton-ventures/foundry-minimal-proxy-patten

pragma solidity ^0.8.13;

import "@openzeppelin/contracts/proxy/Clones.sol";
import "@openzeppelin/contracts/utils/Address.sol";

contract Factory {
  using Address for address;
  using Clones for address;

  event Deployed(
    address indexed owner,
    address indexed implementation,
    address indexed deployedContract,
    string name,
    string symbol
  );

  function _encode(
    address owner,
    string memory name,
    string memory symbol
  ) internal pure returns (bytes memory) {
    return
      abi.encodeWithSignature(
        "initialize(address,string,string)",
        owner,
        name,
        symbol
      );
  }

  function _deploy(
    address implementation,
    address owner,
    string memory name,
    string memory symbol
  ) internal returns (address) {
    bytes memory data = _encode(owner, name, symbol);
    bytes32 salt = keccak256(abi.encodePacked(data, owner));
    address deployedContract = implementation.cloneDeterministic(salt);
    deployedContract.functionCallWithValue(data, msg.value);
    emit Deployed(owner, implementation, deployedContract, name, symbol);
    return address(deployedContract);
  }

  function deploy(
    address implementation,
    string memory name,
    string memory symbol
  ) public payable returns (address) {
    return _deploy(implementation, msg.sender, name, symbol);
  }
}
