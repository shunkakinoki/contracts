// SPDX-License-Identifier: MIT

pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../HelloWorld.sol";

contract HelloWorldTest is Test {
  HelloWorld private helloWorld;

  function setUp() public {
    helloWorld = new HelloWorld();
  }

  function testNumberIs300() public {
    bytes32 leet = vm.load(address(helloWorld), bytes32(uint256(0)));
    emit log_uint(uint256(leet));
    assertEq(uint256(leet), 300);
  }
}
