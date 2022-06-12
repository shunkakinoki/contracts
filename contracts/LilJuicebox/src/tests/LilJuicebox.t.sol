// SPDX-License-Identifier: AGPL-3.0-only
pragma solidity ^0.8.10;

import { Vm } from "forge-std/Vm.sol";
import { DSTest } from "ds-test/test.sol";
import { stdError } from "forge-std/test/StdError.t.sol";
import { LilJuicebox, ProjectShare } from "../LilJuicebox.sol";

contract User {}

contract LilJuiceboxTest is DSTest {
  User internal user;
  ProjectShare internal token;
  LilJuicebox internal lilJuicebox;
  Vm internal hevm = Vm(HEVM_ADDRESS);

  event Renounced();
  event Withdrawn(uint256 amount);
  event StateUpdated(LilJuicebox.State state);
  event Refunded(address indexed contributor, uint256 amount);
  event Contributed(address indexed contributor, uint256 amount);

  function setUp() public {
    user = new User();
    lilJuicebox = new LilJuicebox("Test Crowdfund", "TEST");
    token = lilJuicebox.token();
  }

  function testCanContribute() public {
    uint256 startingBalance = address(this).balance;
    assertEq(token.balanceOf(address(this)), 0);

    hevm.expectEmit(true, false, false, true);
    emit Contributed(address(this), 1 ether);

    lilJuicebox.contribute{ value: 1 ether }();

    assertEq(address(lilJuicebox).balance, 1 ether);
    assertEq(token.balanceOf(address(this)), 1_000_000 ether);
    assertEq(address(this).balance, startingBalance - 1 ether);
  }

  function testCannotContributeWhenRoundIsClosed() public {
    uint256 startingBalance = address(this).balance;
    assertEq(token.balanceOf(address(this)), 0);

    lilJuicebox.setState(LilJuicebox.State.CLOSED);

    hevm.expectRevert(abi.encodeWithSignature("ContributionsClosed()"));
    lilJuicebox.contribute{ value: 1 ether }();

    assertEq(address(lilJuicebox).balance, 0);
    assertEq(token.balanceOf(address(this)), 0);
    assertEq(address(this).balance, startingBalance);
  }

  function testRefund() public {
    lilJuicebox.contribute{ value: 10 ether }();

    uint256 startingBalance = address(this).balance;
    assertEq(token.balanceOf(address(this)), 10_000_000 ether);

    lilJuicebox.setState(LilJuicebox.State.REFUNDING);

    hevm.expectEmit(true, false, false, true);
    emit Refunded(address(this), 10 ether);

    lilJuicebox.refund(10_000_000 ether);

    assertEq(address(lilJuicebox).balance, 0);
    assertEq(token.balanceOf(address(this)), 0);
    assertEq(address(this).balance, startingBalance + 10 ether);
  }

  function testCannotRefundsIfRefundsAreNotAvailable() public {
    lilJuicebox.contribute{ value: 10 ether }();

    uint256 startingBalance = address(this).balance;
    assertEq(token.balanceOf(address(this)), 10_000_000 ether);

    hevm.expectRevert(abi.encodeWithSignature("RefundsClosed()"));

    lilJuicebox.refund(10_000_000 ether);

    assertEq(address(lilJuicebox).balance, 10 ether);
    assertEq(token.balanceOf(address(this)), 10_000_000 ether);
    assertEq(address(this).balance, startingBalance);
  }

  function testCannotRefundsIfNotEnoughTokens() public {
    lilJuicebox.contribute{ value: 10 ether }();
    lilJuicebox.setState(LilJuicebox.State.REFUNDING);

    assertEq(token.balanceOf(address(user)), 0);

    hevm.prank(address(user));
    hevm.expectRevert(stdError.arithmeticError); // error comes from ERC20 impl. (solmate in this test)
    lilJuicebox.refund(10_000_000 ether);

    assertEq(address(lilJuicebox).balance, 10 ether);
    assertEq(token.balanceOf(address(user)), 0);
    assertEq(address(user).balance, 0);
  }

  function testManagerCanWithdrawFunds() public {
    hevm.deal(address(lilJuicebox), 10 ether);

    uint256 initialBalance = address(this).balance;

    hevm.expectEmit(false, false, false, true);
    emit Withdrawn(10 ether);
    lilJuicebox.withdraw();

    assertEq(address(this).balance, initialBalance + 10 ether);
  }

  function testNonManagerCannotWithdrawFunds() public {
    hevm.deal(address(lilJuicebox), 10 ether);

    uint256 initialBalance = address(user).balance;

    hevm.prank(address(user));
    hevm.expectRevert(abi.encodeWithSignature("Unauthorized()"));
    lilJuicebox.withdraw();

    assertEq(address(user).balance, initialBalance);
  }

  function testManagerCanSetState() public {
    assertEq(uint256(lilJuicebox.getState()), uint256(LilJuicebox.State.OPEN));

    hevm.expectEmit(false, false, false, true);
    emit StateUpdated(LilJuicebox.State.CLOSED);
    lilJuicebox.setState(LilJuicebox.State.CLOSED);

    assertEq(
      uint256(lilJuicebox.getState()),
      uint256(LilJuicebox.State.CLOSED)
    );
  }

  function testNonManagerCannotSetState() public {
    assertEq(uint256(lilJuicebox.getState()), uint256(LilJuicebox.State.OPEN));

    hevm.prank(address(user));
    hevm.expectRevert(abi.encodeWithSignature("Unauthorized()"));
    lilJuicebox.setState(LilJuicebox.State.CLOSED);

    assertEq(uint256(lilJuicebox.getState()), uint256(LilJuicebox.State.OPEN));
  }

  function testManagerCanRenounceOwnership() public {
    assertEq(lilJuicebox.manager(), address(this));

    hevm.expectEmit(false, false, false, true);
    emit Renounced();
    lilJuicebox.renounce();

    assertEq(lilJuicebox.manager(), address(0));
  }

  function testNonManagerCannotRenounceOwnership() public {
    assertEq(lilJuicebox.manager(), address(this));

    hevm.prank(address(user));
    hevm.expectRevert(abi.encodeWithSignature("Unauthorized()"));
    lilJuicebox.renounce();

    assertEq(lilJuicebox.manager(), address(this));
  }

  receive() external payable {}
}
