// SPDX-License-Identifier: MIT

pragma solidity ^0.8.13;

import "base64-sol/base64.sol";
import "./Renderer.sol";

/// @title TsujiPoker
/// @author Shun Kakinoki
/// @notice Contract for playing poker
/// @notice Soulbount nft code is heavily taken from Miguel's awesome Souminter contracts: https://github.com/m1guelpf/soulminter-contracts
contract TsujiPoker is Renderer {
  error PokerBound();

  event Transfer(address indexed from, address indexed to, uint256 indexed id);

  string public constant symbol = "TSUJI";
  string public constant name = "Tsuji Poker NFT";
  address public immutable owner = msg.sender;

  mapping(uint256 => address) public ownerOf;
  mapping(address => uint256) public balanceOf;
  mapping(address => uint256) public rankOf;

  uint256 internal nextTokenId = 1;

  constructor() payable {}

  modifier onlyOwner() {
    if (owner != msg.sender) revert PokerBound();
    _;
  }

  function approve(address, uint256) public virtual {
    revert PokerBound();
  }

  function isApprovedForAll(address, address) public pure {
    revert PokerBound();
  }

  function getApproved(uint256) public pure {
    revert PokerBound();
  }

  function setApprovalForAll(address, bool) public virtual {
    revert PokerBound();
  }

  function transferFrom(
    address,
    address,
    uint256
  ) public virtual {
    revert PokerBound();
  }

  function safeTransferFrom(
    address,
    address,
    uint256
  ) public virtual {
    revert PokerBound();
  }

  function safeTransferFrom(
    address,
    address,
    uint256,
    bytes calldata
  ) public virtual {
    revert PokerBound();
  }

  function supportsInterface(bytes4 interfaceId) public pure returns (bool) {
    return
      interfaceId == 0x01ffc9a7 ||
      interfaceId == 0x80ac58cd ||
      interfaceId == 0x5b5e139f;
  }

  function mint(address to, uint256 rank) public onlyOwner {
    unchecked {
      balanceOf[to]++;
    }

    ownerOf[nextTokenId] = to;
    rankOf[to] = rank;
    emit Transfer(address(0), to, nextTokenId++);
  }

  function tokenURI(uint256 tokenId) public view returns (string memory) {
    return
      string(
        abi.encodePacked(
          "data:application/json;base64,",
          Base64.encode(
            bytes(
              abi.encodePacked(
                '{"name":"Tsuji Poker",',
                '"image":"data:image/svg+xml;base64,',
                Base64.encode(
                  bytes(render(ownerOf[tokenId], rankOf[ownerOf[tokenId]]))
                ),
                '", "description": "Tsuji Poker Night in San Francisco: 2022/05/29",',
                '"score": "',
                rankOf[ownerOf[tokenId]],
                '"}'
              )
            )
          )
        )
      );
  }
}
