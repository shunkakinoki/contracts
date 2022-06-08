// SPDX-License-Identifier: MIT

pragma solidity ^0.8.13;

import "../src/TheMerge.sol";
import "forge-std/Script.sol";

contract TheMergeScript is Script {
  TheMerge public script;

  function run() external {
    vm.startBroadcast();
    script = new TheMerge();
    vm.stopBroadcast();
  }
}
