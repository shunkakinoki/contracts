// SPDX-License-Identifier: MIT

pragma solidity ^0.8.13;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract WagumiCatsV2 is ERC721, Ownable {
  uint256 public constant totalSupply = 3000;
  uint256 public constant mintPrice = 0.03 ether;
  uint256 public currentTokenId;

  constructor() ERC721("Wagumi Cats v2", "WAGUMI") {}

  function preMintForTreasury() public onlyOwner {
    require(currentTokenId + 150 <= totalSupply, "Max supply reached");
    for (uint256 id = 0; id < 150; id++) {
      uint256 newTokenId = ++currentTokenId;
      _safeMint(msg.sender, newTokenId);
    }
  }
}
