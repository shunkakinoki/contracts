// SPDX-License-Identifier: MIT

pragma solidity ^0.8.13;

import "../src/FutaSanBirthday.sol";
import "forge-std/Script.sol";

contract FutaSanBirthdayScript is Script {
  FutaSanBirthday public nft;

  function run() external {
    vm.startBroadcast();
    nft = new FutaSanBirthday();
    nft.mint(address(0xe7236c912945C8B915c7C60b55e330b959801B45));
    vm.stopBroadcast();
  }
}
