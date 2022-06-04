// SPDX-License-Identifier: MIT

pragma solidity ^0.8.13;

import "base64-sol/base64.sol";
import "./Renderer.sol";
import { Renderer } from "./Renderer.sol";

contract FutaSanBirthday {
  error SoulBound();

  mapping(uint256 => address) public ownerOf;
  mapping(address => uint256) public balanceOf;

  event Transfer(address indexed from, address indexed to, uint256 indexed id);

  uint256 internal nextTokenId = 1;
  Renderer public renderer;

  string public constant symbol = "FUTA";
  string public constant name = "Futa-san Birthday NFT";

  constructor() {
    renderer = new Renderer();
  }

  function approve(address, uint256) public virtual {
    revert SoulBound();
  }

  function isApprovedForAll(address, address) public pure {
    revert SoulBound();
  }

  function getApproved(uint256) public pure {
    revert SoulBound();
  }

  function setApprovalForAll(address, bool) public virtual {
    revert SoulBound();
  }

  function transferFrom(
    address,
    address,
    uint256
  ) public virtual {
    revert SoulBound();
  }

  function safeTransferFrom(
    address,
    address,
    uint256
  ) public virtual {
    revert SoulBound();
  }

  function safeTransferFrom(
    address,
    address,
    uint256,
    bytes calldata
  ) public virtual {
    revert SoulBound();
  }

  function supportsInterface(bytes4 interfaceId) public pure returns (bool) {
    return
      interfaceId == 0x01ffc9a7 ||
      interfaceId == 0x80ac58cd ||
      interfaceId == 0x5b5e139f;
  }

  function mint(address _to) public payable {
    unchecked {
      balanceOf[_to]++;
    }

    ownerOf[nextTokenId] = _to;
    emit Transfer(address(0), _to, nextTokenId++);
  }

  function renderSVG() internal view returns (string memory) {
    return renderer.render();
  }

  function tokenURI(uint256 tokenId) public view returns (string memory) {
    return
      string(
        abi.encodePacked(
          "data:application/json;base64,",
          Base64.encode(
            bytes(
              abi.encodePacked(
                '{"name":"Futa-san 27th Birthday",',
                '"image":"data:image/svg+xml;base64,',
                Base64.encode(bytes(renderSVG())),
                '", "description": "Futa-san Birthday Night in San Francisco on 2022/06/03"}'
              )
            )
          )
        )
      );
  }
}
