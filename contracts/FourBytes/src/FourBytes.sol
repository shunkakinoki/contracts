// SPDX-License-Identifier: MIT

pragma solidity ^0.8.13;

import "hardhat/console.sol";

contract E {
  uint256 public n;
  address public sender;

  function setN(uint256 _n) public {
    n = _n;
    sender = msg.sender;
  }
}

contract D {
  uint256 public n;
  address public sender;

  function callSetN(address _e, uint256 _n) public {
    _e.call(abi.encodePacked(bytes4(keccak256("setN(uint256)")), _n));
  }
}
