// SPDX-License-Identifier: MIT

pragma solidity ^0.8.13;

import "forge-std/Test.sol";
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

  function testOwnerCannotMintMoreThanMaximum() public {
    vm.prank(deployer);
    vm.expectRevert(abi.encodeWithSignature("MaxMintableExceeded()"));
    token.mint(address(2), 10_000_000_000_000 * 1e18);
  }
}
