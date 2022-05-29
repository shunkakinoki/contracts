// SPDX-License-Identifier: MIT

pragma solidity ^0.8.13;

import "base64-sol/base64.sol";
import "./Renderer.sol";

/// @title TsujiPoker
/// @author Shun Kakinoki
/// @notice Contract for certifying "poker bound" nfts
/// @notice Soulbount nft code is heavily taken from Miguel's awesome Souminter contracts: https://github.com/m1guelpf/soulminter-contracts
contract TsujiPoker is Renderer {
  error PokerBound();
  error NotEnoughEth();
  error TsujiNotBack();

  event Transfer(address indexed from, address indexed to, uint256 indexed id);

  string public constant symbol = "TSUJI";
  string public constant name = "Tsuji Poker NFT";
  address public immutable owner = msg.sender;
  bool public constant isTsujiBack = false;
  uint256 public immutable quorum = 5;

  mapping(uint256 => address) public ownerOf;
  mapping(address => bool) public voterOf;
  mapping(address => uint256) public rankOf;

  // shugo.eth
  address payable public immutable shugo =
    payable(address(0xE95330D7CDcd37bf0Ad875C29e2a2871FeFa3De8));

  uint256 internal nextTokenId = 1;
  uint256 internal tsujiBackVote = 0;

  constructor() payable {
    // shugo.eth
    rankOf[shugo] = 0;
    // tomona.eth
    rankOf[address(0x2aF8DDAb77A7c90a38CF26F29763365D0028cfEf)] = 0;
    // kaki.eth
    rankOf[address(0x4fd9D0eE6D6564E80A9Ee00c0163fC952d0A45Ed)] = 0;
    // kohei.eth
    rankOf[address(0x5D025814b6a21Cd6fcb4112F40f88bC823e6A9ab)] = 0;
    // datz.eth
    rankOf[address(0x1F80593194F5E71087cAfF5309e85Fe68292CB63)] = 0;
    // eisuke.eth
    rankOf[address(0x7E989e785d0836b509B814a7898356FdeAAAE889)] = 0;
    // thomaskobayashi.eth
    rankOf[address(0xD30Fb00c2796cBAD72f6B9C410830Dc4FF05bA71)] = 0;
  }

  modifier onlyIfTsujiBack() {
    if (owner != msg.sender) revert TsujiNotBack();
    _;
  }

  modifier onlyIfPlayer() {
    if (rankOf[msg.sender] == 0) revert PokerBound();
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

  function mint(address to, uint256 rank) public payable onlyIfPlayer {
    if (msg.value <= 0.01 ether) revert NotEnoughEth();
    if (voterOf[to] == false) revert PokerBound();

    unchecked {
      voterOf[to] = false;
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
                '", "description": "Tsuji Poker Night in San Francisco on 2022/05/29",',
                '"rank": "',
                rankOf[ownerOf[tokenId]],
                '"}'
              )
            )
          )
        )
      );
  }

  function vote() public onlyIfPlayer {
    voterOf[msg.sender] = true;

    unchecked {
      tsujiBackVote++;
    }
  }

  function withdraw() public onlyIfTsujiBack {
    if (tsujiBackVote >= quorum) revert TsujiNotBack();

    shugo.transfer(address(this).balance);
  }
}
