// SPDX-License-Identifier: The Unlicense

pragma solidity ^0.8.13;

import "./ICategories.sol";

interface IHardwareSVGs {
  struct HardwareData {
    string title;
    ICategories.HardwareCategories hardwareType;
    string svgString;
  }
}
