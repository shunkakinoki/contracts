// SPDX-License-Identifier: MIT
// Code from: https://raw.githubusercontent.com/w1nt3r-eth/hot-chain-svg/main/contracts/Renderer.sol

pragma solidity ^0.8.13;

import "./SVG.sol";
import "./Utils.sol";

contract Renderer {
  function render() public view returns (string memory) {
    uint256 NEXT_BIRTHDAY_TIMESTAMP = 1685862000;
    uint256 YEAR_SECONDS = 31536000;

    return
      string.concat(
        '<svg xmlns="http://www.w3.org/2000/svg" width="400" height="400" style="background:#000">',
        svg.text(
          string.concat(
            svg.prop("x", "65"),
            svg.prop("y", "160"),
            svg.prop("font-size", "30"),
            svg.prop("fill", "white")
          ),
          string.concat(svg.cdata("Futa-san 27th Birthday"), utils.NULL)
        ),
        svg.rect(
          string.concat(
            svg.prop("fill", "red"),
            svg.prop("x", "65"),
            svg.prop("y", "200"),
            svg.prop(
              "width",
              utils.uint2str(
                ((NEXT_BIRTHDAY_TIMESTAMP - block.timestamp) / YEAR_SECONDS) *
                  270
              )
            ),
            svg.prop("height", utils.uint2str(12))
          ),
          utils.NULL
        ),
        svg.text(
          string.concat(
            svg.prop("x", "115"),
            svg.prop("y", "260"),
            svg.prop("font-size", "18"),
            svg.prop("fill", "white")
          ),
          string.concat(
            svg.cdata("Time left: "),
            utils.uint2str(block.timestamp)
          )
        ),
        "</svg>"
      );
  }

  function example() external returns (string memory) {
    return render();
  }
}
