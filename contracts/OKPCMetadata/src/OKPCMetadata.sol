//SPDX-License-Identifier: Unlicense

pragma solidity ^0.8.13;

/*
  ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
  ░░░░░█████░░░░░░░░█████░░░░░░░███░░░░░█████░░░░░██░░░░░░░░█████░░░░░░░█████░░░░░
  ░░░██░░░░░███░░███░░░░░██░░░██░░░░░███░░░░░██░░░░░███░░███░░░░░██░░░██░░░░░███░░
  ░░░░░███░░░░░██░░░░░███░░░░░░░█████░░░░░░░░░░█████░░░░░░░░██░░░░░███░░░░░██░░░░░
  ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
  ████████████████████████████████████████████████████████████████████████████████
  ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
  ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
  ░░░██░░░░░                                                            ░░░░░███░░
  ░░░░░███░░                                                            ░░░██░░░░░
  ░░░█████░░          ██████████                    ██████████          ░░░░░███░░
  ░░░░░░░░░░        ██          ███               ██          ███       ░░░░░░░░░░
  ░░░░░███░░     ███       █████   ██          ███       █████   ██     ░░░██░░░░░
  ░░░██░░░░░     ███          ██   ██   █████  ███          ██   ██     ░░░░░███░░
  ░░░█████░░     ███       █████   ██          ███       █████   ██     ░░░██░░░░░
  ░░░░░░░░░░     ███       █████   ██   █████  ███       █████   ██     ░░░░░░░░░░
  ░░░█████░░     ███               ██          ███               ██     ░░░░░███░░
  ░░░██░░░░░        ███████████████     █████     ███████████████       ░░░██░░░░░
  ░░░░░███░░                                                            ░░░░░███░░
  ░░░░░░░░░░     █████                                        █████     ░░░░░░░░░░
  ░░░█████░░     █████   █████  █████   █████  █████   █████  █████     ░░░██░░░░░
  ░░░░░███░░             █████  █████   █████     ██   █████            ░░░░░███░░
  ░░░██░░░░░                                                            ░░░██░░░░░
  ░░░░░░░░░░                                                            ░░░░░░░░░░
  ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
  ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
  ████████████████████████████████████████████████████████████████████████████████
  ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
  ░░░░░█████░░░░░████████░░███░░███░░░░░░░░░░░░░░░██░░░██░░░██░░░██░░░██░░░██░░░░░
  ░░░░░███░░███░░█████░░░░░░░░██░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
  ░░░░░████████░░███░░░░░░░███░░███░░░░░░░░░░░░░░░██░░░██░░░██░░░██░░░██░░░██░░░░░
  ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
*/

import { Base64 } from "./lib/Base64.sol";
import { Ownable } from "@openzeppelin/contracts/access/Ownable.sol";
import "@divergencetech/ethier/contracts/utils/DynamicBuffer.sol";
import { IOKPC } from "./interfaces/IOKPC.sol";
import { OKPCParts } from "./OKPCParts.sol";
import { IOKPCFont } from "./interfaces/IOKPCFont.sol";
import { IOKPCMetadata } from "./interfaces/IOKPCMetadata.sol";
import { IOKPCGenesisArtwork } from "./interfaces/IOKPCGenesisArtwork.sol";
import { ENSNameResolver } from "./lib/ENSNameResolver.sol";

