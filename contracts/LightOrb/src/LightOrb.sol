// SPDX-License-Identifier: GPL-3.0-or-later

pragma solidity ^0.8.13;

import "@openzeppelin/contracts/security/ReentrancyGuard.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import { Base64 } from "base64-sol/base64.sol";
import { Renderer } from "../../LightOrbRenderer/src/Renderer.sol";

contract LightOrb is ERC721, ReentrancyGuard, Ownable {
  using Counters for Counters.Counter;
  using Strings for uint256;
  Counters.Counter private supplyCounter;
  Renderer public renderer;
  bool public mintIsOpen = false;

  constructor() ERC721("Light Orbs", "LORB") {}

  function safeMint(address to) public onlyOwner {
    require(mintIsOpen, "Mint not open");
    uint256 tokenId = supplyCounter.current();
    supplyCounter.increment();
    _safeMint(to, tokenId);
  }

  function airdrop(address[] memory to) external onlyOwner {
    for (uint256 i = 0; i < to.length; i++) {
      supplyCounter.increment();
      _mint(to[i], supplyCounter.current());
    }
  }

  function setMintIsOpen(bool _saleIsActive_) external onlyOwner {
    mintIsOpen = _saleIsActive_;
  }

  function totalSupply() public view returns (uint256) {
    return supplyCounter.current();
  }

  function tokenURI(uint256 tokenId)
    public
    view
    override
    returns (string memory)
  {
    require(_exists(tokenId), "No token exists");

    string memory idString = Strings.toString(tokenId);

    return
      encodeMetadataJSON(
        abi.encodePacked(
          '{"name": "Light Orb #',
          idString,
          '", "description": "Light Orb", "image": "',
          renderer.render(ownerOf(tokenId)),
          '"}'
        )
      );
  }

  function base64Encode(bytes memory unencoded)
    public
    pure
    returns (string memory)
  {
    return Base64.encode(unencoded);
  }

  function encodeMetadataJSON(bytes memory json)
    public
    pure
    returns (string memory)
  {
    return
      string(
        abi.encodePacked("data:application/json;base64,", base64Encode(json))
      );
  }
}
