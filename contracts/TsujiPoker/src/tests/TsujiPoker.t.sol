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
  address futa = address(0xe7236c912945C8B915c7C60b55e330b959801B45);
  address oliver = address(0x70B122116b50178D881e74Ec97b89c67E90b4A7c);

  function setUp() public {
    vm.label(shugo, "shugo.eth");
    vm.label(tomona, "tomona.eth");
    vm.label(kaki, "kaki.eth");
    vm.label(kohei, "kohei.eth");
    vm.label(datz, "datz.eth");
    vm.label(eisuke, "eisuke.eth");
    vm.label(thomas, "thomas.eth");
    vm.label(inakazu, "inakazu");
    vm.label(futa, "futa");
    vm.label(oliver, "oliver-diary.eth");
    poker = new TsujiPoker();
  }

  function testRankOf() public {
    assertEq(poker.rankOf(oliver), 1);
    assertEq(poker.rankOf(shugo), 2);
    assertEq(poker.rankOf(datz), 3);
    assertEq(poker.rankOf(inakazu), 4);
    assertEq(poker.rankOf(eisuke), 5);
    assertEq(poker.rankOf(kohei), 6);
    assertEq(poker.rankOf(thomas), 7);
    assertEq(poker.rankOf(tomona), 8);
    assertEq(poker.rankOf(kaki), 9);
    assertEq(poker.rankOf(futa), 10);
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
    assertEq(poker.voterClaimOf(shugo), false);
  }

  function testTomonaCanMint() public {
    vm.deal(tomona, 1 ether);
    assertEq(tomona.balance, 1 ether);

    vm.prank(tomona);
    poker.mint{ value: 0.01 ether }();
    assertEq(tomona.balance, 0.99 ether);

    assertEq(poker.balanceOf(tomona), 1);
    assertEq(poker.ownerOf(1), tomona);
    assertEq(poker.voterClaimOf(tomona), false);
  }

  function testKakiCanMint() public {
    vm.deal(kaki, 1 ether);
    assertEq(kaki.balance, 1 ether);

    vm.prank(kaki);
    poker.mint{ value: 0.01 ether }();
    assertEq(kaki.balance, 0.99 ether);

    assertEq(poker.balanceOf(kaki), 1);
    assertEq(poker.ownerOf(1), kaki);
    assertEq(poker.voterClaimOf(kaki), false);
  }

  function testKoheiCanMint() public {
    vm.deal(kohei, 1 ether);
    assertEq(kohei.balance, 1 ether);

    vm.prank(kohei);
    poker.mint{ value: 0.01 ether }();
    assertEq(kohei.balance, 0.99 ether);

    assertEq(poker.balanceOf(kohei), 1);
    assertEq(poker.ownerOf(1), kohei);
    assertEq(poker.voterClaimOf(kohei), false);
  }

  function testDatzCanMint() public {
    vm.deal(datz, 1 ether);
    assertEq(datz.balance, 1 ether);

    vm.prank(datz);
    poker.mint{ value: 0.01 ether }();
    assertEq(datz.balance, 0.99 ether);

    assertEq(poker.balanceOf(datz), 1);
    assertEq(poker.ownerOf(1), datz);
    assertEq(poker.voterClaimOf(datz), false);
  }

  function testEisukeCanMint() public {
    vm.deal(eisuke, 1 ether);
    assertEq(eisuke.balance, 1 ether);

    vm.prank(eisuke);
    poker.mint{ value: 0.01 ether }();
    assertEq(eisuke.balance, 0.99 ether);

    assertEq(poker.balanceOf(eisuke), 1);
    assertEq(poker.ownerOf(1), eisuke);
    assertEq(poker.voterClaimOf(eisuke), false);
  }

  function testThomasCanMint() public {
    vm.deal(thomas, 1 ether);
    assertEq(thomas.balance, 1 ether);

    vm.prank(thomas);
    poker.mint{ value: 0.01 ether }();
    assertEq(thomas.balance, 0.99 ether);

    assertEq(poker.balanceOf(thomas), 1);
    assertEq(poker.ownerOf(1), thomas);
    assertEq(poker.voterClaimOf(thomas), false);
  }

  function testInakazuCanMint() public {
    vm.deal(inakazu, 1 ether);
    assertEq(inakazu.balance, 1 ether);

    vm.prank(inakazu);
    poker.mint{ value: 0.01 ether }();
    assertEq(inakazu.balance, 0.99 ether);

    assertEq(poker.balanceOf(inakazu), 1);
    assertEq(poker.ownerOf(1), inakazu);
    assertEq(poker.voterClaimOf(inakazu), false);
  }

  function testFutaCanMint() public {
    vm.deal(futa, 1 ether);
    assertEq(futa.balance, 1 ether);

    vm.prank(futa);
    poker.mint{ value: 0.01 ether }();
    assertEq(futa.balance, 0.99 ether);

    assertEq(poker.balanceOf(futa), 1);
    assertEq(poker.ownerOf(1), futa);
    assertEq(poker.voterClaimOf(futa), false);
  }

  function testOliverCanMint() public {
    vm.deal(oliver, 1 ether);
    assertEq(oliver.balance, 1 ether);

    vm.prank(oliver);
    poker.mint{ value: 0.01 ether }();
    assertEq(oliver.balance, 0.99 ether);

    assertEq(poker.balanceOf(oliver), 1);
    assertEq(poker.ownerOf(1), oliver);
    assertEq(poker.voterClaimOf(oliver), false);
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
      "data:application/json;base64,eyJuYW1lIjoiVHN1amkgUG9rZXIiLCJpbWFnZSI6ImRhdGE6aW1hZ2Uvc3ZnK3htbDtiYXNlNjQsUEhOMlp5QjRiV3h1Y3owaWFIUjBjRG92TDNkM2R5NTNNeTV2Y21jdk1qQXdNQzl6ZG1jaUlIQnlaWE5sY25abFFYTndaV04wVW1GMGFXODlJbmhOYVc1WlRXbHVJRzFsWlhRaUlIWnBaWGRDYjNnOUlqQWdNQ0F6TlRBZ016VXdJajQ4YzNSNWJHVStMbUpoYzJVZ2V5Qm1hV3hzT2lCM2FHbDBaVHNnWm05dWRDMW1ZVzFwYkhrNklITmxjbWxtT3lCbWIyNTBMWE5wZW1VNklERTBjSGc3SUgwOEwzTjBlV3hsUGp4eVpXTjBJSGRwWkhSb1BTSXhNREFsSWlCb1pXbG5hSFE5SWpFd01DVWlJR1pwYkd3OUltSnNZV05ySWlBdlBqeDBaWGgwSUhnOUlqRXdJaUI1UFNJeU1DSWdZMnhoYzNNOUltSmhjMlVpUGxSemRXcHBJRkJ2YTJWeUlFNXBaMmgwUEM5MFpYaDBQangwWlhoMElIZzlJakV3SWlCNVBTSTBNQ0lnWTJ4aGMzTTlJbUpoYzJVaVBsQnNZWGxsY2pvOEwzUmxlSFErUEhSbGVIUWdlRDBpTVRBaUlIazlJall3SWlCamJHRnpjejBpWW1GelpTSSthMkZyYVM1bGRHZzhMM1JsZUhRK1BIUmxlSFFnZUQwaU1UQWlJSGs5SWpnd0lpQmpiR0Z6Y3owaVltRnpaU0krVW1GdWF6bzhMM1JsZUhRK1BIUmxlSFFnZUQwaU1UQWlJSGs5SWpFd01DSWdZMnhoYzNNOUltSmhjMlVpUGprOEwzUmxlSFErUEM5emRtYysiLCAiZGVzY3JpcHRpb24iOiAiVHN1amkgUG9rZXIgTmlnaHQgaW4gU2FuIEZyYW5jaXNjbyBvbiAyMDIyLzA1LzI5In0="
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

  function testOptimalFlow() public {
    vm.deal(shugo, 1 ether);
    vm.prank(shugo);
    poker.mint{ value: 0.01 ether }();
    vm.prank(shugo);
    poker.vote();

    vm.deal(tomona, 1 ether);
    vm.prank(tomona);
    poker.mint{ value: 0.01 ether }();
    vm.prank(tomona);
    poker.vote();

    vm.deal(kaki, 1 ether);
    vm.prank(kaki);
    poker.mint{ value: 0.01 ether }();
    vm.prank(kaki);
    poker.vote();

    vm.deal(kohei, 1 ether);
    vm.prank(kohei);
    poker.mint{ value: 0.01 ether }();
    vm.prank(kohei);
    poker.vote();

    vm.deal(datz, 1 ether);
    vm.prank(datz);
    poker.mint{ value: 0.01 ether }();
    vm.prank(datz);
    poker.vote();

    vm.deal(eisuke, 1 ether);
    vm.prank(eisuke);
    poker.mint{ value: 0.01 ether }();

    vm.deal(thomas, 1 ether);
    vm.prank(thomas);
    poker.mint{ value: 0.01 ether }();

    vm.deal(inakazu, 1 ether);
    vm.prank(inakazu);
    poker.mint{ value: 0.01 ether }();

    assertEq(poker.tsujiBackVote(), 5);
    vm.prank(kaki);
    poker.withdraw();
    assertEq(shugo.balance, 1.07 ether);
  }

  function testShugoTokenMetadata() public {
    vm.deal(shugo, 1 ether);
    vm.prank(shugo);
    poker.mint{ value: 0.01 ether }();
    assertEq(poker.ownerOf(1), shugo);
    assertEq(
      poker.tokenURI(1),
      "data:application/json;base64,eyJuYW1lIjoiVHN1amkgUG9rZXIiLCJpbWFnZSI6ImRhdGE6aW1hZ2Uvc3ZnK3htbDtiYXNlNjQsUEhOMlp5QjRiV3h1Y3owaWFIUjBjRG92TDNkM2R5NTNNeTV2Y21jdk1qQXdNQzl6ZG1jaUlIQnlaWE5sY25abFFYTndaV04wVW1GMGFXODlJbmhOYVc1WlRXbHVJRzFsWlhRaUlIWnBaWGRDYjNnOUlqQWdNQ0F6TlRBZ016VXdJajQ4YzNSNWJHVStMbUpoYzJVZ2V5Qm1hV3hzT2lCM2FHbDBaVHNnWm05dWRDMW1ZVzFwYkhrNklITmxjbWxtT3lCbWIyNTBMWE5wZW1VNklERTBjSGc3SUgwOEwzTjBlV3hsUGp4eVpXTjBJSGRwWkhSb1BTSXhNREFsSWlCb1pXbG5hSFE5SWpFd01DVWlJR1pwYkd3OUltSnNZV05ySWlBdlBqeDBaWGgwSUhnOUlqRXdJaUI1UFNJeU1DSWdZMnhoYzNNOUltSmhjMlVpUGxSemRXcHBJRkJ2YTJWeUlFNXBaMmgwUEM5MFpYaDBQangwWlhoMElIZzlJakV3SWlCNVBTSTBNQ0lnWTJ4aGMzTTlJbUpoYzJVaVBsQnNZWGxsY2pvOEwzUmxlSFErUEhSbGVIUWdlRDBpTVRBaUlIazlJall3SWlCamJHRnpjejBpWW1GelpTSStjMmgxWjI4dVpYUm9QQzkwWlhoMFBqeDBaWGgwSUhnOUlqRXdJaUI1UFNJNE1DSWdZMnhoYzNNOUltSmhjMlVpUGxKaGJtczZQQzkwWlhoMFBqeDBaWGgwSUhnOUlqRXdJaUI1UFNJeE1EQWlJR05zWVhOelBTSmlZWE5sSWo0eVBDOTBaWGgwUGp3dmMzWm5QZz09IiwgImRlc2NyaXB0aW9uIjogIlRzdWppIFBva2VyIE5pZ2h0IGluIFNhbiBGcmFuY2lzY28gb24gMjAyMi8wNS8yOSJ9"
    );
  }

  function testKoheiTokenMetadata() public {
    vm.deal(kohei, 1 ether);
    vm.prank(kohei);
    poker.mint{ value: 0.01 ether }();
    assertEq(poker.ownerOf(1), kohei);
    assertEq(
      poker.tokenURI(1),
      "data:application/json;base64,eyJuYW1lIjoiVHN1amkgUG9rZXIiLCJpbWFnZSI6ImRhdGE6aW1hZ2Uvc3ZnK3htbDtiYXNlNjQsUEhOMlp5QjRiV3h1Y3owaWFIUjBjRG92TDNkM2R5NTNNeTV2Y21jdk1qQXdNQzl6ZG1jaUlIQnlaWE5sY25abFFYTndaV04wVW1GMGFXODlJbmhOYVc1WlRXbHVJRzFsWlhRaUlIWnBaWGRDYjNnOUlqQWdNQ0F6TlRBZ016VXdJajQ4YzNSNWJHVStMbUpoYzJVZ2V5Qm1hV3hzT2lCM2FHbDBaVHNnWm05dWRDMW1ZVzFwYkhrNklITmxjbWxtT3lCbWIyNTBMWE5wZW1VNklERTBjSGc3SUgwOEwzTjBlV3hsUGp4eVpXTjBJSGRwWkhSb1BTSXhNREFsSWlCb1pXbG5hSFE5SWpFd01DVWlJR1pwYkd3OUltSnNZV05ySWlBdlBqeDBaWGgwSUhnOUlqRXdJaUI1UFNJeU1DSWdZMnhoYzNNOUltSmhjMlVpUGxSemRXcHBJRkJ2YTJWeUlFNXBaMmgwUEM5MFpYaDBQangwWlhoMElIZzlJakV3SWlCNVBTSTBNQ0lnWTJ4aGMzTTlJbUpoYzJVaVBsQnNZWGxsY2pvOEwzUmxlSFErUEhSbGVIUWdlRDBpTVRBaUlIazlJall3SWlCamJHRnpjejBpWW1GelpTSSthMjlvWldrdVpYUm9QQzkwWlhoMFBqeDBaWGgwSUhnOUlqRXdJaUI1UFNJNE1DSWdZMnhoYzNNOUltSmhjMlVpUGxKaGJtczZQQzkwWlhoMFBqeDBaWGgwSUhnOUlqRXdJaUI1UFNJeE1EQWlJR05zWVhOelBTSmlZWE5sSWo0MlBDOTBaWGgwUGp3dmMzWm5QZz09IiwgImRlc2NyaXB0aW9uIjogIlRzdWppIFBva2VyIE5pZ2h0IGluIFNhbiBGcmFuY2lzY28gb24gMjAyMi8wNS8yOSJ9"
    );
  }
}
