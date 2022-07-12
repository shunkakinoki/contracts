// SPDX-License-Identifier: MIT
// Code from: https://github.com/h00p30/8bitArray
pragma solidity ^0.8.13;

import { Test } from "forge-std/Test.sol";
import "@shunkakinoki/huff/HuffDeployer.sol";

interface I8bitArray {
  function testBitmask(uint8) external view returns (bytes32);

  function testNumberOffset(uint8, uint8) external view returns (bytes32);

  function testNumberWrite(uint8, uint8) external returns (bytes32);

  function testNumberRead(uint8) external returns (bytes32);
}

contract ArrayTest is Test {
  HuffDeployer huffDeployer = new HuffDeployer();
  I8bitArray huff;

  function setUp() public {
    huff = I8bitArray(huffDeployer.deploy("huff_contracts/Array"));
  }

  function testBitmask() external {
    bytes32 value = I8bitArray(huff).testBitmask(30);
    assertEq(
      value,
      0xff00ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
    );
    value = I8bitArray(huff).testBitmask(2);
    assertEq(
      value,
      0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffff00ffff
    );
  }

  function testOffset() external {
    bytes32 value = I8bitArray(huff).testNumberOffset(5, 3);
    assertEq(
      value,
      0x0000000000000000000000000000000000000000000000000000000005000000
    );
    value = I8bitArray(huff).testNumberOffset(9, 5);
    assertEq(
      value,
      0x0000000000000000000000000000000000000000000000000000090000000000
    );
  }

  function testWrite() external {
    I8bitArray(huff).testNumberWrite(10, 4);
    I8bitArray(huff).testNumberWrite(5, 2);
    bytes32 value = I8bitArray(huff).testNumberRead(4);
    assertEq(
      value,
      0x000000000000000000000000000000000000000000000000000000000000000a
    );
    value = I8bitArray(huff).testNumberRead(2);
    assertEq(
      value,
      0x0000000000000000000000000000000000000000000000000000000000000005
    );
    value = I8bitArray(huff).testNumberRead(4);
    assertEq(
      value,
      0x000000000000000000000000000000000000000000000000000000000000000a
    );
  }

  function testOverWrite() external {
    I8bitArray(huff).testNumberWrite(10, 4);
    bytes32 value = I8bitArray(huff).testNumberRead(4);
    assertEq(
      value,
      0x000000000000000000000000000000000000000000000000000000000000000a
    );
    I8bitArray(huff).testNumberWrite(5, 4);
    value = I8bitArray(huff).testNumberRead(4);
    assertEq(
      value,
      0x0000000000000000000000000000000000000000000000000000000000000005
    );
  }
}
