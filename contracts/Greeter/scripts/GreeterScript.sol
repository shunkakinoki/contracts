// SPDX-License-Identifier: MIT

pragma solidity ^0.8.13;

import "@shunkakinoki/greeter/Greeter.sol";
import "forge-std/Script.sol";

contract GreeterScript is Script {
  Greeter public greeter;

  function run() external {
    vm.startBroadcast();
    greeter = new Greeter("Hello, World!");
    greeter.greet();
    require(bytes32(bytes(greeter.greet())) == bytes32(bytes("Hello, World!")));
    vm.stopBroadcast();
  }

  function set() external {
    vm.startBroadcast();
    greeter.setGreeting("New World");
    vm.stopBroadcast();
  }
}
