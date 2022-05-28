// SPDX-License-Identifier: MIT

pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import { WagumiToken } from "../WagumiToken.sol";

contract WagumiTokenTest is Test {
  uint256 testNumber;
  WagumiToken token;
  address deployer = address(1);

  function setUp() public {
    vm.prank(deployer);
    token = new WagumiToken();
  }

  function testOwner() public {
    vm.prank(deployer);
    assertEq(token.owner(), deployer);
  }

  function testOwnerCanMint() public {
    vm.warp(1641070800);
    vm.prank(deployer);
    token.mint(address(2), 3);
    vm.stopPrank();
  }

  function testOwnerCannnotMint() public {
    vm.prank(address(3));
    vm.expectRevert("Ownable: caller is not the owner");
    token.mint(address(2), 3);
    vm.stopPrank();
  }

  function testOwnerCanMintALot() public {
    vm.warp(1641070800);
    vm.prank(deployer);
    token.mint(address(2), 300_000_000);
    vm.stopPrank();
  }

  function testOwnerCanMintMaximum() public {
    vm.warp(1641070800);
    vm.prank(deployer);
    token.mint(address(2), 1_000_000 * 1e18);
    vm.stopPrank();
  }

  function testOwnerCanMintMaximumGeneric() public {
    vm.warp(1641070800);
    uint256 minting = (token.getMaxPercentage() * token.totalSupply()) / 100;
    vm.prank(deployer);
    token.mint(address(2), minting);
  }

  function testOwnerCannotMintMoreThanMaximum() public {
    vm.warp(1641070800);
    vm.prank(deployer);
    vm.expectRevert(abi.encodeWithSignature("MaxMintableExceeded()"));
    token.mint(address(2), 10_000_000_000_000 * 1e18);
  }

  function testOwnerCannotMintMoreThanMaximumGeneric() public {
    vm.warp(1641070800);
    uint256 minting = ((token.getMaxPercentage() * token.totalSupply()) / 100) +
      1;
    vm.prank(deployer);
    vm.expectRevert(abi.encodeWithSignature("MaxMintableExceeded()"));
    token.mint(address(2), minting);
  }

  function testOwnerCanSetPercentage() public {
    vm.prank(deployer);
    token.setPercentage(90);
    assertEq(token.getMaxPercentage(), 90);
    vm.stopPrank();
  }

  function testOwnerCanMintOverInitialPercentage() public {
    vm.warp(1641070800);
    vm.prank(deployer);
    token.setPercentage(90);
    vm.prank(deployer);
    token.mint(address(1), 3_000_000 * 1e18);
    vm.stopPrank();
  }
}
