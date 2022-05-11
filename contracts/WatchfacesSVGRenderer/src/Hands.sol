// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.13;

import "./SVG.sol";
import "./WatchData.sol";

// Renders the hands, which are layered on top of every other core element
library Hands {
  function render(
    uint256 _second,
    uint256 _minute,
    uint256 _hour
  ) public pure returns (string memory) {
    return
      svg.g(
        string.concat(
          svg.prop("stroke", utils.getCssVar("fa")),
          svg.prop("stroke-opacity", "0.1"),
          svg.prop("filter", utils.getDefURL("dropShadow"))
        ),
        string.concat(
          // Seconds
          renderHand(
            3,
            WatchData.FACE_RADIUS,
            _second * 6,
            utils.getCssVar("fp"),
            utils.getDefURL("ibg")
          ),
          // Minutes
          renderHand(
            4,
            // 0.75 length
            110,
            _minute * 6,
            utils.getDefURL("ibg"),
            utils.getCssVar("bs")
          ),
          // // Hours
          renderHand(
            4,
            // 0.35 length,
            50,
            ((_hour % 12) * 30 + ((_minute / 60) * 30)),
            utils.getDefURL("ibg"),
            utils.getCssVar("bs")
          ),
          renderCenter()
        )
      );
  }

  function renderCenter() internal pure returns (string memory) {
    return
      svg.circle(
        string.concat(
          svg.prop("cx", utils.uint2str(WatchData.CENTER)),
          svg.prop("cy", utils.uint2str(WatchData.CENTER)),
          svg.prop("r", "6"),
          svg.prop("fill", utils.getCssVar("fp"))
        ),
        utils.NULL
      );
  }

  function renderHand(
    uint256 _width,
    uint256 _length,
    uint256 _degree,
    string memory _mainColor,
    string memory _secondaryColor
  ) internal pure returns (string memory) {
    return
      svg.g(
        svg.prop(
          "transform",
          string(string.concat("rotate(", utils.uint2str(_degree), " 180 180)"))
        ),
        string.concat(
          renderMainHandPart(_width, _length, _mainColor),
          renderInnerHandPart(_width, _length, _secondaryColor)
        )
      );
  }

  function renderMainHandPart(
    uint256 _width,
    uint256 _length,
    string memory _color
  ) internal pure returns (string memory) {
    return
      svg.rect(
        string.concat(
          commonHandProps(
            (WatchData.CENTER - _width / 2),
            (WatchData.CENTER - _length + 16),
            _width,
            _length,
            _color,
            "2"
          )
        ),
        utils.NULL
      );
  }

  function renderInnerHandPart(
    uint256 _width,
    uint256 _length,
    string memory _color
  ) internal pure returns (string memory) {
    return
      svg.rect(
        string.concat(
          commonHandProps(
            (WatchData.CENTER - _width / 4),
            (WatchData.CENTER - _length + 17),
            _width / 2,
            _length / 4,
            _color,
            "1"
          )
        ),
        utils.NULL
      );
  }

  function commonHandProps(
    uint256 _x,
    uint256 _y,
    uint256 _width,
    uint256 _height,
    string memory _fill,
    string memory _rx
  ) internal pure returns (string memory) {
    return
      string.concat(
        svg.prop("x", utils.uint2str(_x)),
        svg.prop("y", utils.uint2str(_y)),
        svg.prop("width", utils.uint2str(_width)),
        svg.prop("height", utils.uint2str(_height)),
        svg.prop("fill", _fill),
        svg.prop("rx", _rx)
      );
  }
}
