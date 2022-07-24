// SPDX-License-Identifier: MIT
pragma solidity 0.8.13;

import { console } from "forge-std/console.sol";
import { stdStorage, StdStorage, Test } from "forge-std/Test.sol";
import "forge-std/console.sol";

import { Utils } from "../utils/Utils.sol";

import { GovernorTimelockControlMock } from "@openzeppelin/contracts/mocks/GovernorTimelockControlMock.sol";
import { TimelockController } from "@openzeppelin/contracts/governance/TimelockController.sol";
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

  GovernorTimelockControlMock internal governorTimelockControlMock;
  TimelockController internal timelockController;
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

    //timelock controller
    address[] memory addressArray = new address[](1);

    timelockController = new TimelockController(
      3600,
      addressArray,
      addressArray
    );

    // governor timelock
    governorTimelockControlMock = new GovernorTimelockControlMock(
      "OZ-Governor",
      IVotes(address(erc20VotesMock)),
      4,
      16,
      timelockController,
      10
    );
    timelockController.grantRole(
      timelockController.PROPOSER_ROLE(),
      address(governorTimelockControlMock)
    );

    // mock to execute
    callReceiverMock = new CallReceiverMock();
  }
}

contract TimelockTest is BaseSetup {
  function setUp() public virtual override {
    BaseSetup.setUp();
    console.log("TImelock test");
  }

  function testPropose() public {
    // create proposal
    address[] memory targets = new address[](1);
    targets[0] = address(callReceiverMock);

    uint256[] memory values = new uint256[](1);
    values[0] = 0;

    bytes[] memory calldatas = new bytes[](1);
    calldatas[0] = abi.encodeWithSignature("mockFunction()");

    uint256 proposalId = governorTimelockControlMock.propose(
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
    vm.roll(governorTimelockControlMock.proposalSnapshot(proposalId) + 1);

    // cast vote
    vm.prank(alice);
    governorTimelockControlMock.castVote(proposalId, 1);
    vm.prank(bob);
    governorTimelockControlMock.castVote(proposalId, 1);
    vm.prank(carol);
    governorTimelockControlMock.castVote(proposalId, 0);
    vm.prank(dave);
    governorTimelockControlMock.castVote(proposalId, 2);

    // after end block
    vm.roll(governorTimelockControlMock.proposalDeadline(proposalId) + 1);

    // check vote result
    (
      uint256 againstVotes,
      uint256 forVotes,
      uint256 abstainVotes
    ) = governorTimelockControlMock.proposalVotes(proposalId);
    assertEq(againstVotes, 25);
    assertEq(forVotes, 50);
    assertEq(abstainVotes, 25);

    // queue
    governorTimelockControlMock.queue(
      targets,
      values,
      calldatas,
      keccak256(bytes("<proposal description>"))
    );
    // after eta
    vm.warp(governorTimelockControlMock.proposalEta(proposalId) + 1);

    // execute queued proposal
    governorTimelockControlMock.execute(
      targets,
      values,
      calldatas,
      keccak256(bytes("<proposal description>"))
    );
  }
}
