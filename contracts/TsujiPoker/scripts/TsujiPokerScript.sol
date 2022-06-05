// SPDX-License-Identifier: MIT

pragma solidity ^0.8.13;

import "../src/TsujiPoker.sol";
import "forge-std/Script.sol";

contract TsujiPokerScript is Script {
  TsujiPoker public nft;

  function run() external {
    vm.startBroadcast();
    nft = new TsujiPoker();
    vm.stopBroadcast();
  }
}
