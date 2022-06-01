// SPDX-License-Identifier: MIT

pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../GreeterScript.sol";

contract GreeterTest is Test {
  GreeterScript private script;

  function setUp() public {
    script = new GreeterScript();
  }

  function testGreetIsHelloWorld() public {
    string memory greet = script.greeter().greet();
    assertEq(bytes32(bytes(greet)), bytes32(bytes("Hello, World!")));
  }

  function testNewGreetIsNewWorld() public {
    script.set();
    string memory greet = script.greeter().greet();
    assertEq(bytes32(bytes(greet)), bytes32(bytes("New World")));
  }
}
