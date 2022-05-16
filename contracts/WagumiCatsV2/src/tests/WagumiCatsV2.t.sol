// SPDX-License-Identifier: MIT

pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../WagumiCatsV2.sol";

contract WagumiCatsV2Test is Test {
  WagumiCatsV2 private nft;
  address receiver = address(1);

  function setUp() public {
    nft = new WagumiCatsV2();
  }

  function testPreMintForTreasuryMultiSig() public {
    assertEq(nft.balanceOf(address(receiver)), 0);

    nft.transferOwnership(address(receiver));
    vm.prank(address(receiver), address(receiver));
    nft.preMintForTreasury();

    for (uint256 id = 1; id < 151; id++) {
      assertEq(nft.ownerOf(id), address(receiver));
    }
    assertEq(nft.balanceOf(address(receiver)), 150);
  }
}
