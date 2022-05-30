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
  uint256 public immutable quorum = 5;

  mapping(address => uint256) public rankOf;

  mapping(uint256 => address) public ownerOf;
  mapping(address => uint256) public balanceOf;
  mapping(address => bool) public voterClaimOf;

  // shugo.eth
  address payable internal immutable shugo =
    payable(address(0xE95330D7CDcd37bf0Ad875C29e2a2871FeFa3De8));
  uint256 internal nextTokenId = 1;
  uint256 public tsujiBackVote = 0;

  constructor() payable {
    // shugo.eth
    rankOf[shugo] = 1;
    // tomona.eth
    rankOf[address(0x2aF8DDAb77A7c90a38CF26F29763365D0028cfEf)] = 2;
    // kaki.eth
    rankOf[address(0x4fd9D0eE6D6564E80A9Ee00c0163fC952d0A45Ed)] = 3;
    // kohei.eth
    rankOf[address(0x5D025814b6a21Cd6fcb4112F40f88bC823e6A9ab)] = 4;
    // datz.eth
    rankOf[address(0x1F80593194F5E71087cAfF5309e85Fe68292CB63)] = 5;
    // eisuke.eth
    rankOf[address(0x7E989e785d0836b509B814a7898356FdeAAAE889)] = 6;
    // thomaskobayashi.eth
    rankOf[address(0xD30Fb00c2796cBAD72f6B9C410830Dc4FF05bA71)] = 7;
    // inakazu
    rankOf[address(0x5dC79C9fB20B6A81588a32589cb8Ae8f4983DfBc)] = 8;
  }

  modifier onlyIfTsujiBack() {
    if (tsujiBackVote < quorum) revert TsujiNotBack();
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

  function mint() public payable onlyIfPlayer {
    if (msg.value < 0.01 ether) revert NotEnoughEth();
    if (balanceOf[msg.sender] > 0) revert PokerBound();

    unchecked {
      balanceOf[msg.sender]++;
      voterClaimOf[msg.sender] = true;
    }

    ownerOf[nextTokenId] = msg.sender;
    emit Transfer(address(0), msg.sender, nextTokenId++);
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
                '", "description": "Tsuji Poker Night in San Francisco on 2022/05/29"}'
              )
            )
          )
        )
      );
  }

  function vote() public onlyIfPlayer {
    if (balanceOf[msg.sender] == 0) revert PokerBound();
    if (voterClaimOf[msg.sender] == false) revert PokerBound();

    voterClaimOf[msg.sender] = false;

    unchecked {
      tsujiBackVote++;
    }
  }

  function withdraw() public onlyIfPlayer onlyIfTsujiBack {
    shugo.transfer(address(this).balance);
  }
}
