// SPDX-License-Identifier: Unlicense
// Contract derived from etherscan at: https://etherscan.io/address/0x1b57e04c02f9328bdd417fde6698b236b543c47f#code
// All rights reserved to the author.

pragma solidity ^0.8.13;

import { Ownable } from "@openzeppelin/contracts/access/Ownable.sol";
import { IERC721 } from "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import { IERC20 } from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import { IERC721Metadata } from "@openzeppelin/contracts/token/ERC721/extensions/IERC721Metadata.sol";
import { IERC165 } from "@openzeppelin/contracts/utils/introspection/IERC165.sol";
import { Strings } from "@openzeppelin/contracts/utils/Strings.sol";

/*
 _    _       _       _      __                     _    _            _     _
| |  | |     | |     | |    / _|                   | |  | |          | |   | |
| |  | | __ _| |_ ___| |__ | |_ __ _  ___ ___  ___ | |  | | ___  _ __| | __| |
| |/\| |/ _` | __/ __| '_ \|  _/ _` |/ __/ _ \/ __|| |/\| |/ _ \| '__| |/ _` |
\  /\  / (_| | || (__| | | | || (_| | (_|  __/\__ \\  /\  / (_) | |  | | (_| |
 \/  \/ \__,_|\__\___|_| |_|_| \__,_|\___\___||___(_)/  \/ \___/|_|  |_|\__,_|

  https://www.watchfaces.world/ | https://twitter.com/watchfacesworld

*/

contract WatchfacesPFP is IERC721Metadata, Ownable {
  IERC721 public watchfaces;
  string public baseURI = "https://watchfaces.world/api/pfp/";

  error NonTransferrableNFT();

  constructor(IERC721 _watchfaces) {
    watchfaces = _watchfaces;
  }

  function mint(uint256 tokenId) external {
    emit Transfer(address(0), watchfaces.ownerOf(tokenId), tokenId);
  }

  function mintMany(uint256[] calldata tokenIds) external {
    uint256 length = tokenIds.length;
    uint256 index = 0;
    while (index < length) {
      uint256 tokenId = tokenIds[index];
      emit Transfer(address(0), watchfaces.ownerOf(tokenId), tokenId);
      unchecked {
        index++;
      }
    }
  }

  // Admin

  function setBaseURI(string calldata _baseURI) external onlyOwner {
    baseURI = _baseURI;
  }

  function withdrawAll() external {
    payable(owner()).transfer(address(this).balance);
  }

  function withdrawAllERC20(IERC20 _erc20Token) external {
    _erc20Token.transfer(owner(), _erc20Token.balanceOf(address(this)));
  }

  // Supply and ownership mirrored from the main contract

  function balanceOf(address owner) external view returns (uint256 balance) {
    return watchfaces.balanceOf(owner);
  }

  function ownerOf(uint256 tokenId) external view returns (address owner) {
    return watchfaces.ownerOf(tokenId);
  }

  function name() external pure returns (string memory) {
    return "Watchfaces PFP";
  }

  function symbol() external pure returns (string memory) {
    return "WFPFP";
  }

  function tokenURI(uint256 tokenId) external view returns (string memory) {
    return string.concat(baseURI, Strings.toString(tokenId));
  }

  function supportsInterface(bytes4 interfaceId)
    public
    view
    virtual
    returns (bool)
  {
    return
      interfaceId == type(IERC165).interfaceId ||
      interfaceId == type(IERC721).interfaceId ||
      interfaceId == type(IERC721Metadata).interfaceId;
  }

  // Non-transferrable NFT implementation

  function safeTransferFrom(
    address,
    address,
    uint256
  ) external pure {
    revert NonTransferrableNFT();
  }

  function transferFrom(
    address,
    address,
    uint256
  ) external pure {
    revert NonTransferrableNFT();
  }

  function approve(address, uint256) external pure {
    revert NonTransferrableNFT();
  }

  function getApproved(uint256) external pure returns (address operator) {
    return address(0);
  }

  function setApprovalForAll(address, bool) external pure {
    revert NonTransferrableNFT();
  }

  function isApprovedForAll(address, address) external pure returns (bool) {
    return false;
  }

  function safeTransferFrom(
    address,
    address,
    uint256,
    bytes calldata
  ) external pure {
    revert NonTransferrableNFT();
  }
}
