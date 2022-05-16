// SPDX-License-Identifier: MIT

pragma solidity ^0.8.13;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract WagumiCatsV2 is ERC721, Ownable {
  uint256 public constant totalSupply = 3000;
  uint256 public constant mintPrice = 0.03 ether;
  address public constant wagumiCatsNFT =
    0x6144D927EE371de7e7f8221b596F3432E7A8e6D9;

  uint256 public currentTokenId;

  event Claimed(uint256 indexed tokenId, address indexed claimer);
  error NotOwner();
  error AlreadyRedeemed();

  mapping(uint256 => bool) public hasClaimed;

  constructor() ERC721("Wagumi Cats v2", "WAGUMI") {}

  function preMintForTreasury() public onlyOwner {
    require(currentTokenId + 150 <= totalSupply, "Max supply reached");
    for (uint256 id = 0; id < 150; id++) {
      uint256 newTokenId = ++currentTokenId;
      _safeMint(msg.sender, newTokenId);
    }
  }

  function claim(uint256 tokenId) external payable {
    if (hasClaimed[tokenId]) {
      revert AlreadyRedeemed();
    }
    if (IERC721(wagumiCatsNFT).ownerOf(tokenId) != msg.sender) {
      revert NotOwner();
    }

    hasClaimed[tokenId] = true;
    emit Claimed(tokenId, msg.sender);
    uint256 newTokenId = ++currentTokenId;
    _safeMint(msg.sender, newTokenId);
  }
}
