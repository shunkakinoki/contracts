// SPDX-License-Identifier: Unlicense

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/utils/Strings.sol";

contract Renderer {
  function render(
    uint256,
    address,
    uint256,
    uint256,
    string calldata
  ) public pure returns (string memory tokenURI) {
    tokenURI = "TODO";
  }
}

contract DumbRenderer {
  function render(
    uint256 tokenId,
    address owner,
    uint256 timestamp,
    uint256 holdingProgress,
    string calldata engraving
  ) public pure returns (string memory tokenURI) {
    tokenURI = string.concat(
      Strings.toString(tokenId),
      " by ",
      Strings.toHexString(uint256(uint160(owner))),
      " @ ",
      Strings.toString(timestamp),
      " ",
      Strings.toString(holdingProgress),
      " ",
      engraving
    );
  }
}

contract Web2Renderer {
  function render(
    uint256 tokenId,
    address owner,
    uint256 timestamp,
    uint256 holdingProgress,
    string calldata engraving
  ) public pure returns (string memory tokenURI) {
    tokenURI = string.concat(
      "https://www.watchfaces.world/api/watchface/",
      Strings.toString(tokenId),
      "-",
      Strings.toHexString(uint256(uint160(owner))),
      "-",
      Strings.toString(timestamp),
      "-",
      Strings.toString(holdingProgress),
      "-",
      engraving
    );
  }
}
