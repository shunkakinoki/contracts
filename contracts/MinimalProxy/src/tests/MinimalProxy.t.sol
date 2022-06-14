// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.13;

import "./NFT.t.sol";
import "../MinimalProxy.sol";
import "forge-std/Test.sol";

contract MinimalProxyTest is Test, Factory {
  NFT internal nft;

  function setUp() public {
    nft = new NFT();
  }

  function testDeploy() public {
    vm.expectEmit(true, true, false, true); // 3rd arg will not be checked
    // The event we expect
    emit Deployed(
      msg.sender,
      address(nft),
      address(0), // deployed address not checked.
      "Sample token",
      "SAMPLE"
    );
    address deployedContract = deploy(address(nft), "Sample token", "SAMPLE");
    assertEq(NFT(deployedContract).owner(), msg.sender);
    assertEq(NFT(deployedContract).name(), "Sample token");
    assertEq(NFT(deployedContract).symbol(), "SAMPLE");
  }

  function testDuplicateDeployFail() public {
    deploy(address(nft), "Sample token", "SAMPLE");
    vm.expectRevert(bytes("ERC1167: create2 failed"));
    deploy(address(nft), "Sample token", "SAMPLE");
  }
}
