// SPDX-License-Identifier: Unlicense
// Contract derived from etherscan at: https://etherscan.io/address/0x3aee59ca9cea21389d167112091ceace86747124#code
// All rights reserved to the author.

pragma solidity ^0.8.13;

// Base libraries
import "./SVG.sol";
import "./Utils.sol";
import "./WatchData.sol";
import "./DateTime.sol";
import "./Base64.sol";
import "./Metadata.sol";

// Component libraries
import "./Bezel.sol";
import "./Face.sol";
import "./Hands.sol";
import "./Glasses.sol";
import "./Mood.sol";
import "./GlowInTheDark.sol";

interface IDefaultResolver {
  function name(bytes32 node) external view returns (string memory);
}

interface IReverseRegistrar {
  function node(address addr) external view returns (bytes32);

  function defaultResolver() external view returns (IDefaultResolver);
}

// Core Renderer called from the main contract. It takes in a Watchface configuration
// and pulls together every component's individual library to render the final Watchface.
contract SvgRenderer {
  struct WatchConfiguration {
    uint8 bezelId;
    uint8 faceId;
    uint8 moodId;
    uint8 glassesId;
  }

  uint256 constant BEZEL_PART_BASE = 1000000;
  uint256 constant FACE_PART_BASE = 10000;
  uint256 constant MOOD_PART_BASE = 100;
  uint256 constant GLASSES_PART_BASE = 1;

  function render(
    uint256 _tokenId,
    address _owner,
    uint256 _timestamp,
    uint256 _holdingProgress,
    string calldata _engraving
  ) public view returns (string memory) {
    string memory ensName = lookupENSName(_owner);
    WatchConfiguration memory configuration = parseTokenId(_tokenId);
    string memory raw = renderSVG(
      configuration,
      _owner,
      ensName,
      _timestamp,
      _holdingProgress,
      _engraving
    );

    return
      string.concat(
        "data:application/json;base64,",
        Base64.encode(
          bytes(
            Metadata.getWatchfaceJSON(
              configuration.bezelId,
              configuration.faceId,
              configuration.moodId,
              configuration.glassesId,
              _holdingProgress,
              _engraving,
              // image data
              Base64.encode(bytes(raw))
            )
          )
        )
      );
  }

  function parseTokenId(uint256 _tokenId)
    internal
    pure
    returns (WatchConfiguration memory configuration)
  {
    require(_tokenId / 100000000 == 0, "Token id too large");

    configuration.bezelId = uint8((_tokenId / BEZEL_PART_BASE) % 100);
    configuration.faceId = uint8((_tokenId / FACE_PART_BASE) % 100);
    configuration.moodId = uint8((_tokenId / MOOD_PART_BASE) % 100);
    configuration.glassesId = uint8((_tokenId / GLASSES_PART_BASE) % 100);
  }

  function renderSVG(
    WatchConfiguration memory _config,
    address _owner,
    string memory _ensName,
    uint256 _timestamp,
    uint256 _holdingProgress,
    string memory _engraving
  ) public pure returns (string memory) {
    require(
      utils.utfStringLength(_engraving) <= 20,
      "Engraving must be less than or equal to 20 chars"
    );
    Date memory ts = DateTime.timestampToDateTime(_timestamp);

    bool isGlowInTheDark = _config.moodId == WatchData.GLOW_IN_THE_DARK_ID &&
      _config.glassesId == WatchData.GLOW_IN_THE_DARK_ID;
    bool lightFace = WatchData.MaterialId(_config.faceId) ==
      WatchData.MaterialId.Pearl;

    return
      string.concat(
        // primary container
        '<svg xmlns="http://www.w3.org/2000/svg" width="384" height="384" style="background:#000">',
        // embed the primary SVG inside to simulate padding
        '<svg width="360" height="360" x="12" y="12">',
        /*
        render each component stacked on top of each other.
        1. Bezel
        2. Face (includes engraving and date)
        3. Mood
        4. Glasses
        5. Hands
        6. Overlays for color
        */
        string.concat(
          Bezel.render(_owner, _ensName, _holdingProgress),
          Face.render(ts.day, ts.month, ts.year, _engraving, lightFace),
          // render custom mood for GITD.
          isGlowInTheDark
            ? GlowInTheDark.renderMood()
            : Mood.render(_config.moodId),
          // render custom glasses for GITD.
          isGlowInTheDark
            ? GlowInTheDark.renderGlasses()
            : Glasses.render(_config.glassesId),
          Hands.render(ts.second, ts.minute, ts.hour),
          // GITD has no diamond overlay
          // TODO: check if you need to see GITD status before this
          renderDiamondOverlay(_config)
        ),
        "</svg>",
        // global styles and defs
        generateDefs(),
        generateCssVars(
          _config.bezelId,
          _config.faceId,
          // pass in whether it's glow in the dark to
          // generate appropriate light / dark mode tokens.
          isGlowInTheDark
        ),
        "</svg>"
      );
  }

  function renderDiamondOverlay(WatchConfiguration memory _config)
    internal
    pure
    returns (string memory)
  {
    bool hasDiamondBezel = WatchData.MaterialId(_config.bezelId) ==
      WatchData.MaterialId.Diamond;
    bool hasDiamondFace = WatchData.MaterialId(_config.faceId) ==
      WatchData.MaterialId.Diamond;
    bool hasPearl = WatchData.MaterialId(_config.bezelId) ==
      WatchData.MaterialId.Pearl ||
      WatchData.MaterialId(_config.faceId) == WatchData.MaterialId.Pearl;

    if (hasDiamondBezel && hasDiamondFace) {
      return DiamondOverlay(WatchData.OUTER_BEZEL_RADIUS, "1.0");
    } else if (hasDiamondBezel || hasDiamondFace) {
      return DiamondOverlay(WatchData.OUTER_BEZEL_RADIUS, "0.75");
    } else if (hasPearl) {
      return DiamondOverlay(WatchData.OUTER_BEZEL_RADIUS, "0.5");
    }

    return utils.NULL;
  }

  function DiamondOverlay(uint256 _radius, string memory _opacity)
    internal
    pure
    returns (string memory)
  {
    return
      svg.circle(
        string.concat(
          svg.prop("r", utils.uint2str(_radius)),
          svg.prop("cx", utils.uint2str(WatchData.CENTER)),
          svg.prop("cy", utils.uint2str(WatchData.CENTER)),
          svg.prop("fill", utils.getDefURL("diamondOverlay")),
          svg.prop("filter", utils.getDefURL("blur")),
          svg.prop(
            "style",
            string.concat("mix-blend-mode:overlay;opacity:", _opacity, ";")
          )
        ),
        utils.NULL
      );
  }

  function generateDefs() internal pure returns (string memory) {
    return (
      string.concat("<defs>", generateGradients(), generateFilters(), "</defs>")
    );
  }

  function generateGradients() internal pure returns (string memory) {
    string memory commonGradientProps = string.concat(
      svg.prop("cx", "0"),
      svg.prop("cy", "0"),
      svg.prop("r", utils.uint2str(WatchData.WATCH_SIZE)),
      svg.prop("gradientUnits", "userSpaceOnUse")
    );

    return
      string.concat(
        // Outer bezel gradient
        svg.radialGradient(
          string.concat(
            svg.prop("id", "obg"),
            commonGradientProps,
            svg.prop("gradientTransform", "scale(1)")
          ),
          string.concat(
            svg.gradientStop(0, utils.getCssVar("bp"), utils.NULL),
            svg.gradientStop(100, utils.getCssVar("bs"), utils.NULL)
          )
        ),
        // Inner bezel gradient
        svg.radialGradient(
          string.concat(
            svg.prop("id", "ibg"),
            commonGradientProps,
            svg.prop("gradientTransform", "scale(1.5) rotate(30 180 180)")
          ),
          string.concat(
            svg.gradientStop(0, utils.getCssVar("bp"), utils.NULL),
            svg.gradientStop(100, utils.getCssVar("bs"), utils.NULL)
          )
        ),
        // Face gradient
        svg.radialGradient(
          string.concat(svg.prop("id", "fg"), commonGradientProps),
          string.concat(
            svg.gradientStop(0, utils.getCssVar("fp"), utils.NULL),
            svg.gradientStop(100, utils.getCssVar("fs"), utils.NULL)
          )
        ),
        // Reflection gradient
        svg.linearGradient(
          string.concat(svg.prop("id", "rg"), commonGradientProps),
          string.concat(
            svg.gradientStop(
              0,
              utils.getCssVar("bs"),
              svg.prop("stop-opacity", "0%")
            ),
            svg.gradientStop(
              50,
              utils.getCssVar("ba"),
              svg.prop("stop-opacity", "60%")
            ),
            svg.gradientStop(
              100,
              utils.getCssVar("bs"),
              svg.prop("stop-opacity", "0%")
            )
          )
        ),
        // Gradient for monolens gradient
        svg.linearGradient(
          string.concat(
            svg.prop("id", "ml"),
            svg.prop("x1", "87"),
            svg.prop("y1", "137"),
            svg.prop("x2", "273"),
            svg.prop("y2", "137"),
            svg.prop("gradientUnits", "userSpaceOnUse")
          ),
          string.concat(
            svg.gradientStop(0, "#6DF7A5", utils.NULL),
            svg.gradientStop(50, "#5400BF", utils.NULL),
            svg.gradientStop(100, "#6DEFF7", utils.NULL)
          )
        ),
        // // Shadow gradient
        svg.radialGradient(
          string.concat(
            svg.prop("id", "sg"),
            // center/2
            svg.prop("cx", "90"),
            // center/2
            svg.prop("cy", "90"),
            svg.prop("r", utils.uint2str(WatchData.WATCH_SIZE)),
            svg.prop("gradientUnits", "userSpaceOnUse")
          ),
          string.concat(
            svg.gradientStop(
              0,
              utils.getCssVar("black"),
              svg.prop("stop-opacity", "0%")
            ),
            svg.gradientStop(
              50,
              utils.getCssVar("black"),
              svg.prop("stop-opacity", "5%")
            ),
            svg.gradientStop(
              100,
              utils.getCssVar("black"),
              svg.prop("stop-opacity", "50%")
            )
          )
        ),
        // Diamond overlay
        generateDiamondGradient()
      );
  }

  function generateDiamondGradient() internal pure returns (string memory) {
    string[7] memory overlayGradient = WatchData.getDiamondOverlayGradient();

    return
      svg.linearGradient(
        string.concat(
          svg.prop("id", "diamondOverlay"),
          svg.prop("cx", "0"),
          svg.prop("cy", "0"),
          svg.prop("r", "180"),
          svg.prop("gradientUnits", "userSpaceOnUse")
        ),
        string.concat(
          svg.gradientStop(0, overlayGradient[0], utils.NULL),
          svg.gradientStop(14, overlayGradient[1], utils.NULL),
          svg.gradientStop(28, overlayGradient[2], utils.NULL),
          svg.gradientStop(42, overlayGradient[3], utils.NULL),
          svg.gradientStop(57, overlayGradient[4], utils.NULL),
          svg.gradientStop(71, overlayGradient[5], utils.NULL),
          svg.gradientStop(85, overlayGradient[6], utils.NULL)
        )
      );
  }

  function generateFilters() internal pure returns (string memory) {
    string memory filterUnits = svg.prop("filterUnits", "userSpaceOnUse");
    return
      string.concat(
        // FILTERS
        // Inset shadow
        svg.filter(
          string.concat(svg.prop("id", "insetShadow"), filterUnits),
          string.concat(
            svg.el(
              "feColorMatrix",
              string.concat(
                svg.prop("in", "SourceGraphic"),
                svg.prop("type", "matrix"),
                // that second to last value is the opacity of the matrix.
                svg.prop("values", "0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.7 0"),
                svg.prop("result", "opaque-source")
              ),
              utils.NULL
            ),
            svg.el(
              "feOffset",
              string.concat(
                svg.prop("in", "SourceGraphic"),
                svg.prop("dx", "2"),
                svg.prop("dy", "0")
              ),
              utils.NULL
            ),
            svg.el("feGaussianBlur", svg.prop("stdDeviation", "6"), utils.NULL),
            svg.el(
              "feComposite",
              string.concat(
                svg.prop("operator", "xor"),
                svg.prop("in2", "opaque-source")
              ),
              utils.NULL
            ),
            svg.el(
              "feComposite",
              string.concat(
                svg.prop("operator", "in"),
                svg.prop("in2", "opaque-source")
              ),
              utils.NULL
            ),
            svg.el(
              "feComposite",
              string.concat(
                svg.prop("operator", "over"),
                svg.prop("in2", "SourceGraphic")
              ),
              utils.NULL
            )
          )
        ),
        // Drop shadow
        svg.filter(
          string.concat(svg.prop("id", "dropShadow"), filterUnits),
          svg.el(
            "feDropShadow",
            string.concat(
              svg.prop("dx", "0"),
              svg.prop("dy", "0"),
              svg.prop("stdDeviation", "8"),
              svg.prop("floodOpacity", "0.5")
            ),
            utils.NULL
          )
        ),
        // Blur
        svg.filter(
          svg.prop("id", "blur"),
          svg.el(
            "feGaussianBlur",
            string.concat(
              svg.prop("in", "SourceGraphic"),
              svg.prop("stdDeviation", "8")
            ),
            utils.NULL
          )
        )
      );
  }

  function generateCssVars(
    uint256 _bezelId,
    uint256 _faceId,
    bool _isGlowInTheDark
  ) internal pure returns (string memory) {
    // given an ID, generate the proper variables
    // query the mapping
    WatchData.Material memory bezelMaterial = WatchData.getMaterial(_bezelId);
    WatchData.Material memory faceMaterial = WatchData.getMaterial(_faceId);

    return
      string.concat(
        "<style>",
        _isGlowInTheDark
          ? (GlowInTheDark.generateMaterialTokens())
          : (
            string.concat(
              "*{",
              generateMaterialTokens(bezelMaterial, faceMaterial),
              "}"
            )
          ),
        // constant for both glow in the dark and regular colors.
        "*{",
        generateTypographyTokens(),
        generateConstantTokens(),
        "}",
        // Used for full progress watches.
        "@keyframes fadeOpacity{0%{opacity:1;} 50%{opacity:0;} 100%{opacity:1;}}",
        "</style>"
      );
  }

  function generateMaterialTokens(
    WatchData.Material memory _bezelMaterial,
    WatchData.Material memory _faceMaterial
  ) internal pure returns (string memory) {
    return
      string.concat(
        // BEZEL COLORS
        // bezel primary (bp)
        utils.setCssVar("bp", _bezelMaterial.vals[0]),
        // bezel secondary (bs)
        utils.setCssVar("bs", _bezelMaterial.vals[1]),
        // bezel accent (ba)
        utils.setCssVar(
          "ba",
          WatchData.getMaterialAccentColor(_bezelMaterial.id)
        ),
        // FACE COLORS
        // face primary (fp)
        utils.setCssVar("fp", _faceMaterial.vals[0]),
        // face secondary (fs)
        utils.setCssVar("fs", _faceMaterial.vals[1]),
        // face accent (fa)
        utils.setCssVar(
          "fa",
          WatchData.getMaterialAccentColor(_faceMaterial.id)
        )
      );
  }

  function generateTypographyTokens() internal pure returns (string memory) {
    return
      string.concat(
        // // typography
        // // bezel type size
        // the type size is 11.65px so that on average the space between characters around the bezel is an integer (7 px).
        // this helps with the rendering code inside of Bezel.sol because we need to calcualte the exact spacing dynamically
        // and can't use decimals easily.
        utils.setCssVar("bts", "11.65px"),
        // // face type size
        utils.setCssVar("fts", "12px"),
        // // text shadow
        utils.setCssVar("textShadow", "1px 0 6px rgba(0,0,0,0.8)")
      );
  }

  function generateConstantTokens() internal pure returns (string memory) {
    return
      string.concat(
        // constant colors
        utils.setCssVar("white", "#fff"),
        utils.setCssVar("black", "#000"),
        utils.setCssVar("clear", "transparent"),
        // More constants
        "font-family: monospace;",
        "font-weight: 500;",
        // Allows the glow to escape from the container
        "overflow: visible;"
      );
  }

  function lookupENSName(address _address)
    internal
    view
    returns (string memory)
  {
    address NEW_ENS_MAINNET = 0x084b1c3C81545d370f3634392De611CaaBFf8148;
    address OLD_ENS_MAINNET = 0x9062C0A6Dbd6108336BcBe4593a3D1cE05512069;
    address ENS_RINKEBY = 0x6F628b68b30Dc3c17f345c9dbBb1E483c2b7aE5c;

    string memory ens = tryLookupENSName(NEW_ENS_MAINNET, _address);

    if (bytes(ens).length == 0) {
      ens = tryLookupENSName(OLD_ENS_MAINNET, _address);
    }
    if (bytes(ens).length == 0) {
      ens = tryLookupENSName(ENS_RINKEBY, _address);
    }

    return ens;
  }

  function tryLookupENSName(address _registrar, address _address)
    internal
    view
    returns (string memory)
  {
    uint32 size;
    assembly {
      size := extcodesize(_registrar)
    }
    if (size == 0) {
      return "";
    }
    IReverseRegistrar ensReverseRegistrar = IReverseRegistrar(_registrar);
    bytes32 node = ensReverseRegistrar.node(_address);
    return ensReverseRegistrar.defaultResolver().name(node);
  }
}
