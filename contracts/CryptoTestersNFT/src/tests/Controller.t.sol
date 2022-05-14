// SPDX-License-Identifier: CCO
pragma solidity ^0.8.0;

import "ds-test/test.sol";
import "forge-std/Vm.sol";
import "forge-std/console.sol";
import "../CryptoTestersNFT.sol";

contract ControllerTest is DSTest {
  // Cheatcodes
  Vm vm = Vm(HEVM_ADDRESS);

  // Users
  address testerOne = address(1);
  address testerTwo = address(2);

  // Contracts
  ERC721CryptoTesters nft;

  function setUp() public {
    // Traces readability enhancement
    vm.label(testerOne, "Tester One");
    vm.label(testerTwo, "Tester Two");
    vm.label(address(this), "CryptoTestersNftTest Contract");

    // Deploy nft
    nft = new ERC721CryptoTesters(
      "Cryptotesters",
      "Testers",
      bytes32(0),
      false,
      false
    );
  }

  function testPublicMintSetter() public {
    // Given
    bool publicMintPre = nft.publicMint();
    assert(!publicMintPre);

    // WHen
    nft.startPublicMint();

    // Then
    bool publicMintPost = nft.publicMint();
    assert(publicMintPost);
  }

  function testWhitelistMint() public {
    // Given
    bool whitelistMintPre = nft.whitelistMint();
    assert(!whitelistMintPre);

    // When
    nft.startWhitelistMint();

    // Then
    bool whitelistMintPost = nft.whitelistMint();
    assert(whitelistMintPost);
  }

  function testBaseURISetter() public {
    //Given
    string memory baseURIPre = nft.baseURI();
    assertEq(baseURIPre, "");

    // When
    nft.setBaseURI("uri");

    // Then
    string memory baseURIPost = nft.baseURI();
    assertEq(baseURIPost, "uri");
  }

  function testWithdrawPayments() public {
    //Given
    vm.deal(address(nft), 1 ether);
    assertEq(address(nft).balance, 1 ether);
    assertEq(testerOne.balance, 0);

    // When
    nft.withdrawPayments(payable(testerOne));

    // Then
    assertEq(address(nft).balance, 0);
    assertEq(testerOne.balance, 1 ether);
  }

  function testWithdrawNotOwner() public {
    // Given
    vm.deal(address(nft), 1 ether);
    assertEq(address(nft).balance, 1 ether);
    assertEq(testerOne.balance, 0);

    // When / Then
    vm.prank(testerOne, testerOne);
    vm.expectRevert("Ownable: caller is not the owner");
    nft.withdrawPayments(payable(testerOne));
  }
}
