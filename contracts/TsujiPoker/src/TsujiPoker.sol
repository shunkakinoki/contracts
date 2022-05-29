// SPDX-License-Identifier: MIT

pragma solidity ^0.8.13;

/// @title TsujiPoker
/// @author Shun Kakinoki
/// @notice Contract for playing poker
/// @notice Soulbount nft code is heavily taken from Miguel's awesome Souminter contracts: https://github.com/m1guelpf/soulminter-contracts
contract TsujiPoker {
  error PokerBound();

  string public constant symbol = "TSUJI";
  string public constant name = "Tsuji Poker NFT";
  address public immutable owner = msg.sender;

  mapping(uint256 => string) public tokenURI;
  mapping(uint256 => address) public ownerOf;
  mapping(address => uint256) public balanceOf;

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
      interfaceId == 0x01ffc9a7 || // ERC165 Interface ID for ERC165
      interfaceId == 0x80ac58cd || // ERC165 Interface ID for ERC721
      interfaceId == 0x5b5e139f; // ERC165 Interface ID for ERC721Metadata
  }

  function mint(address to, string calldata metaURI) public payable {
    unchecked {
      balanceOf[to]++;
    }

    ownerOf[nextTokenId] = to;
    tokenURI[nextTokenId] = metaURI;
  }
}
