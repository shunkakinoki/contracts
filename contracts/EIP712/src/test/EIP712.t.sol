// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.13;

import { Test } from "forge-std/Test.sol";

import { EIP712 } from "../EIP712.sol";

import { MockERC20 } from "./utils/MockERC20.sol";
import { SigUtils } from "./utils/SigUtils.sol";

contract DepositTest is Test {
  ///                                                          ///
  ///                           SETUP                          ///
  ///                                                          ///

  EIP712 internal deposit;
  MockERC20 internal token;
  SigUtils internal sigUtils;

  uint256 internal ownerPrivateKey;
  address internal owner;

  function setUp() public {
    deposit = new EIP712();
    token = new MockERC20();
    sigUtils = new SigUtils(token.DOMAIN_SEPARATOR());

    ownerPrivateKey = 0xA11CE;
    owner = vm.addr(ownerPrivateKey);

    token.mint(owner, 1e18);
  }

  ///                                                          ///
  ///                           DEPOSIT                        ///
  ///                                                          ///

  function test_Deposit() public {
    vm.prank(owner);
    token.approve(address(deposit), 1e18);

    vm.prank(owner);
    deposit.deposit(address(token), 1e18);

    assertEq(token.balanceOf(owner), 0);
    assertEq(token.balanceOf(address(deposit)), 1e18);
    assertEq(deposit.userDeposits(owner, address(token)), 1e18);
  }

  function testFail_ContractNotApproved() public {
    vm.prank(owner);
    deposit.deposit(address(token), 1e18);
  }

  ///                                                          ///
  ///                       DEPOSIT w/ PERMIT                  ///
  ///                                                          ///

  function test_DepositWithLimitedPermit() public {
    SigUtils.Permit memory permit = SigUtils.Permit({
      owner: owner,
      spender: address(deposit),
      value: 1e18,
      nonce: token.nonces(owner),
      deadline: 1 days
    });

    bytes32 digest = sigUtils.getTypedDataHash(permit);

    (uint8 v, bytes32 r, bytes32 s) = vm.sign(ownerPrivateKey, digest);

    deposit.depositWithPermit(
      address(token),
      1e18,
      permit.owner,
      permit.spender,
      permit.value,
      permit.deadline,
      v,
      r,
      s
    );

    assertEq(token.balanceOf(owner), 0);
    assertEq(token.balanceOf(address(deposit)), 1e18);

    assertEq(token.allowance(owner, address(deposit)), 0);
    assertEq(token.nonces(owner), 1);

    assertEq(deposit.userDeposits(owner, address(token)), 1e18);
  }

  function test_DepositWithMaxPermit() public {
    SigUtils.Permit memory permit = SigUtils.Permit({
      owner: owner,
      spender: address(deposit),
      value: type(uint256).max,
      nonce: token.nonces(owner),
      deadline: 1 days
    });

    bytes32 digest = sigUtils.getTypedDataHash(permit);

    (uint8 v, bytes32 r, bytes32 s) = vm.sign(ownerPrivateKey, digest);

    deposit.depositWithPermit(
      address(token),
      1e18,
      permit.owner,
      permit.spender,
      permit.value,
      permit.deadline,
      v,
      r,
      s
    );

    assertEq(token.balanceOf(owner), 0);
    assertEq(token.balanceOf(address(deposit)), 1e18);

    assertEq(token.allowance(owner, address(deposit)), type(uint256).max);
    assertEq(token.nonces(owner), 1);

    assertEq(deposit.userDeposits(owner, address(token)), 1e18);
  }

  function testRevert_ExpiredPermit() public {
    SigUtils.Permit memory permit = SigUtils.Permit({
      owner: owner,
      spender: address(deposit),
      value: 1e18,
      nonce: token.nonces(owner),
      deadline: 1 days
    });

    bytes32 digest = sigUtils.getTypedDataHash(permit);

    (uint8 v, bytes32 r, bytes32 s) = vm.sign(ownerPrivateKey, digest);

    vm.warp(1 days + 1 seconds); // fast forwards one second past the deadline

    vm.expectRevert("PERMIT_DEADLINE_EXPIRED");
    deposit.depositWithPermit(
      address(token),
      1e18,
      permit.owner,
      permit.spender,
      permit.value,
      permit.deadline,
      v,
      r,
      s
    );
  }

  function testRevert_InvalidSigner() public {
    SigUtils.Permit memory permit = SigUtils.Permit({
      owner: owner,
      spender: address(deposit),
      value: 1e18,
      nonce: token.nonces(owner),
      deadline: 1 days
    });

    bytes32 digest = sigUtils.getTypedDataHash(permit);

    (uint8 v, bytes32 r, bytes32 s) = vm.sign(0xB0B, digest); // 0xB0B signs but 0xA11CE is owner

    vm.expectRevert("INVALID_SIGNER");
    deposit.depositWithPermit(
      address(token),
      1e18,
      permit.owner,
      permit.spender,
      permit.value,
      permit.deadline,
      v,
      r,
      s
    );
  }

  function testRevert_InvalidNonce() public {
    SigUtils.Permit memory permit = SigUtils.Permit({
      owner: owner,
      spender: address(deposit),
      value: 1e18,
      nonce: 1, // set nonce to 1 instead of 0
      deadline: 1 days
    });

    bytes32 digest = sigUtils.getTypedDataHash(permit);

    (uint8 v, bytes32 r, bytes32 s) = vm.sign(ownerPrivateKey, digest);

    vm.expectRevert("INVALID_SIGNER");
    deposit.depositWithPermit(
      address(token),
      1e18,
      permit.owner,
      permit.spender,
      permit.value,
      permit.deadline,
      v,
      r,
      s
    );
  }

  function testFail_InvalidAllowance() public {
    SigUtils.Permit memory permit = SigUtils.Permit({
      owner: owner,
      spender: address(deposit),
      value: 5e17, // sets allowance of 0.5 tokens
      nonce: 0,
      deadline: 1 days
    });

    bytes32 digest = sigUtils.getTypedDataHash(permit);

    (uint8 v, bytes32 r, bytes32 s) = vm.sign(ownerPrivateKey, digest);

    deposit.depositWithPermit(
      address(token),
      1e18,
      permit.owner,
      permit.spender,
      permit.value,
      permit.deadline,
      v,
      r,
      s
    );
  }

  function testFail_InvalidBalance() public {
    SigUtils.Permit memory permit = SigUtils.Permit({
      owner: owner,
      spender: address(deposit),
      value: 2e18,
      nonce: 0,
      deadline: 1 days
    });

    bytes32 digest = sigUtils.getTypedDataHash(permit);

    (uint8 v, bytes32 r, bytes32 s) = vm.sign(ownerPrivateKey, digest);

    deposit.depositWithPermit(
      address(token),
      2e18, // owner was only minted 1 token
      permit.owner,
      permit.spender,
      permit.value,
      permit.deadline,
      v,
      r,
      s
    );
  }

  ///                                                          ///
  ///                           WITHDRAW                       ///
  ///                                                          ///

  function test_Withdraw() public {
    vm.startPrank(owner);

    token.approve(address(deposit), 1e18);
    deposit.deposit(address(token), 1e18);

    deposit.withdraw(address(token), 5e17);

    vm.stopPrank();

    assertEq(token.balanceOf(owner), 5e17);
    assertEq(token.balanceOf(address(deposit)), 5e17);
  }

  function testRevert_InvalidWithdraw() public {
    vm.startPrank(owner);

    token.approve(address(deposit), 1e18);
    deposit.deposit(address(token), 1e18);

    vm.expectRevert("INVALID_WITHDRAW");
    deposit.withdraw(address(token), 2e18);

    vm.stopPrank();
  }
}