contract OKPCMetadata is IOKPCMetadata, Ownable, ENSNameResolver {
  /* --------------------------------- ****** --------------------------------- */

  /* -------------------------------------------------------------------------- */
  /*                                   CONFIG                                   */
  /* -------------------------------------------------------------------------- */
  using DynamicBuffer for bytes;
  string public FALLBACK_URL = "https://okpc.app/api/okpc/";
  string public DESCRIPTION_URL = "https://okpc.app/gallery/";

  /* --------------------------------- ****** --------------------------------- */

  /* -------------------------------------------------------------------------- */
  /*                                   STORAGE                                  */
  /* -------------------------------------------------------------------------- */
  IOKPC private _okpc;
  OKPCParts private _parts;
  IOKPCFont private _font;
  IOKPCGenesisArtwork private _genesisArtwork;

  /* --------------------------------- ****** --------------------------------- */

  /* -------------------------------------------------------------------------- */
  /*                               INITIALIZATION                               */
  /* -------------------------------------------------------------------------- */
  constructor(
    address okpcAddress,
    address partsAddress,
    address fontAddress,
    address genesisArtworkAddress
  ) {
    _okpc = IOKPC(okpcAddress);
    _parts = OKPCParts(partsAddress);
    _font = IOKPCFont(fontAddress);
    _genesisArtwork = IOKPCGenesisArtwork(genesisArtworkAddress);
  }

  /* --------------------------------- ****** --------------------------------- */

  /* -------------------------------------------------------------------------- */
  /*                                    ADMIN                                   */
  /* -------------------------------------------------------------------------- */
  /// @notice Allows the owner to update the Parts address.
  /// @param partsAddress The new Parts contract to use for the renderer. Must conform to IOKPCParts.
  function setParts(address partsAddress) public onlyOwner {
    _parts = OKPCParts(partsAddress);
  }

  /// @notice Allows the owner to update the Fonts address.
  /// @param fontAddress The new Fonts address to use for the renderer. Must conform to IOKPCFont.
  function setFont(address fontAddress) public onlyOwner {
    _font = IOKPCFont(fontAddress);
  }

  /// @notice Allows the owner to update the Genesis Artwork address.
  /// @param genesisArtworkAddress The new Genesis Artwork address to use for the renderer. Must conform to IOKPCGenesisArtwork.
  function setGenesisArtworkAddress(address genesisArtworkAddress)
    public
    onlyOwner
  {
    _genesisArtwork = IOKPCGenesisArtwork(genesisArtworkAddress);
  }

  /// @notice Allows the owner to update the fallback / off-chain metadata address.
  /// @param url The new off-chain metadata url base to use. The tokenId will be appended to this url.
  function setFallbackURL(string memory url) public onlyOwner {
    FALLBACK_URL = url;
  }

  /// @notice Allows the owner to update the description url.
  /// @param url The url base to the use for the artist links in the token description. The full address will be appended to this url.
  function setDescriptionURL(string memory url) public onlyOwner {
    DESCRIPTION_URL = url;
  }

  /// @notice Gets the TokenURI for a specified OKPC given params
  /// @param tokenId The tokenId of the OKPC
  function tokenURI(uint256 tokenId)
    public
    view
    override
    returns (string memory)
  {
    if (tokenId < 1 || tokenId > 8192) revert InvalidTokenID();

    return
      string(
        abi.encodePacked(
          "data:application/json;base64,",
          _getMetadataJSON(tokenId)
        )
      );
  }

  function _getMetadataJSON(uint256 tokenId)
    internal
    view
    returns (string memory)
  {
    Parts memory parts = getParts(tokenId);
    uint256 artId = _okpc.activeArtForOKPC(tokenId);
    uint256 clockSpeed = _okpc.clockSpeed(tokenId);
    uint256 artCollected = _okpc.artCountForOKPC(tokenId);
    bool useOffChainRenderer = _okpc.useOffchainMetadata(tokenId);

    bool isCustomArt = artId == 0;
    IOKPC.Art memory art = isCustomArt
      ? _okpc.getPaintArt(tokenId)
      : _okpc.getGalleryArt(artId);

    bytes memory artData = abi.encodePacked(art.data1, art.data2);
    if (artData.length < 56) revert NotEnoughPixelData();

    (, IOKPC.Art memory shippedWithArt) = _genesisArtwork.getGenesisArtwork(
      tokenId
    );

    return
      Base64.encode(
        abi.encodePacked(
          _getMetadataHeader(tokenId, parts, art),
          useOffChainRenderer
            ? abi.encodePacked(FALLBACK_URL, toString(tokenId), "/img")
            : abi.encodePacked(
              "data:image/svg+xml;base64,",
              drawOKPC(clockSpeed, artData, parts)
            ),
          '", "attributes": ',
          _getAttributes(
            parts,
            clockSpeed,
            artCollected,
            art,
            shippedWithArt,
            useOffChainRenderer,
            isCustomArt
          ),
          "}"
        )
      );
  }

  /// @notice Returns the SVG of the specified art in the specified color
  /// @param art The byte data for the artwork to render
  /// @param colorIndex The color to use for the art. Accepts values between 0 and 5;
  function renderArt(bytes memory art, uint256 colorIndex)
    public
    view
    returns (string memory)
  {
    // get svg
    OKPCParts.Color memory color = _parts.getColor(colorIndex);

    return
      string(
        abi.encodePacked(
          '<svg viewBox="0 0 24 16" xmlns="http://www.w3.org/2000/svg" shape-rendering="crispEdges" height="512" width="512" fill="#',
          color.dark,
          '"><rect width="24" height="16" fill="#',
          color.light,
          '"/>',
          drawArt(art),
          "</svg>"
        )
      );
  }

  /// @notice Gets the proper parts for a given OKPC TokenID
  function getParts(uint256 tokenId)
    public
    view
    override
    returns (Parts memory)
  {
    if (tokenId < 1 || tokenId > 8192) revert InvalidTokenID();
    Parts memory parts;

    if (tokenId <= 128) {
      parts.color = _parts.getColor((tokenId - 1) % _parts.NUM_COLORS());
      parts.word = _parts.getWord(tokenId - 1);
    } else {
      parts.color = _parts.getColor(
        uint256(keccak256(abi.encodePacked("COLOR", tokenId))) %
          _parts.NUM_COLORS()
      );
      parts.word = _parts.getWord(
        uint256(keccak256(abi.encodePacked("WORD", tokenId))) %
          _parts.NUM_WORDS()
      );
    }

    parts.headband = _parts.getHeadband(
      uint256(keccak256(abi.encodePacked("HEADBAND", tokenId))) %
        _parts.NUM_HEADBANDS()
    );
    parts.rightSpeaker = _parts.getSpeaker(
      uint256(keccak256(abi.encodePacked("RIGHT SPEAKER", tokenId))) %
        _parts.NUM_SPEAKERS()
    );
    parts.leftSpeaker = _parts.getSpeaker(
      uint256(keccak256(abi.encodePacked("LEFT SPEAKER", tokenId))) %
        _parts.NUM_SPEAKERS()
    );

    return parts;
  }

  /// @notice Gets the SVG Base64 encoded for a specified OKPC
  /// @param tokenId The tokenId of the OKPC to draw
  function drawOKPC(uint256 tokenId) public view returns (string memory) {
    uint256 artId = _okpc.activeArtForOKPC(tokenId);
    uint256 clockSpeed = _okpc.clockSpeed(tokenId);
    bool isCustomArt = artId == 0;
    IOKPC.Art memory art = isCustomArt
      ? _okpc.getPaintArt(tokenId)
      : _okpc.getGalleryArt(artId);
    bytes memory artData = abi.encodePacked(art.data1, art.data2);

    if (artData.length < 56) revert NotEnoughPixelData();
    Parts memory parts = getParts(tokenId);

    return drawOKPC(clockSpeed, artData, parts);
  }

  /// @notice Renders the SVG for a given configuration.
  /// @param speed The clockspeed of the OKPC to draw
  /// @param art The artwork to draw on the OKPC's screen
  /// @param parts The parts of the OKPC (headband, speaker, etc)
  function drawOKPC(
    uint256 speed,
    bytes memory art,
    Parts memory parts
  ) public view returns (string memory) {
    bytes memory svg = abi.encodePacked(
      abi.encodePacked(
        '<svg viewBox="0 0 32 32" xmlns="http://www.w3.org/2000/svg" shape-rendering="crispEdges" fill="#',
        parts.color.dark,
        '" height="512" width="512"><rect width="32" height="32" fill="#',
        parts.color.regular,
        '"/><rect x="4" y="8" width="24" height="16" fill="#',
        parts.color.light,
        '"/><rect width="32" height="1" x="0" y="5" /><rect width="32" height="1" x="0" y="26" /><path transform="translate(1,1)" d="',
        parts.headband.data,
        '"/><path transform="translate(1, 8)" d="',
        parts.leftSpeaker.data,
        '"/><path transform="translate(31, 8) scale(-1,1)" d="',
        parts.rightSpeaker.data,
        '"/><g transform="translate(4, 8)" fill-rule="evenodd" clip-rule="evenodd">'
      ),
      drawArt(art),
      "</g>",
      _drawWord(parts.word),
      '<g transform="translate(19, 28)">',
      _drawClockSpeed(speed, parts),
      "</g></svg>"
    );

    return Base64.encode(svg);
  }

  /// @notice Returns the SVG rects for artData.
  /// @param artData The data to draw as bytes.
  function drawArt(bytes memory artData)
    public
    pure
    override
    returns (string memory)
  {
    bytes memory rects = DynamicBuffer.allocate(2**16); // Allocate 64KB of memory, we will not use this much, but it's safe.
    uint256 offset = 8;

    // render 8 pixels at a time
    for (uint256 pixelNum = 0; pixelNum < 384; pixelNum += 8) {
      uint8 workingByte = uint8(artData[offset + (pixelNum / 8)]);
      uint256 y = uint256(pixelNum / 24);
      uint256 x = uint256(pixelNum % 24);

      for (uint256 i; i < 8; i++) {
        // if the pixel is a 1, draw it
        if ((workingByte >> (7 - i)) & 1 == 1) {
          rects.appendSafe(
            abi.encodePacked(
              '<rect width="1" height="1" x="',
              toString(x + i),
              '" y="',
              toString(y),
              '"/>'
            )
          );
        }
      }
    }

    return string(rects);
  }

  /// @notice Renders the SVG path for an OKPC Word.
  function _drawWord(string memory word) internal view returns (bytes memory) {
    bytes memory wordBytes = bytes(word);
    bytes memory path;

    for (uint256 i; i < wordBytes.length; i++) {
      if (wordBytes[i] != 0x0) {
        path = abi.encodePacked(
          path,
          '<path clip-rule="evenodd" fill-rule="evenodd" transform="translate(',
          toString(2 + i * 4),
          ',28)" d="',
          _font.getChar(wordBytes[i]),
          '"/>'
        );
      } else {
        break;
      }
    }

    return path;
  }

  function _drawClockSpeed(uint256 speed, Parts memory parts)
    internal
    pure
    returns (bytes memory)
  {
    bytes memory clockSpeedPixels = DynamicBuffer.allocate(2**16); // Allocate 64KB of memory, we will not use this much, but it's safe.
    bytes6 color;

    for (uint256 i; i < 12; i++) {
      uint256 x = 10 - ((i / 2) * 2);
      uint256 y = (i % 2 == 0) ? 2 : 0;
      if (i < speed / 128) color = parts.color.light;
      else color = parts.color.dark;

      clockSpeedPixels.appendSafe(
        abi.encodePacked(
          '<rect width="1" height="1" x="',
          toString(x),
          '" y="',
          toString(y),
          '" fill="#',
          color,
          '"/>'
        )
      );
    }

    return clockSpeedPixels;
  }

  function _getMetadataHeader(
    uint256 tokenId,
    Parts memory parts,
    IOKPC.Art memory art
  ) internal view returns (bytes memory) {
    string memory artistENS = ENSNameResolver.getENSName(art.artist);
    return
      abi.encodePacked(
        '{"name": "OKPC #',
        toString(tokenId),
        '", "description": "A ',
        parts.color.name,
        " OKPC displaying '",
        bytes16ToString(art.title),
        "' by [",
        bytes(artistENS).length > 0
          ? artistENS
          : string(abi.encodePacked("0x", toAsciiString(art.artist))),
        "](",
        DESCRIPTION_URL,
        string(abi.encodePacked("0x", toAsciiString(art.artist))),
        ')", "image": "'
      );
  }

  function _getAttributes(
    Parts memory parts,
    uint256 speed,
    uint256 artCollected,
    IOKPC.Art memory art,
    IOKPC.Art memory shippedWithArt,
    bool isFallbackRenderer,
    bool isCustomArt
  ) internal view returns (bytes memory) {
    return
      abi.encodePacked(
        _getAttributeSet1(parts, speed, artCollected),
        _getAttributeSet2(art, shippedWithArt, isFallbackRenderer, isCustomArt)
      );
  }

  function _getAttributeSet1(
    Parts memory parts,
    uint256 speed,
    uint256 artCollected
  ) internal pure returns (bytes memory) {
    // if word is 200% change it to 200 Percent to avoid OpenSea bug
    string memory word = parts.word;
    if (keccak256(abi.encodePacked(word)) == keccak256("200%"))
      word = string(abi.encodePacked("200", "\xEF\xBC\x85"));

    return
      abi.encodePacked(
        '[{"trait_type":"Art Collected", "value": ',
        toString(artCollected),
        '}, {"trait_type":"Word", "value": "',
        word,
        '"}, {"trait_type": "Color", "value": "',
        parts.color.name,
        abi.encodePacked(
          '"}, {"trait_type": "Headband", "value": "',
          parts.headband.name,
          '"}, {"trait_type": "Right Speaker", "value": "',
          parts.rightSpeaker.name,
          '"}, {"trait_type": "Left Speaker", "value": "',
          parts.leftSpeaker.name,
          '"}, {"trait_type": "Clock Speed", "value": "',
          toString(speed)
        )
      );
  }

  function _getAttributeSet2(
    IOKPC.Art memory art,
    IOKPC.Art memory shippedWithArt,
    bool isFallbackRenderer,
    bool isCustomArt
  ) internal view returns (bytes memory) {
    string memory artistENS = ENSNameResolver.getENSName(art.artist);
    string memory shippedWithENS = ENSNameResolver.getENSName(
      shippedWithArt.artist
    );

    return
      abi.encodePacked(
        '"}, {"trait_type": "Art", "value": "',
        bytes16ToString(art.title),
        '"}, {"trait_type": "Renderer", "value": "',
        isFallbackRenderer ? "Off Chain" : "On Chain",
        '"}, {"trait_type": "Screen", "value": "',
        isCustomArt ? "Custom Art" : "Gallery Art",
        abi.encodePacked(
          '"}, {"trait_type": "Artist", "value": "',
          bytes(artistENS).length > 0
            ? artistENS
            : string(abi.encodePacked("0x", toAsciiString(art.artist))),
          '"}, {"trait_type": "Shipped With", "value": "',
          bytes16ToString(shippedWithArt.title),
          " by ",
          bytes(shippedWithENS).length > 0
            ? shippedWithENS
            : string(
              abi.encodePacked("0x", toAsciiString(shippedWithArt.artist))
            ),
          '"}]'
        )
      );
  }

  // * UTILITIES * //
  function toString(uint256 value) internal pure returns (string memory) {
    // Inspired by OraclizeAPI's implementation - MIT license
    // https://github.com/oraclize/ethereum-api/blob/b42146b063c7d6ee1358846c198246239e9360e8/oraclizeAPI_0.4.25.sol

    if (value == 0) {
      return "0";
    }
    uint256 temp = value;
    uint256 digits;
    while (temp != 0) {
      digits++;
      temp /= 10;
    }
    bytes memory buffer = new bytes(digits);
    while (value != 0) {
      digits -= 1;
      buffer[digits] = bytes1(uint8(48 + uint256(value % 10)));
      value /= 10;
    }
    return string(buffer);
  }

  function bytes16ToString(bytes16 x) internal pure returns (string memory) {
    uint256 numChars = 0;

    for (uint256 i; i < 16; i++) {
      if (x[i] == bytes1(0)) break;
      numChars++;
    }

    bytes memory result = new bytes(numChars);
    for (uint256 i; i < numChars; i++) result[i] = x[i];

    return string(result);
  }

  function toAsciiString(address x) internal pure returns (string memory) {
    bytes memory s = new bytes(40);
    for (uint256 i; i < 20; i++) {
      bytes1 b = bytes1(uint8(uint256(uint160(x)) / (2**(8 * (19 - i)))));
      bytes1 hi = bytes1(uint8(b) / 16);
      bytes1 lo = bytes1(uint8(b) - 16 * uint8(hi));
      s[2 * i] = char(hi);
      s[2 * i + 1] = char(lo);
    }
    return string(s);
  }

  function char(bytes1 b) internal pure returns (bytes1 c) {
    if (uint8(b) < 10) return bytes1(uint8(b) + 0x30);
    else return bytes1(uint8(b) + 0x57);
  }
}
