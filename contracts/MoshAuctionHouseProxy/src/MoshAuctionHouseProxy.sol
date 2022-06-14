// SPDX-License-Identifier: MIT

pragma solidity ^0.8.13;

import { TransparentUpgradeableProxy } from "@openzeppelin/contracts/proxy/transparent/TransparentUpgradeableProxy.sol";

contract MoshAuctionHouseProxy is TransparentUpgradeableProxy {
  constructor(
    address logic,
    address admin,
    bytes memory data
  ) TransparentUpgradeableProxy(logic, admin, data) {}
}
