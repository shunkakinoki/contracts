//SPDX-License-Identifier: Unlicense

pragma solidity ^0.8.0;
import "./Utils.sol";

// Primary library for storing all core constants and rendering data.
library WatchData {
  /* CONSTANTS */
  uint256 public constant WATCH_SIZE = 360;
  uint256 public constant CENTER = 180;
  uint256 public constant OUTER_BEZEL_RADIUS = 180;
  uint256 public constant INNER_BEZEL_RADIUS = 152;
  uint256 public constant FACE_RADIUS = 144; // OUTER_BEZEL_RADIUS * 0.8
  uint8 public constant GLOW_IN_THE_DARK_ID = 99;

  /* IDs */
  enum MaterialId {
    Pearl,
    Copper,
    Onyx,
    Quartz,
    Emerald,
    Ruby,
    Sapphire,
    Amber,
    Amethyst,
    Obsidian,
    Gold,
    Diamond
  }

  enum MoodId {
    Surprised,
    Happy,
    Relaxed,
    Excited,
    Speechless,
    Chilling,
    Annoyed,
    Sleepy,
    Unimpressed,
    Meditating,
    Relieved,
    Cheeky,
    Sus
  }

  enum GlassesId {
    None,
    LeftMonocle,
    RightMonocle,
    Flip,
    Valentine,
    Shutters,
    ThreeD,
    Ski,
    Monolens
  }

  /* TRAIT STRUCTS */
  struct Material {
    MaterialId id;
    string name;
    string[2] vals;
  }

  struct Glasses {
    GlassesId id;
    string name;
  }

  struct Mood {
    MoodId id;
    string name;
  }

  struct GlowInTheDarkData {
    // contains the light mode colors
    string[2] light;
    // contains the dark mode colors
    string[2] dark;
    string name;
  }

  /* DATA RETRIEVAL */
  function getGlowInTheDarkData()
    public
    pure
    returns (GlowInTheDarkData memory)
  {
    return
      GlowInTheDarkData(
        ["#fbfffc", "#d7ffd7"],
        ["#052925", "#a4ffa1"],
        "Glow In The Dark"
      );
  }

  function getDiamondOverlayGradient() public pure returns (string[7] memory) {
    return [
      "#fffd92",
      "#ffcca7",
      "#f893ff",
      "#b393ff",
      "#99a7ff",
      "#76d4ff",
      "#7cffda"
    ];
  }

  function getMaterial(uint256 _materialId)
    public
    pure
    returns (Material memory)
  {
    Material[12] memory materials = [
      Material(MaterialId.Pearl, "Ocean Pearl", ["#ffffff", "#f6e6ff"]),
      Material(MaterialId.Copper, "Resistor Copper", ["#f7d1bf", "#5a2c1d"]),
      Material(MaterialId.Onyx, "Void Onyx", ["#615c5c", "#0f0f0f"]),
      Material(MaterialId.Quartz, "Block Quartz", ["#ffb4be", "#81004e"]),
      Material(MaterialId.Emerald, "Matrix Emerald", ["#97ff47", "#011601"]),
      Material(MaterialId.Ruby, "404 Ruby", ["#fe3d4a", "#460008"]),
      Material(
        MaterialId.Sapphire,
        "Hyperlink Sapphire",
        ["#4668ff", "#000281"]
      ),
      Material(MaterialId.Amber, "Sunset Amber", ["#ffa641", "#30031f"]),
      Material(MaterialId.Amethyst, "Candy Amethyst", ["#f7dfff", "#3671ca"]),
      Material(MaterialId.Obsidian, "Nether Obsidian", ["#6f00ff", "#2b003b"]),
      Material(MaterialId.Gold, "Electric Gold", ["#fcba7d", "#864800"]),
      Material(MaterialId.Diamond, "Ethereal Diamond", ["#b5f9ff", "#30c2c2"])
    ];

    return materials[_materialId];
  }

  function getMood(uint256 _moodId) public pure returns (Mood memory) {
    Mood[13] memory moods = [
      Mood(MoodId.Surprised, "Surprised"),
      Mood(MoodId.Happy, "Happy"),
      Mood(MoodId.Relaxed, "Relaxed"),
      Mood(MoodId.Excited, "Excited"),
      Mood(MoodId.Speechless, "Speechless"),
      Mood(MoodId.Chilling, "Chilling"),
      Mood(MoodId.Annoyed, "Annoyed"),
      Mood(MoodId.Sleepy, "Sleepy"),
      Mood(MoodId.Unimpressed, "Unimpressed"),
      Mood(MoodId.Meditating, "Meditating"),
      Mood(MoodId.Relieved, "Relieved"),
      Mood(MoodId.Cheeky, "Cheeky"),
      Mood(MoodId.Sus, "Sus")
    ];

    return moods[_moodId];
  }

  function getGlasses(uint256 _glassesId) public pure returns (Glasses memory) {
    Glasses[9] memory glasses = [
      Glasses(GlassesId.None, "None"),
      Glasses(GlassesId.LeftMonocle, "Left Monocle"),
      Glasses(GlassesId.RightMonocle, "Right Monocle"),
      Glasses(GlassesId.Flip, "Flip"),
      Glasses(GlassesId.Valentine, "Valentine"),
      Glasses(GlassesId.Shutters, "Shutters"),
      Glasses(GlassesId.ThreeD, "3D"),
      Glasses(GlassesId.Ski, "Ski"),
      Glasses(GlassesId.Monolens, "Monolens")
    ];

    return glasses[_glassesId];
  }

  /* UTILS */
  // used to determine proper accent colors.
  function isLightMaterial(MaterialId _id) public pure returns (bool) {
    return _id == MaterialId.Pearl || _id == MaterialId.Diamond;
  }

  function getMaterialAccentColor(MaterialId _id)
    public
    pure
    returns (string memory)
  {
    if (isLightMaterial(_id)) {
      return utils.getCssVar("black");
    }

    return utils.getCssVar("white");
  }

  function getMaterialShadow(MaterialId _id)
    public
    pure
    returns (string memory)
  {
    if (isLightMaterial(_id)) {
      return utils.black_a(85);
    }

    return utils.white_a(85);
  }
}
