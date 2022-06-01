pragma solidity ^0.8.13;

import "@shunkakinoki/greeter/Greeter.sol";
import "forge-std/Script.sol";

contract GreeterDeploy is Script {
  function run() external {
    vm.startBroadcast();

    Greeter greeter = new Greeter("Hello, World!");
    greeter.greet();
    require(bytes32(bytes(greeter.greet())) == bytes32(bytes("Hello, World!")));
  }
}
