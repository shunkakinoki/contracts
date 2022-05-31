// SPDX-License-Identifier: The Unlicense

pragma solidity ^0.8.13;

import "./ICategories.sol";

interface IFieldSVGs {
  struct FieldData {
    string title;
    ICategories.FieldCategories fieldType;
    string svgString;
  }
}
