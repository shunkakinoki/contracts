// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.13;

import "./Utils.sol";
import "./SVG.sol";
import "./WatchData.sol";

enum EyeType {
  Open,
  Closed,
  TopHalf,
  BottomHalf,
  Wink
}

enum EyeTickLineType {
  Outside,
  InsideTop,
  InsideBottom
}

enum EyePosition {
  Left,
  Right
}

enum MouthType {
  Line,
  BottomStroke,
  BottomFill,
  TopFill,
  WholeFill
}

// Convenience functions for formatting all the metadata related to a particular NFT
library Mood {
  function render(uint256 _id) public pure returns (string memory) {
    WatchData.MoodId moodId = WatchData.MoodId(_id);

    if (moodId == WatchData.MoodId.Surprised) {
      return
        svg.g(
          utils.NULL,
          string.concat(
            renderMouth(MouthType.WholeFill),
            renderEye(EyeType.Open, EyePosition.Left),
            renderEye(EyeType.Open, EyePosition.Right)
          )
        );
    } else if (moodId == WatchData.MoodId.Happy) {
      return
        svg.g(
          utils.NULL,
          string.concat(
            renderMouth(MouthType.BottomStroke),
            renderEye(EyeType.TopHalf, EyePosition.Left),
            renderEye(EyeType.TopHalf, EyePosition.Right)
          )
        );
    } else if (moodId == WatchData.MoodId.Relaxed) {
      return
        svg.g(
          utils.NULL,
          string.concat(
            renderMouth(MouthType.BottomStroke),
            renderEye(EyeType.Closed, EyePosition.Left),
            renderEye(EyeType.Closed, EyePosition.Right)
          )
        );
    } else if (moodId == WatchData.MoodId.Excited) {
      return
        svg.g(
          utils.NULL,
          string.concat(
            renderMouth(MouthType.BottomFill),
            renderEye(EyeType.TopHalf, EyePosition.Left),
            renderEye(EyeType.TopHalf, EyePosition.Right)
          )
        );
    } else if (moodId == WatchData.MoodId.Speechless) {
      return
        svg.g(
          utils.NULL,
          string.concat(
            renderEye(EyeType.Open, EyePosition.Left),
            renderEye(EyeType.Open, EyePosition.Right)
          )
        );
    } else if (moodId == WatchData.MoodId.Chilling) {
      return
        svg.g(
          utils.NULL,
          string.concat(
            renderMouth(MouthType.BottomFill),
            renderEye(EyeType.BottomHalf, EyePosition.Left),
            renderEye(EyeType.BottomHalf, EyePosition.Right)
          )
        );
    } else if (moodId == WatchData.MoodId.Annoyed) {
      return
        svg.g(
          utils.NULL,
          string.concat(
            renderMouth(MouthType.TopFill),
            renderEye(EyeType.BottomHalf, EyePosition.Left),
            renderEye(EyeType.BottomHalf, EyePosition.Right)
          )
        );
    } else if (moodId == WatchData.MoodId.Sleepy) {
      return
        svg.g(
          utils.NULL,
          string.concat(
            renderMouth(MouthType.WholeFill),
            renderEye(EyeType.Closed, EyePosition.Left),
            renderEye(EyeType.Closed, EyePosition.Right)
          )
        );
    } else if (moodId == WatchData.MoodId.Unimpressed) {
      return
        svg.g(
          utils.NULL,
          string.concat(
            renderMouth(MouthType.Line),
            renderEye(EyeType.BottomHalf, EyePosition.Left),
            renderEye(EyeType.BottomHalf, EyePosition.Right)
          )
        );
    } else if (moodId == WatchData.MoodId.Meditating) {
      return
        svg.g(
          utils.NULL,
          string.concat(
            renderMouth(MouthType.Line),
            renderEye(EyeType.Closed, EyePosition.Left),
            renderEye(EyeType.Closed, EyePosition.Right)
          )
        );
    } else if (moodId == WatchData.MoodId.Relieved) {
      return
        svg.g(
          utils.NULL,
          string.concat(
            renderMouth(MouthType.BottomFill),
            renderEye(EyeType.Closed, EyePosition.Left),
            renderEye(EyeType.Closed, EyePosition.Right)
          )
        );
    } else if (moodId == WatchData.MoodId.Cheeky) {
      return
        svg.g(
          utils.NULL,
          string.concat(
            renderMouth(MouthType.BottomFill),
            renderEye(EyeType.TopHalf, EyePosition.Left),
            renderEye(EyeType.Wink, EyePosition.Right)
          )
        );
    } else if (moodId == WatchData.MoodId.Sus) {
      return
        svg.g(
          utils.NULL,
          string.concat(
            renderMouth(MouthType.Line),
            renderEye(EyeType.Wink, EyePosition.Left),
            renderEye(EyeType.Wink, EyePosition.Right)
          )
        );
    }

    return utils.NULL;
  }

  function renderEye(EyeType _type, EyePosition _position)
    public
    pure
    returns (string memory)
  {
    if (_type == EyeType.Open) {
      return
        eyeContainer(
          _position,
          string.concat(
            renderEyePupil(_type),
            renderEyeTicklines(EyeTickLineType.InsideTop)
          )
        );
    } else if (_type == EyeType.Closed) {
      return
        eyeContainer(
          _position,
          string.concat(
            renderEyePupil(_type),
            renderEyeTicklines(EyeTickLineType.Outside)
          )
        );
    } else if (_type == EyeType.BottomHalf) {
      return
        eyeContainer(
          _position,
          string.concat(
            renderEyePupil(_type),
            renderEyeTicklines(EyeTickLineType.InsideTop)
          )
        );
    } else if (_type == EyeType.TopHalf) {
      return
        eyeContainer(
          _position,
          string.concat(
            renderEyePupil(_type),
            renderEyeTicklines(EyeTickLineType.InsideTop)
          )
        );
    } else if (_type == EyeType.Wink) {
      return
        eyeContainer(
          _position,
          string.concat(
            renderEyePupil(_type),
            renderEyeTicklines(EyeTickLineType.InsideBottom)
          )
        );
    }
    return "";
  }

  // Eye and Eye helpers
  // Contains all contents and purely deals with setting the x/y position.
  function eyeContainer(EyePosition _position, string memory _children)
    private
    pure
    returns (string memory)
  {
    uint256 xPos = _position == EyePosition.Left
      ? 124 /* left */
      : 236; /* right */
    uint256 yPos = 140;

    return
      svg.g(
        svg.prop(
          "transform",
          string.concat(
            "translate(",
            utils.uint2str(xPos),
            " ",
            utils.uint2str(yPos),
            ")"
          )
        ),
        string.concat(
          // always use this background circle behind every eye combo / contents.
          svg.circle(
            string.concat(
              svg.prop("cx", utils.uint2str(0)),
              svg.prop("cy", utils.uint2str(0)),
              svg.prop("r", utils.uint2str(36)),
              svg.prop("fill", utils.getCssVar("fs")),
              svg.prop("filter", utils.getDefURL("insetShadow")),
              svg.prop("stroke", utils.getCssVar("fa")),
              svg.prop("stroke-opacity", "0.35")
            ),
            utils.NULL
          ),
          _children
        )
      );
  }

  function renderEyePupil(EyeType _type) private pure returns (string memory) {
    if (_type == EyeType.Open) {
      return
        svg.circle(
          string.concat(
            svg.prop("r", utils.uint2str(8)),
            svg.prop("fill", utils.getCssVar("fa")),
            svg.prop("opacity", "0.4")
          ),
          utils.NULL
        );
    } else if (_type == EyeType.Closed) {
      return
        svg.path(
          string.concat(
            svg.prop("fill", "none"),
            svg.prop("stroke", utils.getCssVar("fa")),
            svg.prop("d", "M-32.4 0a32.4 32.4 0 0 0 64.8 0"),
            svg.prop("opacity", "0.4")
          ),
          utils.NULL
        );
    } else if (_type == EyeType.BottomHalf) {
      return
        svg.path(
          string.concat(
            svg.prop("fill", utils.getCssVar("fa")),
            svg.prop("stroke", utils.getCssVar("fa")),
            svg.prop("d", "M-9 0A9 9 0 0 0 9 0Z"),
            svg.prop("opacity", "0.4")
          ),
          utils.NULL
        );
    } else if (_type == EyeType.TopHalf) {
      return
        svg.path(
          string.concat(
            svg.prop("fill", utils.getCssVar("fa")),
            svg.prop("d", "M9 0A9 9 0 0 0-9 0Z"),
            svg.prop("opacity", "0.4")
          ),
          utils.NULL
        );
    } else if (_type == EyeType.Wink) {
      return
        svg.path(
          string.concat(
            svg.prop("stroke", utils.getCssVar("fa")),
            svg.prop("d", "M-8.1-2H8.1"),
            svg.prop("opacity", "0.4")
          ),
          utils.NULL
        );
    }
    return utils.NULL;
  }

  function renderEyeTicklines(EyeTickLineType _type)
    private
    pure
    returns (string memory)
  {
    if (_type == EyeTickLineType.Outside) {
      return
        svg.path(
          string.concat(
            svg.prop("stroke", utils.getCssVar("fa")),
            svg.prop(
              "d",
              "M43.2 0h-4m3.1 9-3.91259-.83165M39.5 17.6l-3.65418-1.62695M34.9 25.4l-3.23607-2.35114M28.9 32.1l-2.67652-2.97258M21.6 37.4l-2-3.4641M13.3 41.1l-1.23607-3.80423M4.5 43l-.41811-3.97809M-4.5 43l.41811-3.97809M-13.3 41.1l1.23607-3.80423M-21.6 37.4l2-3.4641M-28.9 32.1l2.67652-2.97258M-34.9 25.4l3.23607-2.35114M-39.5 17.6l3.65418-1.62695M-42.3 9l3.91259-.83165M-43.2 0h4"
            ),
            svg.prop("opacity", "0.35")
          ),
          utils.NULL
        );
    } else if (_type == EyeTickLineType.InsideTop) {
      return
        svg.path(
          string.concat(
            svg.prop("stroke", utils.getCssVar("fa")),
            svg.prop("opacity", "0.35"),
            svg.prop(
              "d",
              "m-31.7-6.7 3.91259.83165M-29.6-13.2l3.65418 1.62695M-26.2-19l3.23607 2.35114M-21.7-24.1l2.67652 2.97258M-16.2-28.1l2 3.4641M-10-30.8l1.23607 3.80423M-3.4-32.2l.41811 3.97809M3.4-32.2l-.41811 3.97809M10-30.8l-1.23607 3.80423M16.2-28.1l-2 3.4641m7.5.5359-2.67652 2.97258M26.2-19l-3.23607 2.35114M29.6-13.2l-3.65418 1.62695M31.7-6.7l-3.91259.83165"
            )
          ),
          utils.NULL
        );
    } else if (_type == EyeTickLineType.InsideBottom) {
      return
        svg.path(
          string.concat(
            svg.prop("stroke", utils.getCssVar("fa")),
            svg.prop("opacity", "0.35"),
            svg.prop(
              "d",
              "M32.4 0h-4m3.3 6.7-3.91259-.83165M29.6 13.2l-3.65418-1.62695M26.2 19l-3.23607-2.35114M21.7 24.1l-2.67652-2.97258M16.2 28.1l-2-3.4641M10 30.8l-1.23607-3.80423M3.4 32.2l-.41811-3.97809M-3.4 32.2l.41811-3.97809M-10 30.8l1.23607-3.80423M-16.2 28.1l2-3.4641m-7.5-.5359 2.67652-2.97258M-26.2 19l3.23607-2.35114M-29.6 13.2l3.65418-1.62695M-31.7 6.7l3.91259-.83165M-32.4 0h4"
            )
          ),
          utils.NULL
        );
    }

    return utils.NULL;
  }

  // Mouth and Mouth helpers
  function renderMouth(MouthType _type) public pure returns (string memory) {
    if (_type == MouthType.Line) {
      return
        svg.path(
          string.concat(
            svg.prop("stroke", utils.getCssVar("fa")),
            svg.prop("opacity", "0.35"),
            svg.prop("d", "M157.5 223h45")
          ),
          utils.NULL
        );
    } else if (_type == MouthType.BottomStroke) {
      return
        svg.path(
          string.concat(
            svg.prop("fill", "none"),
            svg.prop("stroke", utils.getCssVar("fa")),
            svg.prop("opacity", "0.35"),
            svg.prop("d", "M164.41154 217a18 18 0 0 0 31.17692 0")
          ),
          utils.NULL
        );
    } else if (_type == MouthType.BottomFill) {
      return
        svg.path(
          string.concat(
            svg.prop("fill", utils.getCssVar("fs")),
            svg.prop("stroke", utils.getCssVar("fa")),
            svg.prop("stroke-opacity", "0.35"),
            svg.prop("filter", utils.getDefURL("insetShadow")),
            svg.prop("d", "M157.5 216a22.5 22.5 0 0 0 45 0Z")
          ),
          utils.NULL
        );
    } else if (_type == MouthType.TopFill) {
      return
        svg.path(
          string.concat(
            svg.prop("fill", utils.getCssVar("fs")),
            svg.prop("stroke", utils.getCssVar("fa")),
            svg.prop("stroke-opacity", "0.35"),
            svg.prop("filter", utils.getDefURL("insetShadow")),
            svg.prop("d", "M202.5 240a22.5 22.5 0 0 0-45 0Z")
          ),
          utils.NULL
        );
    } else if (_type == MouthType.WholeFill) {
      return
        svg.circle(
          string.concat(
            svg.prop("r", utils.uint2str(11)),
            svg.prop("cx", utils.uint2str(180)),
            svg.prop("cy", utils.uint2str(225)),
            svg.prop("fill", utils.getCssVar("fs")),
            svg.prop("stroke", utils.getCssVar("fa")),
            svg.prop("filter", utils.getDefURL("insetShadow")),
            svg.prop("stroke-opacity", "0.35")
          ),
          utils.NULL
        );
    }
    return utils.NULL;
  }
}
