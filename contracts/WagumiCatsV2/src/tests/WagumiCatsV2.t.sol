// SPDX-License-Identifier: MIT

pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "../WagumiCatsV2.sol";

contract WagumiCats is ERC721("Wagumi Cats", "WAGUMI") {
  uint256 public tokenId = 1;

  function mint() public returns (uint256) {
    _mint(msg.sender, tokenId);
    return tokenId++;
  }
}

contract WagumiCatsV2Test is Test {
  WagumiCats private og;
  WagumiCatsV2 private nft;
  uint256 internal nftId;
  address receiver = address(1);

  function setUp() public {
    og = new WagumiCats();
    nft = new WagumiCatsV2();
    nftId = og.mint();
  }

  function testPreMintForTreasury() public {
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
