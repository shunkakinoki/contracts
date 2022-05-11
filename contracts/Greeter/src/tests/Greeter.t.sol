// SPDX-License-Identifier: MIT

pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../Greeter.sol";

contract ContractBTest is Test {
  Greeter private greeter;

  function setUp() public {
    greeter = new Greeter("Hello World");
  }

  function testGreetIsHelloWorld() public {
    string memory greet = greeter.greet();
    assertEq(bytes32(bytes(greet)), bytes32(bytes("Hello World")));
  }
}
