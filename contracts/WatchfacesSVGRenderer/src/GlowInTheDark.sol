// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.13;

import "./SVG.sol";
import "./WatchData.sol";
import "./Mood.sol";

// Includes all relevant special data and rendering for
// the 1/1 Glow in the Dark Watchface.
library GlowInTheDark {
  function generateMaterialTokens() public pure returns (string memory) {
    WatchData.GlowInTheDarkData memory _data = WatchData.getGlowInTheDarkData();

    return
      string.concat(generateDarkModeCss(_data), generateLightModeCss(_data));
  }

  function generateDarkModeCss(WatchData.GlowInTheDarkData memory _data)
    internal
    pure
    returns (string memory)
  {
    // not in a query, so it's dark mode by default.
    return
      string.concat(
        "*{",
        // bezel colors
        // bezel primary
        utils.setCssVar("bp", _data.dark[0]),
        // // bezel secondary
        utils.setCssVar("bs", _data.dark[1]),
        // // bezel accent
        utils.setCssVar("ba", _data.dark[1]),
        // // face colors
        // // face primary
        utils.setCssVar("fp", _data.dark[0]),
        // // face secondary
        utils.setCssVar("fs", _data.dark[1]),
        // // face accent
        utils.setCssVar("fa", utils.getCssVar("black")),
        "}",
        ".mood-light{display:none;}",
        ".mood-dark{display:block;}",
        ".glasses-flip{",
        "transform:translateY(-56px);",
        "transition: transform 0.2s;",
        "}"
      );
  }

  function generateLightModeCss(WatchData.GlowInTheDarkData memory _data)
    internal
    pure
    returns (string memory)
  {
    return
      string.concat(
        "@media(prefers-color-scheme:light){",
        "*{",
        // bezel colors
        // bezel primary
        utils.setCssVar("bp", _data.light[0]),
        // // bezel secondary
        utils.setCssVar("bs", _data.light[1]),
        // // bezel accent
        utils.setCssVar("ba", utils.getCssVar("black")),
        // // face colors
        // // face primary
        utils.setCssVar("fp", _data.light[0]),
        // // face secondary
        utils.setCssVar("fs", _data.light[1]),
        // // face accent
        utils.setCssVar("fa", utils.getCssVar("black")),
        "}",
        ".mood-dark{display:none;}",
        ".mood-light{display:block;}",
        ".glasses-flip{",
        "transform:translateY(0px);",
        "transition: transform 0.2s;",
        "}",
        "}"
      );
  }

  function renderGlasses() public pure returns (string memory) {
    return
      svg.g(
        string.concat(
          svg.prop("stroke-width", "1"),
          svg.prop("stroke", utils.getCssVar("fa")),
          svg.prop("stroke-opacity", "0.35")
        ),
        string.concat(
          svg.circle(
            string.concat(
              svg.prop("cx", utils.uint2str(236)),
              svg.prop("cy", utils.uint2str(140)),
              svg.prop("r", utils.uint2str(28)),
              svg.prop("fill", utils.getCssVar("rg")),
              svg.prop("fill-opacity", "0.5")
            ),
            utils.NULL
          ),
          svg.circle(
            string.concat(
              svg.prop("cx", utils.uint2str(124)),
              svg.prop("cy", utils.uint2str(140)),
              svg.prop("r", utils.uint2str(28)),
              svg.prop("fill", utils.getCssVar("rg")),
              svg.prop("fill-opacity", "0.5")
            ),
            utils.NULL
          ),
          svg.path(svg.prop("d", "M124 112h115"), utils.NULL),
          svg.path(svg.prop("d", "M152 140h56"), utils.NULL),
          svg.g(
            svg.prop("class", "glasses-flip"),
            string.concat(
              svg.circle(
                string.concat(
                  svg.prop("cx", utils.uint2str(236)),
                  svg.prop("cy", utils.uint2str(140)),
                  svg.prop("r", utils.uint2str(28)),
                  svg.prop("fill", utils.getCssVar("bs")),
                  svg.prop("fill-opacity", "0.5")
                ),
                utils.NULL
              ),
              svg.circle(
                string.concat(
                  svg.prop("cx", utils.uint2str(124)),
                  svg.prop("cy", utils.uint2str(140)),
                  svg.prop("r", utils.uint2str(28)),
                  svg.prop("fill", utils.getCssVar("bs")),
                  svg.prop("fill-opacity", "0.5")
                ),
                utils.NULL
              )
            )
          )
        )
      );
  }

  function renderMood() public pure returns (string memory) {
    return
      svg.g(
        svg.prop("filter", utils.getDefURL("insetShadow")),
        string.concat(
          svg.g(
            svg.prop("class", "mood-light"),
            string.concat(
              Mood.renderMouth(MouthType.BottomFill),
              Mood.renderEye(EyeType.TopHalf, EyePosition.Left),
              Mood.renderEye(EyeType.TopHalf, EyePosition.Right)
            )
          ),
          svg.g(
            svg.prop("class", "mood-dark"),
            string.concat(
              Mood.renderMouth(MouthType.WholeFill),
              Mood.renderEye(EyeType.Closed, EyePosition.Left),
              Mood.renderEye(EyeType.Closed, EyePosition.Right)
            )
          )
        )
      );
  }
}
