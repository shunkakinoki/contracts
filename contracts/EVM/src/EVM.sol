// SPDX-License-Identifier: MIT

pragma solidity ^0.8.13;

contract EVM {
  function add(uint256 a, uint256 b) public pure returns (uint256 result) {
    assembly {
      result := add(a, b)
    }
  }

  function mul(uint256 a, uint256 b) public pure returns (uint256 result) {
    assembly {
      result := mul(a, b)
    }
  }
}
