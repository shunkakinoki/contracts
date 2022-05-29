// SPDX-License-Identifier: MIT

pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import { TsujiPoker } from "../TsujiPoker.sol";

contract TsujiPokerTest is Test {
  TsujiPoker poker;

  function setUp() public {
    poker = new TsujiPoker();
  }

  function testOwnerIsOne() public {
    vm.prank(address(1));
    poker = new TsujiPoker();
    // assertEq(poker.owner, address(0));
  }
}
