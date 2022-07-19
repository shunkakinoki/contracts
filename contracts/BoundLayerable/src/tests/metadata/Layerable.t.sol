// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.4;

import { Test } from "forge-std/Test.sol";
import { ImageLayerable } from "../../metadata/ImageLayerable.sol";
import { Attribute } from "../../interface/Structs.sol";
import { DisplayType, LayerType } from "../../interface/Enums.sol";
import { PackedByteUtility } from "../../lib/PackedByteUtility.sol";
import { BitMapUtility } from "../../lib/BitMapUtility.sol";
import { StringTestUtility } from "../helpers/StringTestUtility.sol";
import { Strings } from "openzeppelin-contracts/utils/Strings.sol";

contract LayerableImpl is ImageLayerable {
  uint256 bindings;
  uint256[] activeLayers;
  bytes32 packedBatchRandomness;

  constructor() ImageLayerable("default", msg.sender) {}

  function setBindings(uint256 _bindings) public {
    bindings = _bindings;
  }

  function setActiveLayers(uint256[] memory _activeLayers) public {
    activeLayers = _activeLayers;
  }

  function setPackedBatchRandomness(bytes32 _packedBatchRandomness) public {
    packedBatchRandomness = _packedBatchRandomness;
  }

  function tokenURI(uint256 layerId)
    public
    view
    virtual
    returns (string memory)
  {
    return
      this.getTokenURI(layerId, bindings, activeLayers, packedBatchRandomness);
  }
}

contract LayerableTest is Test {
  using BitMapUtility for uint256;
  using StringTestUtility for string;
  using Strings for uint256;
  using Strings for uint8;

  LayerableImpl test;

  function setUp() public {
    test = new LayerableImpl();
    test.setBaseLayerURI("layer/"); // test.setLayerTypeDistribution(LayerType.PORTRAIT, 0xFF << 248);
  }

  function testGetActiveLayerTraits(uint8[2] memory activeLayers) public {
    uint256[] memory activeLayersCopy = new uint256[](2);
    for (uint8 i = 0; i < activeLayers.length; i++) {
      activeLayersCopy[i] = activeLayers[i];
    }
    for (uint256 i = 0; i < activeLayers.length; i++) {
      test.setAttribute(
        activeLayers[i],
        Attribute(
          activeLayers[i].toString(),
          activeLayers[i].toString(),
          DisplayType.String
        )
      );
    }

    string memory actual = test.getActiveLayerTraits(activeLayersCopy);

    emit log_string(actual);
    for (uint256 i = 0; i < activeLayers.length; i++) {
      assertTrue(
        actual.contains(
          string.concat(
            '{"trait_type":"Active ',
            activeLayers[i].toString(),
            '","value":"',
            activeLayers[i].toString(),
            '"}'
          )
        )
      );
    }
  }

  function testBoundLayerTraits(uint8[2] memory boundLayers) public {
    uint256 bindings;
    for (uint256 i = 0; i < boundLayers.length; i++) {
      bindings |= 1 << boundLayers[i];
      test.setAttribute(
        boundLayers[i],
        Attribute(
          boundLayers[i].toString(),
          boundLayers[i].toString(),
          DisplayType.String
        )
      );
    }

    string memory actual = test.getBoundLayerTraits(bindings);

    emit log_string(actual);
    for (uint256 i = 0; i < boundLayers.length; i++) {
      assertTrue(
        actual.contains(
          string.concat(
            '{"trait_type":"',
            boundLayers[i].toString(),
            '","value":"',
            boundLayers[i].toString(),
            '"}'
          )
        )
      );
    }
  }

  // function testGetTokenUri(
  //     uint256 bindings,
  //     uint32 seed,
  //     uint256 numActive,
  //     uint256 layerId
  // ) public {
  //     bindings &= ~uint256(0);
  //     uint256[] memory boundLayers = BitMapUtility.unpackBitMap(bindings); //.unpackBitMap();
  //     numActive = bound(numActive, 0, boundLayers.length);
  //     uint256[] memory activeLayers = new uint256[](numActive);
  //     for (uint256 i = 0; i < numActive; i++) {
  //         activeLayers[i] = boundLayers[i];
  //     }
  //     bytes32 layerSeed = bytes32(uint256(seed));
  //     test.setPackedBatchRandomness(layerSeed);

  //     string memory actual = test.getTokenURI(
  //         layerId,
  //         bindings,
  //         activeLayers,
  //         layerSeed
  //     );
  //     assertTrue(
  //         actual.startsWith(
  //             '{"image":"<svg xmlns="http://www.w3.org/2000/svg">'
  //         )
  //     );
  // }
}