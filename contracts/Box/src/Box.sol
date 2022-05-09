// SPDX-License-Identifier: MIT
// Taken from: https://github.com/tomoima525/solidity-sandbox/pull/1/files

pragma solidity ^0.8.13;

import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";

contract Box is Initializable {
  uint256 private value;

  event ValueChanged(uint256 newValue);

  function initialize(uint256 newValue) public initializer {
    value = newValue;
  }

  function store(uint256 newValue) public {
    value = newValue;
    emit ValueChanged(newValue);
  }

  function retrieve() public view returns (uint256) {
    return value;
  }

  // function increment() public {
  //   value = value + 1;
  //   emit ValueChanged(value);
  // }
}
