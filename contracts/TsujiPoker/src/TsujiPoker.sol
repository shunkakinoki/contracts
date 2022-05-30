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

  struct player {
    uint256 rank;
    string name;
    bool voted;
  }

  mapping(address => player) public playerOf;
  mapping(uint256 => address) public ownerOf;
  mapping(address => uint256) public balanceOf;

  // shugo.eth
  address payable internal immutable shugo =
    payable(address(0xE95330D7CDcd37bf0Ad875C29e2a2871FeFa3De8));
  uint256 internal nextTokenId = 1;
  uint256 public tsujiBackVote = 0;

  constructor() payable {
    // shugo.eth
    playerOf[shugo] = player(1, "shugo", false);
    // tomona.eth
    playerOf[address(0x2aF8DDAb77A7c90a38CF26F29763365D0028cfEf)] = player(
      2,
      "mona",
      false
    );
    // kaki.eth
    playerOf[address(0x4fd9D0eE6D6564E80A9Ee00c0163fC952d0A45Ed)] = player(
      3,
      "kaki",
      false
    );
    // kohei.eth
    playerOf[address(0x5D025814b6a21Cd6fcb4112F40f88bC823e6A9ab)] = player(
      4,
      "kohei",
      false
    );
    // datz.eth
    playerOf[address(0x1F80593194F5E71087cAfF5309e85Fe68292CB63)] = player(
      5,
      "datz",
      false
    );
    // eisuke.eth
    playerOf[address(0x7E989e785d0836b509B814a7898356FdeAAAE889)] = player(
      6,
      "eisuke",
      false
    );
    // thomaskobayashi.eth
    playerOf[address(0xD30Fb00c2796cBAD72f6B9C410830Dc4FF05bA71)] = player(
      7,
      "thomaskobayashi",
      false
    );
    // inakazu
    playerOf[address(0x5dC79C9fB20B6A81588a32589cb8Ae8f4983DfBc)] = player(
      8,
      "inakazu",
      false
    );
    // futa
    playerOf[address(0xe7236c912945C8B915c7C60b55e330b959801B45)] = player(
      9,
      "futa",
      false
    );
    // oliver
    playerOf[address(0x70B122116b50178D881e74Ec97b89c67E90b4A7c)] = player(
      10,
      "oliver",
      false
    );
  }

  modifier onlyIfTsujiBack() {
    if (tsujiBackVote < quorum) revert TsujiNotBack();
    _;
  }

  modifier onlyIfPlayer() {
    if (playerOf[msg.sender].rank == 0) revert PokerBound();
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
                  bytes(
                    render(
                      playerOf[ownerOf[tokenId]].name,
                      playerOf[ownerOf[tokenId]].rank
                    )
                  )
                ),
                '", "description": "Tsuji Poker Night in San Francisco on 2022/05/29"}'
              )
            )
          )
        )
      );
  }

  function rankOf(address _to) public view returns (uint256) {
    return playerOf[_to].rank;
  }

  function voterClaimOf(address _to) public view returns (bool) {
    return playerOf[_to].voted;
  }

  function vote() public onlyIfPlayer {
    if (balanceOf[msg.sender] == 0) revert PokerBound();
    if (playerOf[msg.sender].voted == true) revert PokerBound();

    unchecked {
      playerOf[msg.sender].voted = true;
      tsujiBackVote++;
    }
  }

  function withdraw() public onlyIfPlayer onlyIfTsujiBack {
    shugo.transfer(address(this).balance);
  }
}
