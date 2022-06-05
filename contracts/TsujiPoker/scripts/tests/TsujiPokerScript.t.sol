// SPDX-License-Identifier: MIT

pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../TsujiPokerScript.sol";

contract TsujiPokerScriptTest is Test {
  TsujiPokerScript private script;

  function setUp() public {
    script = new TsujiPokerScript();
    script.run();
  }

  address kaki = address(0x4fd9D0eE6D6564E80A9Ee00c0163fC952d0A45Ed);

  function testKakiMint() public {
    vm.deal(kaki, 1 ether);
    assertEq(script.nft().rankOf(kaki), 9);
    vm.prank(kaki);
  }
}
