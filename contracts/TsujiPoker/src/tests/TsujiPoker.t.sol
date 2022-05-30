// SPDX-License-Identifier: MIT

pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import { TsujiPoker } from "../TsujiPoker.sol";

contract TsujiPokerTest is Test {
  TsujiPoker poker;

  address shugo = address(0xE95330D7CDcd37bf0Ad875C29e2a2871FeFa3De8);
  address tomona = address(0x2aF8DDAb77A7c90a38CF26F29763365D0028cfEf);
  address kaki = address(0x4fd9D0eE6D6564E80A9Ee00c0163fC952d0A45Ed);
  address kohei = address(0x5D025814b6a21Cd6fcb4112F40f88bC823e6A9ab);
  address datz = address(0x1F80593194F5E71087cAfF5309e85Fe68292CB63);
  address eisuke = address(0x7E989e785d0836b509B814a7898356FdeAAAE889);
  address thomas = address(0xD30Fb00c2796cBAD72f6B9C410830Dc4FF05bA71);
  address inakazu = address(0x5dC79C9fB20B6A81588a32589cb8Ae8f4983DfBc);

  function setUp() public {
    vm.label(shugo, "shugo.eth");
    vm.label(tomona, "tomona.eth");
    vm.label(kaki, "kaki.eth");
    vm.label(kohei, "kohei.eth");
    vm.label(datz, "datz.eth");
    vm.label(eisuke, "eisuke.eth");
    vm.label(thomas, "thomas.eth");
    vm.label(inakazu, "inakazu");
    poker = new TsujiPoker();
  }

  function testRankOf() public {
    assertEq(poker.rankOf(shugo), 1);
    assertEq(poker.rankOf(tomona), 2);
    assertEq(poker.rankOf(kaki), 3);
    assertEq(poker.rankOf(kohei), 4);
    assertEq(poker.rankOf(datz), 5);
    assertEq(poker.rankOf(eisuke), 6);
    assertEq(poker.rankOf(thomas), 7);
    assertEq(poker.rankOf(inakazu), 8);
  }

  function testERC721Constants() public {
    assertEq(poker.name(), "Tsuji Poker NFT");
    assertEq(poker.symbol(), "TSUJI");
    assertEq(poker.quorum(), 5);
  }

  function testSupportsInterface() public {
    assertTrue(poker.supportsInterface(0x01ffc9a7));
    assertTrue(poker.supportsInterface(0x80ac58cd));
    assertTrue(poker.supportsInterface(0x5b5e139f));
  }

  function testShugoCanMint() public {
    vm.deal(shugo, 1 ether);
    assertEq(shugo.balance, 1 ether);

    vm.prank(shugo);
    poker.mint{ value: 0.01 ether }();

    assertEq(shugo.balance, 0.99 ether);
    assertEq(poker.ownerOf(1), shugo);
    assertEq(poker.voterOf(shugo), false);
  }

  function testTomonaCanMint() public {
    vm.deal(tomona, 1 ether);
    assertEq(tomona.balance, 1 ether);

    vm.prank(tomona);
    poker.mint{ value: 0.01 ether }();

    assertEq(tomona.balance, 0.99 ether);
    assertEq(poker.ownerOf(1), tomona);
    assertEq(poker.voterOf(tomona), false);
  }

  function testKakiCanMint() public {
    vm.deal(kaki, 1 ether);
    assertEq(kaki.balance, 1 ether);

    vm.prank(kaki);
    poker.mint{ value: 0.01 ether }();

    assertEq(kaki.balance, 0.99 ether);
    assertEq(poker.ownerOf(1), kaki);
    assertEq(poker.voterOf(kaki), false);
  }

  function testKoheiCanMint() public {
    vm.deal(kohei, 1 ether);
    assertEq(kohei.balance, 1 ether);

    vm.prank(kohei);
    poker.mint{ value: 0.01 ether }();

    assertEq(kohei.balance, 0.99 ether);
    assertEq(poker.ownerOf(1), kohei);
    assertEq(poker.voterOf(kohei), false);
  }

  function testDatzCanMint() public {
    vm.deal(datz, 1 ether);
    assertEq(datz.balance, 1 ether);

    vm.prank(datz);
    poker.mint{ value: 0.01 ether }();

    assertEq(datz.balance, 0.99 ether);
    assertEq(poker.ownerOf(1), datz);
    assertEq(poker.voterOf(datz), false);
  }

  function testEisukeCanMint() public {
    vm.deal(eisuke, 1 ether);
    assertEq(eisuke.balance, 1 ether);

    vm.prank(eisuke);
    poker.mint{ value: 0.01 ether }();

    assertEq(eisuke.balance, 0.99 ether);
    assertEq(poker.ownerOf(1), eisuke);
    assertEq(poker.voterOf(eisuke), false);
  }

  function testThomasCanMint() public {
    vm.deal(thomas, 1 ether);
    assertEq(thomas.balance, 1 ether);

    vm.prank(thomas);
    poker.mint{ value: 0.01 ether }();

    assertEq(thomas.balance, 0.99 ether);
    assertEq(poker.ownerOf(1), thomas);
    assertEq(poker.voterOf(thomas), false);
  }

  function testInakazuCanMint() public {
    vm.deal(inakazu, 1 ether);
    assertEq(inakazu.balance, 1 ether);

    vm.prank(inakazu);
    poker.mint{ value: 0.01 ether }();

    assertEq(inakazu.balance, 0.99 ether);
    assertEq(poker.ownerOf(1), inakazu);
    assertEq(poker.voterOf(inakazu), false);
  }

  function testOtherCannotMint() public {
    vm.deal(address(1), 1 ether);
    assertEq(address(1).balance, 1 ether);

    vm.prank(address(1));
    vm.expectRevert(TsujiPoker.PokerBound.selector);
    poker.mint{ value: 0.01 ether }();
  }

  function testOtherTwoCannotMint() public {
    vm.deal(address(2), 1 ether);
    assertEq(address(2).balance, 1 ether);

    vm.prank(address(2));
    vm.expectRevert(TsujiPoker.PokerBound.selector);
    poker.mint{ value: 0.01 ether }();
  }

  function testOtherCannotWithdraw() public {
    vm.deal(kaki, 1 ether);
    vm.prank(kaki);
    poker.mint{ value: 0.01 ether }();

    vm.prank(address(2));
    vm.expectRevert(TsujiPoker.PokerBound.selector);
    poker.withdraw();
  }

  function testKakiCannoutWithdraw() public {
    vm.deal(kaki, 1 ether);
    vm.prank(kaki);
    poker.mint{ value: 0.01 ether }();

    vm.prank(kaki);
    vm.expectRevert(TsujiPoker.TsujiNotBack.selector);
    poker.withdraw();
  }

  function testKakiCannotMintMultiple() public {
    vm.deal(kaki, 1 ether);
    vm.prank(kaki);
    poker.mint{ value: 0.01 ether }();
    vm.prank(kaki);
    poker.mint{ value: 0.01 ether }();
  }
}
