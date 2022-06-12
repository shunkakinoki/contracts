// SPDX-License-Identifier: MIT

pragma solidity ^0.8.13;

import "@openzeppelin/contracts-upgradeable/utils/ContextUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/security/PausableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";

interface IControllerV4 {
  function admin() external view returns (address);
}

contract ControllerV4 is
  IControllerV4,
  Initializable,
  ContextUpgradeable,
  PausableUpgradeable
{
  // IMPORTANT!: For future reference, when adding new variables for following versions of the controller.
  // All the previous ones should be kept in place and not change locations, types or names.
  // If thye're modified this would cause issues with the memory slots.

  address public pauseAdmin;
  address public override admin;
  address public recoveryAdmin;

  function getVersion() external pure returns (uint256) {
    return 4;
  }
}
