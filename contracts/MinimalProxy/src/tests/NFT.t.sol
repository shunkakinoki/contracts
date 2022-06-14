// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.13;

import "../NFT.sol";
import "forge-std/Test.sol";

contract NftTest is Test, NFT {
  function setUp() public {
    initialize(address(this), "Sample NFT", "SAMPLE");
  }

  function testMint() public {
    uint256 id = this.mintNft(address(this));
    assertEq(id, 1);
  }

  function testMintFail() public {
    vm.expectRevert(bytes("Ownable: caller is not the owner"));
    vm.prank(address(0));
    this.mintNft(address(this));
  }
}
