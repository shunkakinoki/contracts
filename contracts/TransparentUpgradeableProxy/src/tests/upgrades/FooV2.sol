// SPDX-License-Identifier: MIT

pragma solidity ^0.8.13;

import { Initializable } from "@openzeppelin/contracts/proxy/utils/Initializable.sol";

contract FooV2 is Initializable {
  uint256 public x;

  function initialize() public initializer {
    x = 1;
  }

  function set(uint256 _x) external {
    x = _x;
  }

  function double() external {
    x = 2 * x;
  }

  function triple() external {
    x = 3 * x;
  }
}
