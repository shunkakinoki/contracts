// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.13;
import "./WatchData.sol";

// Convenience functions for formatting all the metadata related to a particular NFT
library Metadata {
  function getWatchfaceJSON(
    uint8 _bezelId,
    uint8 _faceId,
    uint8 _moodId,
    uint8 _glassesId,
    uint256 _holdingProgress,
    string calldata _engraving,
    string memory _imageData
  ) public pure returns (string memory) {
    string memory attributes = renderAttributes(
      _bezelId,
      _faceId,
      _moodId,
      _glassesId,
      _holdingProgress,
      _engraving
    );
    return
      string.concat(
        '{"name": "',
        renderName(_bezelId, _faceId, _moodId, _glassesId, _engraving),
        '", "background_color": "000000", "image": "data:image/svg+xml;base64,',
        _imageData,
        '","attributes":[',
        attributes,
        "]}"
      );
  }

  function renderName(
    uint8 _bezelId,
    uint8 _faceId,
    uint8 _moodId,
    uint8 _glassesId,
    string calldata engraving
  ) public pure returns (string memory) {
    if (_moodId == WatchData.GLOW_IN_THE_DARK_ID) {
      return '\\"Glow In The Dark\\" Watchface 1/1';
    }

    string memory prefix = "";
    if (bytes(engraving).length > 0) {
      prefix = string.concat('\\"', engraving, '\\" ');
    }
    return
      string.concat(
        prefix,
        "Watchface ",
        utils.uint2str(_bezelId),
        "-",
        utils.uint2str(_faceId),
        "-",
        utils.uint2str(_moodId),
        "-",
        utils.uint2str(_glassesId)
      );
  }

  function renderAttributes(
    uint8 _bezelId,
    uint8 _faceId,
    uint8 _moodId,
    uint8 _glassesId,
    uint256 _holdingProgress,
    string calldata engraving
  ) public pure returns (string memory) {
    if (_moodId == WatchData.GLOW_IN_THE_DARK_ID) {
      return
        string.concat(
          attributeBool("Glow In The Dark", true),
          ",",
          attributeBool("Cared-for", _holdingProgress >= 1000)
        );
    }

    string memory engravingAttribute = "";
    if (bytes(engraving).length > 0) {
      engravingAttribute = string.concat(
        attributeString("Engraving", engraving),
        ","
      );
    }
    return
      string.concat(
        engravingAttribute,
        attributeString("Bezel", WatchData.getMaterial(_bezelId).name),
        ",",
        attributeString("Face", WatchData.getMaterial(_faceId).name),
        ",",
        attributeString("Mood", WatchData.getMood(_moodId).name),
        ",",
        attributeString("Glasses", WatchData.getGlasses(_glassesId).name),
        ",",
        attributeBool("Cared-for", _holdingProgress >= 1000)
      );
  }

  function attributeString(string memory _name, string memory _value)
    public
    pure
    returns (string memory)
  {
    return
      string.concat(
        "{",
        kv("trait_type", string.concat('"', _name, '"')),
        ",",
        kv("value", string.concat('"', _value, '"')),
        "}"
      );
  }

  function attributeBool(string memory _name, bool _value)
    public
    pure
    returns (string memory)
  {
    return attributeString(_name, _value ? "Yes" : "No");
  }

  function kv(string memory _key, string memory _value)
    public
    pure
    returns (string memory)
  {
    return string.concat('"', _key, '"', ":", _value);
  }
}
