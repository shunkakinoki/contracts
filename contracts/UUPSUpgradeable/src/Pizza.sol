// SPDX-License-Identifier: MIT
// Code from: https://github.com/fracton-ventures/foundry-UUPS-proxy-pattern
pragma solidity ^0.8.13;

import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";

contract Pizza is Initializable, UUPSUpgradeable, OwnableUpgradeable {
  uint256 public slices;

  ///@dev no constructor in upgradable contracts. Instead we have initializers
  ///@param _sliceCount initial number of slices for the pizza
  function initialize(uint256 _sliceCount) public initializer {
    slices = _sliceCount;

    ///@dev as there is no constructor, we need to initialise the OwnableUpgradeable explicitly
    __Ownable_init();
  }

  ///@dev required by the OZ UUPS module
  function _authorizeUpgrade(address) internal override onlyOwner {}

  ///@dev decrements the slices when called
  function eatSlice() public {
    require(slices > 1, "no slices left");
    slices -= 1;
  }
}
