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

    assertEq(poker.balanceOf(shugo), 1);
    assertEq(poker.ownerOf(1), shugo);
    assertEq(poker.voterClaimOf(shugo), true);
  }

  function testTomonaCanMint() public {
    vm.deal(tomona, 1 ether);
    assertEq(tomona.balance, 1 ether);

    vm.prank(tomona);
    poker.mint{ value: 0.01 ether }();
    assertEq(tomona.balance, 0.99 ether);

    assertEq(poker.balanceOf(tomona), 1);
    assertEq(poker.ownerOf(1), tomona);
    assertEq(poker.voterClaimOf(tomona), true);
  }

  function testKakiCanMint() public {
    vm.deal(kaki, 1 ether);
    assertEq(kaki.balance, 1 ether);

    vm.prank(kaki);
    poker.mint{ value: 0.01 ether }();
    assertEq(kaki.balance, 0.99 ether);

    assertEq(poker.balanceOf(kaki), 1);
    assertEq(poker.ownerOf(1), kaki);
    assertEq(poker.voterClaimOf(kaki), true);
  }

  function testKoheiCanMint() public {
    vm.deal(kohei, 1 ether);
    assertEq(kohei.balance, 1 ether);

    vm.prank(kohei);
    poker.mint{ value: 0.01 ether }();
    assertEq(kohei.balance, 0.99 ether);

    assertEq(poker.balanceOf(kohei), 1);
    assertEq(poker.ownerOf(1), kohei);
    assertEq(poker.voterClaimOf(kohei), true);
  }

  function testDatzCanMint() public {
    vm.deal(datz, 1 ether);
    assertEq(datz.balance, 1 ether);

    vm.prank(datz);
    poker.mint{ value: 0.01 ether }();
    assertEq(datz.balance, 0.99 ether);

    assertEq(poker.balanceOf(datz), 1);
    assertEq(poker.ownerOf(1), datz);
    assertEq(poker.voterClaimOf(datz), true);
  }

  function testEisukeCanMint() public {
    vm.deal(eisuke, 1 ether);
    assertEq(eisuke.balance, 1 ether);

    vm.prank(eisuke);
    poker.mint{ value: 0.01 ether }();
    assertEq(eisuke.balance, 0.99 ether);

    assertEq(poker.balanceOf(eisuke), 1);
    assertEq(poker.ownerOf(1), eisuke);
    assertEq(poker.voterClaimOf(eisuke), true);
  }

  function testThomasCanMint() public {
    vm.deal(thomas, 1 ether);
    assertEq(thomas.balance, 1 ether);

    vm.prank(thomas);
    poker.mint{ value: 0.01 ether }();
    assertEq(thomas.balance, 0.99 ether);

    assertEq(poker.balanceOf(thomas), 1);
    assertEq(poker.ownerOf(1), thomas);
    assertEq(poker.voterClaimOf(thomas), true);
  }

  function testInakazuCanMint() public {
    vm.deal(inakazu, 1 ether);
    assertEq(inakazu.balance, 1 ether);

    vm.prank(inakazu);
    poker.mint{ value: 0.01 ether }();
    assertEq(inakazu.balance, 0.99 ether);

    assertEq(poker.balanceOf(inakazu), 1);
    assertEq(poker.ownerOf(1), inakazu);
    assertEq(poker.voterClaimOf(inakazu), true);
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

  function testKakiCanMintMultiple() public {
    vm.deal(kaki, 1 ether);
    vm.prank(kaki);
    poker.mint{ value: 0.01 ether }();
    vm.prank(kaki);
    vm.expectRevert(TsujiPoker.PokerBound.selector);
    poker.mint{ value: 0.01 ether }();
  }

  function testKakiTokenMetadata() public {
    vm.deal(kaki, 1 ether);
    vm.prank(kaki);
    poker.mint{ value: 0.01 ether }();
    assertEq(poker.ownerOf(1), kaki);
    assertEq(
      poker.tokenURI(1),
      "data:application/json;base64,eyJuYW1lIjoiVHN1amkgUG9rZXIiLCJpbWFnZSI6ImRhdGE6aW1hZ2Uvc3ZnK3htbDtiYXNlNjQsUEhOMlp5QjRiV3h1Y3owaWFIUjBjRG92TDNkM2R5NTNNeTV2Y21jdk1qQXdNQzl6ZG1jaUlIQnlaWE5sY25abFFYTndaV04wVW1GMGFXODlJbmhOYVc1WlRXbHVJRzFsWlhRaUlIWnBaWGRDYjNnOUlqQWdNQ0F6TlRBZ016VXdJajQ4YzNSNWJHVStMbUpoYzJVZ2V5Qm1hV3hzT2lCM2FHbDBaVHNnWm05dWRDMW1ZVzFwYkhrNklITmxjbWxtT3lCbWIyNTBMWE5wZW1VNklERTBjSGc3SUgwOEwzTjBlV3hsUGp4eVpXTjBJSGRwWkhSb1BTSXhNREFsSWlCb1pXbG5hSFE5SWpFd01DVWlJR1pwYkd3OUltSnNZV05ySWlBdlBqeDBaWGgwSUhnOUlqRXdJaUI1UFNJeU1DSWdZMnhoYzNNOUltSmhjMlVpUGxSemRXcHBJRkJ2YTJWeUlFNXBaMmgwUEM5MFpYaDBQangwWlhoMElIZzlJakV3SWlCNVBTSTBNQ0lnWTJ4aGMzTTlJbUpoYzJVaVBsQnNZWGxsY2pvOEwzUmxlSFErUEhSbGVIUWdlRDBpTVRBaUlIazlJall3SWlCamJHRnpjejBpWW1GelpTSStNSGcwWm1RNVpEQmxaVFprTmpVMk5HVTRNR0U1WldVd01HTXdNVFl6Wm1NNU5USmtNR0UwTldWa1BDOTBaWGgwUGp4MFpYaDBJSGc5SWpFd0lpQjVQU0k0TUNJZ1kyeGhjM005SW1KaGMyVWlQbEpoYm1zNlBDOTBaWGgwUGp4MFpYaDBJSGc5SWpFd0lpQjVQU0l4TURBaUlHTnNZWE56UFNKaVlYTmxJajR6UEM5MFpYaDBQand2YzNablBnPT0iLCAiZGVzY3JpcHRpb24iOiAiVHN1amkgUG9rZXIgTmlnaHQgaW4gU2FuIEZyYW5jaXNjbyBvbiAyMDIyLzA1LzI5In0="
    );
  }

  function testCannotTransfer() public {
    vm.deal(shugo, 1 ether);
    vm.prank(shugo);
    poker.mint{ value: 0.01 ether }();

    assertEq(poker.ownerOf(1), address(shugo));

    vm.expectRevert(TsujiPoker.PokerBound.selector);
    poker.transferFrom(address(shugo), address(this), 1);

    vm.expectRevert(TsujiPoker.PokerBound.selector);
    poker.safeTransferFrom(address(shugo), address(this), 1);

    vm.expectRevert(TsujiPoker.PokerBound.selector);
    poker.approve(address(this), type(uint256).max);

    assertEq(poker.ownerOf(1), address(shugo));
  }

  function testKakiCannoutVoteWithoutNft() public {
    vm.prank(kaki);
    vm.expectRevert(TsujiPoker.PokerBound.selector);
    poker.vote();
  }

  function testKakiCanVoteWithNft() public {
    vm.deal(kaki, 1 ether);
    vm.prank(kaki);
    poker.mint{ value: 0.01 ether }();

    vm.prank(kaki);
    poker.vote();
  }

  function testKakiCanNotMintAndVoteMultipleAfterVote() public {
    vm.deal(kaki, 1 ether);
    vm.prank(kaki);
    poker.mint{ value: 0.01 ether }();
    vm.prank(kaki);
    poker.vote();
    assertEq(poker.tsujiBackVote(), 1);
    vm.prank(kaki);
    vm.expectRevert(TsujiPoker.PokerBound.selector);
    poker.mint{ value: 0.01 ether }();
    vm.prank(kaki);
    vm.expectRevert(TsujiPoker.PokerBound.selector);
    poker.vote();
    assertEq(poker.tsujiBackVote(), 1);
  }
}
