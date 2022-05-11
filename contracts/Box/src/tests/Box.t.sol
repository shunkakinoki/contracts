// SPDX-License-Identifier: MIT

pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../Box.sol";

contract BoxTest is Test {
  Box private box;

  function setUp() public {
    box = new Box();
  }

  function testBoxInitialize() public {
    box.initialize(32);
    uint256 number = box.retrieve();
    assertEq(number, 32);
  }

  function testBoxStore() public {
    box.initialize(32);
    box.store(33);
    uint256 number = box.retrieve();
    assertEq(number, 33);
  }
}
