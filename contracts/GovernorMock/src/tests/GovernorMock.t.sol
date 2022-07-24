// SPDX-License-Identifier: MIT
// Code from: https://github.dev/fracton-ventures/foundry-governance-example

pragma solidity ^0.8.13;

import { console } from "forge-std/console.sol";
import { stdStorage, StdStorage, Test } from "forge-std/Test.sol";
import "forge-std/console.sol";

import { Utils } from "../utils/Utils.sol";

import { GovernorMock } from "@openzeppelin/contracts/mocks/GovernorMock.sol";
import { ERC20VotesMock } from "@openzeppelin/contracts/mocks/ERC20VotesMock.sol";
import { CallReceiverMock } from "@openzeppelin/contracts/mocks/CallReceiverMock.sol";
import { IVotes } from "@openzeppelin/contracts/governance/utils/IVotes.sol";

contract BaseSetup is Test {
  Utils internal utils;
  address payable[] internal users;

  address internal alice;
  address internal bob;
  address internal carol;
  address internal dave;

  GovernorMock internal governorMock;
  ERC20VotesMock internal erc20VotesMock;
  CallReceiverMock internal callReceiverMock;

  function setUp() public virtual {
    utils = new Utils();
    users = utils.createUsers(4);

    alice = users[0];
    vm.label(alice, "Alice");
    bob = users[1];
    vm.label(bob, "Bob");
    carol = users[2];
    vm.label(carol, "Carol");
    dave = users[3];
    vm.label(dave, "Dave");

    // token
    erc20VotesMock = new ERC20VotesMock("MockToken", "MTKN");
    erc20VotesMock.mint(address(this), 100);
    erc20VotesMock.transfer(alice, 25);
    erc20VotesMock.transfer(bob, 25);
    erc20VotesMock.transfer(carol, 25);
    erc20VotesMock.transfer(dave, 25);

    governorMock = new GovernorMock(
      "OZ-Governor",
      IVotes(address(erc20VotesMock)),
      4,
      16,
      10
    );

    callReceiverMock = new CallReceiverMock();
  }
}

contract ProposalIsExecuted is BaseSetup {
  function setUp() public virtual override {
    BaseSetup.setUp();
    console.log("Proposal is Executed");
  }

  function testPropose() public {
    // create proposal
    address[] memory targets = new address[](1);
    targets[0] = address(callReceiverMock);

    uint256[] memory values = new uint256[](1);
    values[0] = 0;

    bytes[] memory calldatas = new bytes[](1);
    calldatas[0] = abi.encodeWithSignature("mockFunction()");

    uint256 proposalId = governorMock.propose(
      targets,
      values,
      calldatas,
      "<proposal description>"
    );

    // delegate votes
    vm.prank(alice);
    erc20VotesMock.delegate(alice);
    vm.prank(bob);
    erc20VotesMock.delegate(bob);
    vm.prank(carol);
    erc20VotesMock.delegate(carol);
    vm.prank(dave);
    erc20VotesMock.delegate(dave);

    // after start block
    vm.roll(governorMock.proposalSnapshot(proposalId) + 1);

    // cast vote
    vm.prank(alice);
    governorMock.castVote(proposalId, 1);
    vm.prank(bob);
    governorMock.castVote(proposalId, 1);
    vm.prank(carol);
    governorMock.castVote(proposalId, 0);
    vm.prank(dave);
    governorMock.castVote(proposalId, 2);

    // after end block
    vm.roll(governorMock.proposalDeadline(proposalId) + 1);

    // check vote result
    (
      uint256 againstVotes,
      uint256 forVotes,
      uint256 abstainVotes
    ) = governorMock.proposalVotes(proposalId);
    assertEq(againstVotes, 25);
    assertEq(forVotes, 50);
    assertEq(abstainVotes, 25);

    // execute succeeded proposal
    governorMock.execute(
      targets,
      values,
      calldatas,
      keccak256(bytes("<proposal description>"))
    );
  }
}
