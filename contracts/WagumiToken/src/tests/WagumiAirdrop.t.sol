// SPDX-License-Identifier: MIT

pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import { WagumiAirdrop } from "../WagumiAirdrop.sol";
import { WagumiToken } from "../WagumiToken.sol";

contract WagumiCats is ERC721("Wagumi Cats", "WAGUMI") {
  uint256 public tokenId = 1;

  function mint() public returns (uint256) {
    _mint(msg.sender, tokenId);
    return tokenId++;
  }
}

contract WagumiAirdropTest is Test {
  WagumiAirdrop airdrop;
  WagumiCats nft;
  WagumiToken token;

  function setUp() public {
    nft = new WagumiCats();
    token = new WagumiToken();
    airdrop = new WagumiAirdrop(address(token));
  }
}
