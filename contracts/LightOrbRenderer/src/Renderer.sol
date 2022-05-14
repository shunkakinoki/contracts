// SPDX-License-Identifier: MIT

import "@openzeppelin/contracts/utils/Strings.sol";

pragma solidity ^0.8.13;

contract Renderer {
    using Strings for uint256;

  function render(uint256 _tokenId) public pure returns (string memory) {
    uint8[16] memory colors = [10, 2, 6, 42, 19, 5, 4, 36, 6, 6, 5, 5, 5, 46, 4, 4];

    return
      string.concat(
      '<svg xmlns="http://www.w3.org/2000/svg" width="300" height="300" viewBox="0 0 110 110"><defs>'
          // new gradient fix – test
          '<radialGradient id="gzr" gradientTransform="translate(66.4578 24.3575) scale(75.2908)" gradientUnits="userSpaceOnUse" r="1" cx="0" cy="0%">'
          // '<radialGradient fx="66.46%" fy="24.36%" id="grad">'
          '<stop offset="15.62%" stop-color="',
          Strings.toString(colors[0]),
          '" /><stop offset="39.58%" stop-color="',
          Strings.toString(colors[1]),
          '" /><stop offset="72.92%" stop-color="',
          Strings.toString(colors[2]),
          '" /><stop offset="90.63%" stop-color="',
          Strings.toString(colors[3]),
          '" /><stop offset="100%" stop-color="',
          Strings.toString(colors[4]),
          '" /></radialGradient></defs><g transform="translate(5,5)">'
          '<path d="M100 50C100 22.3858 77.6142 0 50 0C22.3858 0 0 22.3858 0 50C0 77.6142 22.3858 100 50 100C77.6142 100 100 77.6142 100 50Z" fill="url(#gzr)" /><path stroke="rgba(0,0,0,0.075)" fill="transparent" stroke-width="1" d="M50,0.5c27.3,0,49.5,22.2,49.5,49.5S77.3,99.5,50,99.5S0.5,77.3,0.5,50S22.7,0.5,50,0.5z" />'
          "</g></svg>"
      );
  }

  function example() external pure returns (string memory) {
    return render(1);
  }
}
