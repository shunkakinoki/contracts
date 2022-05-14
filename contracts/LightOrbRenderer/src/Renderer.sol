// SPDX-License-Identifier: MIT

import "@openzeppelin/contracts/utils/Strings.sol";

pragma solidity ^0.8.13;

contract Renderer {
  string[][13] public colors;

  constructor() {
    // GRAY
    colors[0] = ["6b7280", "e5e7eb"];
    // RED
    colors[1] = ["ef4444", "ef4444"];
    // ORANGE
    colors[2] = ["f97316", "fed7aa"];
    // YELLOW
    colors[3] = ["f59e0b", "fde68a"];
    // GREEN
    colors[4] = ["10b981", "a7f3d0"];
    // TEAL
    colors[5] = ["14b8a6", "99f6e4"];
    // CYAN
    colors[6] = ["06b6d4", "cffafe"];
    // SKY
    colors[7] = ["0ea5e9", "bae6fd"];
    // BLUE
    colors[8] = ["3b82f6", "bfdbfe"];
    // INDIGO
    colors[9] = ["6366f1", "c7d2fe"];
    // PURPLE
    colors[10] = ["8b5cf6", "ddd6fe"];
    // PINK
    colors[11] = ["ec4899", "fbcfe8"];
    // ROSE
    colors[12] = ["f43f5e", "fecdd3"];
  }

  function getColor(address _owner, uint256 _index)
    public
    view
    returns (string memory)
  {
    uint256 _tokenId = getAddressId(_owner);
    return colors[_tokenId][_index];
  }

  function getAddressId(address _owner) public pure returns (uint256) {
    return uint256(uint160(_owner)) % 13;
  }

  function render(address _owner) public view returns (string memory) {
    return
      string.concat(
        '<svg width="300" height="300" viewBox="0 0 48 48" fill="none" xmlns="http://www.w3.org/2000/svg"><circle cx="24" cy="24" r="24" fill="url(#r)"/><defs><radialGradient id="r" cx="0" cy="0" r="1" gradientUnits="userSpaceOnUse" gradientTransform="translate(38 24) rotate(180) scale(38 39.1805)"><stop stop-color="#3d505c"/><stop offset="0.670535" stop-color="#101417"/><stop offset="0.950763" stop-color="#',
        getColor(_owner, 0),
        '"/><stop offset="1" stop-color="#',
        getColor(_owner, 1),
        '"/></radialGradient></defs></svg>'
      );
  }

  function example() external view returns (string memory) {
    return render(address(0));
  }
}
