// SPDX-License-Identifier: MIT

pragma solidity ^0.8.13;

contract EVM {
  // 01: ADD
  function add(uint256 a, uint256 b) public pure returns (uint256 result) {
    assembly {
      result := add(a, b)
    }
  }

  // 02: MUL
  function mul(uint256 a, uint256 b) public pure returns (uint256 result) {
    assembly {
      result := mul(a, b)
    }
  }

  // 03: SUB
  function sub(uint256 a, uint256 b) public pure returns (uint256 result) {
    assembly {
      result := sub(a, b)
    }
  }

  // 04: DIV
  function div(uint256 a, uint256 b) public pure returns (uint256 result) {
    assembly {
      result := div(a, b)
    }
  }

  // 05: SDIV
  function sdiv(uint256 a, uint256 b) public pure returns (uint256 result) {
    assembly {
      result := sdiv(a, b)
    }
  }

  // 06: MOD
  function mod(uint256 a, uint256 b) public pure returns (uint256 result) {
    assembly {
      result := mod(a, b)
    }
  }
}
