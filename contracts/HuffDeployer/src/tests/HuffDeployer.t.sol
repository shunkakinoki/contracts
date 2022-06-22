// SPDX-License-Identifier: MIT

pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../HuffDeployer.sol";

interface Number {
  function setNumber(uint256) external;

  function getNumber() external returns (uint256);
}

contract HuffDeployerTest is Test {
  Number number;
  HuffDeployer huffDeployer = new HuffDeployer();

  function setUp() public {
    number = Number(huffDeployer.deploy("huff_contracts/Number"));
  }

  function testNumber() public {
    number.setNumber(1);
    assertEq(1, number.getNumber());
  }
}
