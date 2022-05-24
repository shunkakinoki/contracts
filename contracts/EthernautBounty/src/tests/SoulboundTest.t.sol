// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import { SoulboundERC20 } from "../SoulboundERC20.sol";
import { SoulboundNFT } from "../SoulboundNFT.sol";
import { LibRLP } from "./libraries/LibRLP.t.sol";

error Soulbound();
error OnlyApprovedMinter();

contract SoulboundTest is Test {
  address bob = address(0xBEEF);
  address alice = address(0xCAFE);

  address constant deployer = 0xb4c79daB8f259C7Aee6E5b2Aa729821864227e84;
  uint256 nonce = vm.getNonce(deployer);

  address immutable sNFTAdress = LibRLP.computeAddress(deployer, nonce);
  address immutable sERC20Adress = LibRLP.computeAddress(deployer, nonce + 1);

  SoulboundNFT sNFT;
  SoulboundERC20 sERC20;

  /*//////////////////////////////////////////////////////////////
                                  SETUP
    //////////////////////////////////////////////////////////////*/

  function setUp() public {
    sNFT = new SoulboundNFT("EXPCounter", "XPC", sERC20Adress);
    sERC20 = new SoulboundERC20("EXP", "EXP", sNFTAdress);
  }

  function testAddresses() public {
    assertEq(address(sNFT), sNFTAdress);
    assertEq(address(sERC20), sERC20Adress);
  }

  /*//////////////////////////////////////////////////////////////
                                  NFT
    //////////////////////////////////////////////////////////////*/

  function testNFTOnePerAddress() public {
    vm.startPrank(bob);
    sNFT.mint();
    vm.expectRevert("one token per wallet");
    sNFT.mint();
  }

  function testNFTCantTransfer() public {
    vm.startPrank(bob);
    sNFT.mint();
    vm.expectRevert(Soulbound.selector);
    sNFT.safeTransferFrom(bob, alice, uint160(bob));
  }

  function testNFTCantApprove() public {
    vm.startPrank(bob);
    sNFT.mint();
    vm.expectRevert(Soulbound.selector);
    sNFT.approve(alice, uint160(bob));
  }

  function testNFTCantApproveForAll() public {
    vm.startPrank(bob);
    sNFT.mint();
    vm.expectRevert(Soulbound.selector);
    sNFT.setApprovalForAll(alice, true);
  }

  /*//////////////////////////////////////////////////////////////
                                   EXP
    //////////////////////////////////////////////////////////////*/

  function testEXPOnlyOwnerCanApprove() public {
    sERC20.setApprovedMinter(bob, true);
    vm.expectRevert("Ownable: caller is not the owner");
    vm.prank(bob);
    sERC20.setApprovedMinter(alice, true);
  }

  function testEXPOnlyApprovedCanMint() public {
    vm.expectRevert(OnlyApprovedMinter.selector);
    sERC20.mint(bob, 10);

    sERC20.setApprovedMinter(deployer, true);
    sERC20.mint(bob, 10);
  }

  function testEXPCantTransfer() public {
    sERC20.setApprovedMinter(deployer, true);
    sERC20.mint(bob, 10);
    vm.expectRevert(Soulbound.selector);
    vm.prank(bob);
    sERC20.transfer(alice, 5);
  }

  function testEXPCantApprove() public {
    sERC20.setApprovedMinter(deployer, true);
    sERC20.mint(bob, 10);
    vm.expectRevert(Soulbound.selector);
    vm.prank(bob);
    sERC20.approve(alice, 5);
  }

  function testEXPBurn() public {
    sERC20.setApprovedMinter(deployer, true);
    sERC20.mint(bob, 10);
    assertEq(sERC20.balanceOf(bob), 10);
    vm.prank(bob);
    sERC20.burn(5);
    assertEq(sERC20.balanceOf(bob), 5);
  }

  /*//////////////////////////////////////////////////////////////
                                 GENERAL
    //////////////////////////////////////////////////////////////*/

  function testUpdateURINoChange() public {
    vm.prank(bob);
    sNFT.mint();
    string memory initialURI = sNFT.tokenURI(uint160(bob));
    sNFT.updateURI(bob);
    string memory finalURI = sNFT.tokenURI(uint160(bob));
    assertTrue(
      keccak256(abi.encode(initialURI)) == keccak256(abi.encode(finalURI))
    );
  }

  function testUpdateURIMint() public {
    vm.prank(bob);
    sNFT.mint();
    string memory initialURI = sNFT.tokenURI(uint160(bob));

    sERC20.setApprovedMinter(deployer, true);
    sERC20.mint(bob, 10);
    string memory finalURI = sNFT.tokenURI(uint160(bob));

    assertFalse(
      keccak256(abi.encode(initialURI)) == keccak256(abi.encode(finalURI))
    );
  }

  function testUpdateURIBurn() public {
    vm.prank(bob);
    sNFT.mint();

    sERC20.setApprovedMinter(deployer, true);
    sERC20.mint(bob, 10);
    string memory initialURI = sNFT.tokenURI(uint160(bob));

    vm.prank(bob);
    sERC20.burn(5);
    string memory finalURI = sNFT.tokenURI(uint160(bob));

    assertFalse(
      keccak256(abi.encode(initialURI)) == keccak256(abi.encode(finalURI))
    );
  }
}
