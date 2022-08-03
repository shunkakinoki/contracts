// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.13;

import { Test } from "forge-std/Test.sol";
import { WETH } from "@rari-capital/solmate/src/tokens/WETH.sol";
import { HuffDeployer } from "foundry-huff/HuffDeployer.sol";

contract WETHTest is Test {
  address constant USER1 = address(uint160(1000));
  address constant USER2 = address(uint160(2000));
  address constant USER3 = address(uint160(3000));
  WETH weth;

  uint256 constant BASE_SUPPLY = 1 ether;

  function setUp() public {
    weth = WETH(payable(HuffDeployer.deploy("../huff_contracts/WETH")));
    // weth = new WETH();
    vm.label(address(weth), "WETH");

    vm.deal(USER1, 100 ether);

    assertEq(weth.totalSupply(), 0);
    hoax(USER3, 1 ether);
    weth.deposit{ value: 1 ether }();

    vm.label(USER1, "user1");
    vm.label(USER2, "user2");
    vm.label(USER3, "user3");
  }

  function testDeploy() public {
    assertEq(weth.totalSupply(), BASE_SUPPLY);
    assertEq(weth.balanceOf(USER1), 0);
    assertEq(weth.allowance(USER1, USER2), 0);
    assertEq(keccak256(abi.encodePacked(weth.symbol())), keccak256("WETH"));
    assertEq(
      keccak256(abi.encodePacked(weth.name())),
      keccak256("Improved Wrapped Ether")
    );
  }

  event Transfer(address indexed _from, address indexed _to, uint256 _value);
  event Approval(
    address indexed owner,
    address indexed spender,
    uint256 amount
  );

  function testDeposit() public {
    uint256 totalDeposit;

    uint256 depositAmount = 1 ether;
    totalDeposit += depositAmount;
    vm.expectEmit(true, true, false, true);
    emit Transfer(address(0), USER1, depositAmount);
    vm.prank(USER1);
    weth.deposit{ value: depositAmount }();

    assertEq(weth.balanceOf(USER1), totalDeposit);
    assertEq(weth.totalSupply() - BASE_SUPPLY, totalDeposit);

    depositAmount = 2.38 ether;
    totalDeposit += depositAmount;
    vm.expectEmit(true, true, false, true);
    emit Transfer(address(0), USER1, depositAmount);
    vm.prank(USER1);
    address(weth).call{ value: depositAmount }("");

    assertEq(weth.balanceOf(USER1), totalDeposit);
    assertEq(weth.totalSupply() - BASE_SUPPLY, totalDeposit);
  }

  function testTransfer() public {
    vm.prank(USER1);
    uint256 totalDeposit = 50 ether;
    weth.deposit{ value: totalDeposit }();

    assertEq(weth.balanceOf(USER1), totalDeposit);

    uint256 transferAmount = 3.18 ether;
    vm.expectEmit(true, true, false, true);
    emit Transfer(USER1, USER2, transferAmount);
    vm.prank(USER1);
    weth.transfer(USER2, transferAmount);
  }

  function testApprove() public {
    uint256 approval = type(uint256).max;
    vm.expectEmit(true, true, false, true);
    vm.prank(USER1);
    weth.approve(USER3, approval);
    emit Approval(USER1, USER3, approval);
    assertEq(weth.allowance(USER1, USER3), approval);

    approval = 3 ether;
    vm.expectEmit(true, true, false, true);
    vm.prank(USER1);
    weth.approve(USER3, approval);
    emit Approval(USER1, USER3, approval);
    assertEq(weth.allowance(USER1, USER3), approval);
  }

  function testTransferFrom() public {
    // inner setup
    vm.startPrank(USER1);
    weth.deposit{ value: 10 ether }();
    weth.approve(USER2, 4 ether);
    vm.stopPrank();

    vm.prank(USER2);
    weth.transferFrom(USER1, USER2, 1 ether);
    assertEq(weth.balanceOf(USER1), 10 ether - 1 ether);
    assertEq(weth.balanceOf(USER2), 1 ether);
    assertEq(weth.allowance(USER1, USER2), 4 ether - 1 ether);

    vm.prank(USER2);
    weth.transferFrom(USER1, USER2, 2.1 ether);
    assertEq(weth.balanceOf(USER1), 10 ether - 1 ether - 2.1 ether);
    assertEq(weth.balanceOf(USER2), 1 ether + 2.1 ether);
    assertEq(weth.allowance(USER1, USER2), 4 ether - 1 ether - 2.1 ether);
  }

  function testTransferFromInfiniteApproval() public {
    // inner setup
    vm.startPrank(USER1);
    weth.deposit{ value: 10 ether }();
    weth.approve(USER2, type(uint256).max);
    vm.stopPrank();

    vm.prank(USER2);
    weth.transferFrom(USER1, USER2, 1 ether);
    assertEq(weth.balanceOf(USER1), 10 ether - 1 ether);
    assertEq(weth.balanceOf(USER2), 1 ether);
    assertEq(weth.allowance(USER1, USER2), type(uint256).max);

    vm.prank(USER2);
    weth.transferFrom(USER1, USER2, 2.1 ether);
    assertEq(weth.balanceOf(USER1), 10 ether - 1 ether - 2.1 ether);
    assertEq(weth.balanceOf(USER2), 1 ether + 2.1 ether);
    assertEq(weth.allowance(USER1, USER2), type(uint256).max);
  }

  function testTransferFromWithoutApproval() public {
    vm.prank(USER1);
    weth.deposit{ value: 10 ether }();

    vm.expectRevert(bytes("WETH: Insufficient Allowance"));
    vm.prank(USER2);
    weth.transferFrom(USER1, USER2, 10 ether);
  }

  function testBlockTransferFromInsufficientBalance() public {
    vm.startPrank(USER1);
    weth.deposit{ value: 5 ether }();
    weth.approve(USER2, type(uint256).max);
    vm.stopPrank();

    vm.expectRevert(bytes("WETH: Insufficient Balance"));
    vm.prank(USER2);
    weth.transferFrom(USER1, USER2, 5.01 ether);
  }

  function testWithdraw() public {
    vm.startPrank(USER1);
    weth.deposit{ value: 5 ether }();
    weth.transfer(USER2, 3 ether);
    vm.stopPrank();

    uint256 nativeBalBefore = USER2.balance;
    uint256 balBefore = weth.balanceOf(USER2);
    uint256 supplyBefore = weth.totalSupply();
    uint256 withdrawAmount = 2 ether;
    vm.expectEmit(true, true, false, true);
    emit Transfer(USER2, address(0), withdrawAmount);
    vm.prank(USER2);
    weth.withdraw(withdrawAmount);
    assertEq(USER2.balance - nativeBalBefore, withdrawAmount);
    assertEq(balBefore - weth.balanceOf(USER2), withdrawAmount);
    assertEq(supplyBefore - weth.totalSupply(), withdrawAmount);
  }

  function testBlockUnwrapInsufficientBalance() public {
    vm.prank(USER1);
    weth.deposit{ value: 5 ether }();
    emit log("A");

    vm.expectRevert(bytes("WETH: Insufficient Balance"));
    vm.prank(USER1);
    weth.withdraw(5.01 ether);
  }

  function testBlocksZeroAddress() public {
    vm.startPrank(USER1);
    weth.deposit{ value: 5 ether }();

    vm.expectRevert(bytes("WETH: Zero Address"));
    weth.transfer(address(0), 1 ether);

    vm.expectRevert(bytes("WETH: Zero Address"));
    weth.approve(address(0), 1 ether);

    weth.approve(USER2, 3 ether);

    vm.stopPrank();

    vm.prank(USER2);
    vm.expectRevert(bytes("WETH: Zero Address"));
    weth.transferFrom(USER1, address(0), 1 ether);
  }
}
