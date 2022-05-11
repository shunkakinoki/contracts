// SPDX-License-Identifier: MIT

pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../HelloWorld.sol";

contract HelloWorldTest is Test {
  HelloWorld private helloWorld;

  function setUp() public {
    helloWorld = new HelloWorld();
  }

  function testGreetIsHelloWorld() public {
    // Get the bytes32 storage for uint address
    // Loads a storage slot from an address
    // In this case, we get the hellow world indice in slot 0
    bytes32 greet = vm.load(address(helloWorld), bytes32(uint256(0)));
    emit log_uint(uint256(greet));
    console2.logBytes32(greet);
    assertEq(bytes32(greet), bytes32("Hello World"));
  }
}
