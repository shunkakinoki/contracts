// SPDX-License-Identifier: MIT

pragma solidity ^0.8.13;

import "hardhat/console.sol";

contract BitsAndBytes {
  function implicitConversion(uint8 y, uint16 z)
    public
    pure
    returns (uint32 x)
  {
    x = y + z;
  }

  function explicitConversion(int256 y) public pure returns (uint256 x) {
    x = uint256(y);
  }

  function cutOff(uint32 a) public pure returns (uint16 b) {
    b = uint16(a);
  }
}
