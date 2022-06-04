// SPDX-License-Identifier: MIT
// Code from: https://docs.soliditylang.org/en/latest/types.html#conversions-between-elementary-types

pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import { BitsAndBytes } from "../BitsAndBytes.sol";

contract BitsAndBytesTest is Test {
  BitsAndBytes bab;

  function setUp() public {
    bab = new BitsAndBytes();
  }

  function testNumberIs42() public {
    assertEq(bab.implicitConversion(1, 2), 3);
  }

  function testExplicitConversion() public {
    assertEq(
      bab.explicitConversion(-3),
      0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD
    );
  }

  function testCutOff() public {
    // b will be 0x5678 now
    assertEq(bab.cutOff(0x12345678), 0x5678);
    assertEq(bab.cutOff(0xFFFFFFFF), 0xFFFF);
  }
}
