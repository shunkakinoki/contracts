// SPDX-License-Identifier: MIT
// Code taken from: https://solidity-by-example.org/view-and-pure-functions/
pragma solidity ^0.8.13;

contract ViewAndPure {
  uint256 public x = 1;

  // Promise not to modify the state.
  function addToX(uint256 y) public view returns (uint256) {
    return x + y;
  }

  // Promise not to modify or read from the state.
  function add(uint256 i, uint256 j) public pure returns (uint256) {
    return i + j;
  }
}
