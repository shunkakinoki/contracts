// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.13;

import "./SVG.sol";
import "./WatchData.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

// Renders the Bezel, which includes the address and progress bar.
library Bezel {
  function render(
    address _address,
    string memory _ensName,
    uint256 _holdingProgress
  ) public pure returns (string memory) {
    uint256 circumference = 1118; /* 2 * Pi * BezelRadius - 12 (??? idk what the -12 is, but it makes it look right.) */

    // if progress is > 1000, you have reached the minimum.
    bool isComplete = _holdingProgress >= 1000;

    // Need to convert progress into an offset value around the circle so
    // the ring can render correctly
    uint256 holdingProgressOffset = isComplete
      ? circumference
      : ((circumference * _holdingProgress) / 1000);

    return
      svg.g(
        utils.NULL,
        string.concat(
          // Outer bezel.
          svg.circle(
            string.concat(
              svg.prop("cx", utils.uint2str(WatchData.CENTER)),
              svg.prop("cy", utils.uint2str(WatchData.CENTER)),
              svg.prop("r", utils.uint2str(WatchData.OUTER_BEZEL_RADIUS)),
              svg.prop("fill", utils.getDefURL("obg"))
            ),
            utils.NULL
          ),
          // Dark bezel overlay
          svg.circle(
            string.concat(
              svg.prop("cx", utils.uint2str(WatchData.CENTER)),
              svg.prop("cy", utils.uint2str(WatchData.CENTER)),
              svg.prop(
                "r",
                utils.uint2str((WatchData.OUTER_BEZEL_RADIUS * 98) / 100)
              ),
              svg.prop("fill", utils.getCssVar("black")),
              svg.prop("fill-opacity", isComplete ? "0.3" : "0"),
              svg.prop(
                "style",
                string.concat(
                  "mix-blend-mode:hard-light;",
                  isComplete
                    ? "animation: fadeOpacity 4s ease-in-out infinite;"
                    : utils.NULL
                )
              )
            ),
            utils.NULL
          ),
          renderProgressBar(circumference, holdingProgressOffset, isComplete),
          // ADDRESS (includes inner bezel)
          renderAddressAndInnerBezel(_address, _ensName)
        )
      );
  }

  function renderProgressBar(
    uint256 _circumference,
    uint256 _progressOffset,
    bool _isComplete
  ) internal pure returns (string memory) {
    string memory strokeProps = string.concat(
      svg.prop("stroke", utils.getCssVar("ba")),
      svg.prop("stroke-width", "2"),
      svg.prop("stroke-dasharray", utils.uint2str(_circumference)),
      svg.prop("stroke-linecap", "round"),
      svg.prop(
        "stroke-dashoffset",
        utils.uint2str(_circumference - _progressOffset)
      )
    );

    return
      svg.circle(
        string.concat(
          svg.prop("opacity", _isComplete ? "0.75" : "0.4"),
          svg.prop("cx", utils.uint2str(WatchData.CENTER)),
          svg.prop("cy", utils.uint2str(WatchData.CENTER)),
          svg.prop(
            "r",
            utils.uint2str((WatchData.OUTER_BEZEL_RADIUS * 99) / 100)
          ),
          svg.prop("fill", "transparent"),
          svg.prop("transform", "rotate(270 180 180)"),
          strokeProps
        ),
        utils.NULL
      );
  }

  function renderAddressAndInnerBezel(address _address, string memory _ensName)
    internal
    pure
    returns (string memory)
  {
    string memory ownerAddress = Strings.toHexString(
      uint256(uint160(_address))
    );
    bool hasEns = !utils.stringsEqual(_ensName, "");
    string memory SEPARATOR = " ";
    string memory fullAddress = hasEns
      ? (string.concat(SEPARATOR, _ensName, SEPARATOR, ownerAddress))
      : (string.concat(SEPARATOR, ownerAddress));
    uint256 fullAddressLen = utils.utfStringLength(fullAddress);

    /* circumference - charWidth * address length.
        = how much space is left to distribute between the characters.*/
    uint256 spaceLeft = 1016 - /* circumference = Math.ceil(2*Pi*r(161)) + 4 */
      7 * /* ~approximate char width in pixels across browsers. */
      fullAddressLen;

    // scale everything by 1000
    uint256 letterSpacingRaw = (spaceLeft * 1000) / fullAddressLen;
    uint256 letterSpacingDecimal = (letterSpacingRaw % 1000) / 100;
    uint256 letterSpacingWhole = (letterSpacingRaw - letterSpacingDecimal) /
      1000;

    return
      svg.g(
        string.concat(
          svg.prop("fill", utils.getCssVar("ba")),
          svg.prop("font-size", utils.getCssVar("bts"))
        ),
        string.concat(
          svg.animateTransform(
            string.concat(
              svg.prop("attributeName", "transform"),
              svg.prop("attributeType", "XML"),
              svg.prop("type", "rotate"),
              svg.prop("from", "0 180 180"),
              svg.prop("to", "360 180 180"),
              svg.prop("dur", "120s"),
              svg.prop("repeatCount", "indefinite")
            )
          ),
          // Inner bezel
          svg.circle(
            string.concat(
              svg.prop("cx", utils.uint2str(WatchData.CENTER)),
              svg.prop("cy", utils.uint2str(WatchData.CENTER)),
              svg.prop("r", utils.uint2str(WatchData.INNER_BEZEL_RADIUS)),
              svg.prop("fill", utils.getDefURL("ibg")),
              svg.prop("stroke-width", "1"),
              svg.prop("stroke", utils.getDefURL("rg"))
            ),
            utils.NULL
          ),
          // Address text
          svg.text(
            string.concat(
              svg.prop(
                "letter-spacing",
                string.concat(
                  utils.uint2str(letterSpacingWhole),
                  ".",
                  utils.uint2str(letterSpacingDecimal)
                )
              ),
              svg.prop("opacity", "0.5"),
              svg.prop(
                "style",
                "text-transform:uppercase;text-shadow:var(--textShadow);"
              )
            ),
            svg.el(
              "textPath",
              svg.prop("href", "#addressPath"),
              // fullAddress
              string.concat("<![CDATA[", fullAddress, "]]>")
            )
          ),
          svg.el(
            "defs",
            utils.NULL,
            svg.path(
              string.concat(
                svg.prop(
                  "d",
                  "M19,180a161,161 0 1,1 323,0a161,161 0 1,1 -323,0"
                ),
                svg.prop("id", "addressPath")
              ),
              utils.NULL
            )
          )
        )
      );
  }
}
