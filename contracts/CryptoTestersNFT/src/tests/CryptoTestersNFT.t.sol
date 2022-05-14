// SPDX-License-Identifier: CCO

pragma solidity ^0.8.13;

import "ds-test/test.sol";
import "forge-std/Vm.sol";
import "../CryptoTestersNFT.sol";
import "forge-std/console.sol";
import "forge-std/test/StdStorage.t.sol";

contract Receiver is IERC721Receiver {
  function onERC721Received(
    address operator,
    address from,
    uint256 id,
    bytes calldata data
  ) external pure returns (bytes4) {
    return this.onERC721Received.selector;
  }
}

contract ERC721CryptoTestersTest is DSTest {
  // Cheatcodes
  Vm vm = Vm(HEVM_ADDRESS);
  using stdStorage for StdStorage;
  StdStorage private stdstore;

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

    // Note: Merkle root generated with js library currently for whitelisted addresses testerOne and testerTwo
    bytes32 root = bytes32(
      0x320d00a7b006cf53ef07d9d44030a767bd2703919199d3373c726f5322a3d7d8
    );

    // Deploy nft
    nft = new ERC721CryptoTesters(
      "Cryptotesters",
      "Testers",
      root,
      false,
      false
    );
  }

  function testPreMintForTreasuryMultiSig() public {
    // Given
    Receiver receiver = new Receiver();
    assertEq(nft.balanceOf(address(receiver)), 0);

    // When
    nft.transferOwnership(address(receiver));
    vm.prank(address(receiver), address(receiver));
    nft.preMintForTreasury();

    // Then
    for (uint256 id = 1; id < 151; id++) {
      assertEq(nft.ownerOf(id), address(receiver));
    }
    assertEq(nft.balanceOf(address(receiver)), 150);
  }

  function testPreMintForTreasuryEOA() public {
    // Given
    assertEq(nft.balanceOf(testerOne), 0);

    // When
    nft.transferOwnership(testerOne);
    vm.prank(testerOne, testerOne);
    nft.preMintForTreasury();

    // Then
    for (uint256 id = 1; id < 151; id++) {
      assertEq(nft.ownerOf(id), testerOne);
    }
    assertEq(nft.balanceOf(testerOne), 150);
  }

  function testWhitelistClaimNotLive() public {
    // Given
    bytes32[] memory proof = new bytes32[](2);
    // Note: Merkle proof generated with js library currently
    bytes32 hashOne = bytes32(
      0x0b42b6393c1f53060fe3ddbfcd7aadcca894465a5a438f69c87d790b2299b9b2
    );
    bytes32 hashTwo = bytes32(
      0x805b21d846b189efaeb0377d6bb0d201b3872a363e607c25088f025b0c6ae1f8
    );
    proof[0] = hashOne;
    proof[1] = hashTwo;

    // When / Then
    vm.prank(testerOne, testerOne);
    vm.expectRevert("Whitelist mint not available yet");

    nft.whitelistClaim(proof);
  }

  function testWhitelistClaimExpired() public {
    // Given
    bytes32[] memory proof = new bytes32[](2);
    // Note: Merkle proof generated with js library currently
    bytes32 hashOne = bytes32(
      0x0b42b6393c1f53060fe3ddbfcd7aadcca894465a5a438f69c87d790b2299b9b2
    );
    bytes32 hashTwo = bytes32(
      0x805b21d846b189efaeb0377d6bb0d201b3872a363e607c25088f025b0c6ae1f8
    );
    proof[0] = hashOne;
    proof[1] = hashTwo;
    nft.startWhitelistMint();
    nft.startPublicMint();
    assertEq(nft.balanceOf(testerOne), 0);

    // When / Then
    vm.prank(testerOne, testerOne);
    vm.expectRevert("Whitelised claims have expired");

    nft.whitelistClaim(proof);
  }

  function testWhitelistAddressAlreadyClaimed() public {
    // Given
    bytes32[] memory proof = new bytes32[](2);
    // Note: Merkle proof generated with js library currently
    bytes32 hashOne = bytes32(
      0x0b42b6393c1f53060fe3ddbfcd7aadcca894465a5a438f69c87d790b2299b9b2
    );
    bytes32 hashTwo = bytes32(
      0x805b21d846b189efaeb0377d6bb0d201b3872a363e607c25088f025b0c6ae1f8
    );
    proof[0] = hashOne;
    proof[1] = hashTwo;
    nft.startWhitelistMint();
    vm.prank(testerOne, testerOne);
    nft.whitelistClaim(proof);
    assertEq(nft.balanceOf(testerOne), 1);
    assertEq(nft.ownerOf(1), testerOne);

    // When / Then
    vm.prank(testerOne, testerOne);
    vm.expectRevert("Address already claimed");

    nft.whitelistClaim(proof);
  }

  function testAddressNotWhitelisted() public {
    // Given
    bytes32[] memory proof = new bytes32[](2);
    // Note: Merkle proof generated with js library currently
    bytes32 hashOne = bytes32(
      0x0b42b6393c1f53060fe3ddbfcd7aadcca894465a5a438f69c87d790b2299b9b2
    );
    bytes32 hashTwo = bytes32(
      0x805b21d846b189efaeb0377d6bb0d201b3872a363e607c25088f025b0c6ae1f8
    );
    proof[0] = hashOne;
    proof[1] = hashTwo;
    nft.startWhitelistMint();
    assertEq(nft.balanceOf(testerTwo), 0);

    // When / Then
    vm.prank(testerTwo, testerTwo);
    vm.expectRevert("Address not whitelisted");
    nft.whitelistClaim(proof);
  }

  function testWhitelistClaim() public {
    // Given
    bytes32[] memory proof = new bytes32[](2);
    // Note: Merkle proof generated with js library currently
    bytes32 hashOne = bytes32(
      0x0b42b6393c1f53060fe3ddbfcd7aadcca894465a5a438f69c87d790b2299b9b2
    );
    bytes32 hashTwo = bytes32(
      0x805b21d846b189efaeb0377d6bb0d201b3872a363e607c25088f025b0c6ae1f8
    );
    proof[0] = hashOne;
    proof[1] = hashTwo;
    nft.startWhitelistMint();
    assertEq(nft.balanceOf(testerOne), 0);

    // When
    vm.prank(testerOne, testerOne);
    nft.whitelistClaim(proof);

    // Then
    assertEq(nft.balanceOf(testerOne), 1);
    assertEq(nft.ownerOf(1), testerOne);
  }

  function testPublicMintNotStarted() public {
    // Given

    // When / Then
    vm.expectRevert("Public mint not available yet");
    nft.publicMintTo(testerOne);
  }

  function testNoMintPricePaid() public {
    // Given
    nft.startPublicMint();

    // When / Then
    vm.expectRevert("Transaction value did not equal the mint price");
    nft.publicMintTo(testerOne);
  }

  function testMaxSupplyReached() public {
    // Given
    nft.startPublicMint();
    uint256 slot = stdstore.target(address(nft)).sig("currentTokenId()").find();
    bytes32 loc = bytes32(slot);
    bytes32 mockedCurrentTokenId = bytes32(abi.encode(nft.totalSupply()));
    vm.store(address(nft), loc, mockedCurrentTokenId);

    // When / Then
    vm.expectRevert("Max supply reached");
    nft.publicMintTo{ value: 0.3 ether }(testerOne);
  }

  function testMintToZeroAddress() public {
    // Given
    nft.startPublicMint();

    // When / Then
    vm.expectRevert("ERC721: mint to the zero address");
    nft.publicMintTo{ value: 0.3 ether }(address(0));
  }

  function testNewOwnerRegistered() public {
    // Given
    nft.startPublicMint();

    // When
    nft.publicMintTo{ value: 0.3 ether }(testerOne);

    // Then
    assertEq(nft.currentTokenId(), 1);
    assertEq(nft.ownerOf(1), testerOne);
  }

  function testBalanceIncremented() public {
    // Given
    nft.startPublicMint();

    // When
    nft.publicMintTo{ value: 0.3 ether }(testerOne);

    // Then
    uint256 balanceTesterOne = nft.balanceOf(testerOne);
    assertEq(balanceTesterOne, 1);
  }

  function testTokenUriUnregisteredToken() public {
    // Given
    nft.setBaseURI("uri");

    // When / Then
    vm.expectRevert("ERC721Metadata: URI query for nonexistent token");
    string memory tokenURI = nft.tokenURI(1);
  }

  function testTokenUri() public {
    // Given
    nft.setBaseURI("uri");
    nft.startPublicMint();

    // When
    nft.publicMintTo{ value: 0.3 ether }(testerOne);

    // Then
    string memory metadata = nft.tokenURI(1);
    assertEq(metadata, "uri1");
  }

  function testFailMintUnSafeContractReceiver() public {
    // Given
    nft.startPublicMint();

    // When
    vm.etch(testerOne, bytes("mock code"));
    vm.expectRevert("ERC721: transfer to non ERC721Receiver implementer");
    nft.publicMintTo{ value: 0.3 ether }(testerOne);
  }

  function testMintSafeContractReceiver() public {
    // Given
    Receiver receiver = new Receiver();
    nft.startPublicMint();

    // When
    nft.publicMintTo{ value: 0.3 ether }(address(receiver));

    // Then
    assertEq(nft.balanceOf(address(receiver)), 1);
    assertEq(nft.ownerOf(1), address(receiver));
  }
}
