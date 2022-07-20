// SPDX-License-Identifier: MIT

pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "@shunkakinoki/huff/HuffDeployer.sol";

interface ISimpleStore {
  function setValue(uint256) external;

  function getValue() external returns (uint256);
}

contract HuffHelloWorldTest is Test {
  HuffDeployer huffDeployer = new HuffDeployer();
  ISimpleStore public simpleStore;

  function setUp() public {
    simpleStore = ISimpleStore(
      huffDeployer.deploy("huff_contracts/SimpleStore")
    );
  }

  /// @dev Ensure that you can set and get the value.
  function testSetAndGetValue(uint256 value) public {
    simpleStore.setValue(value);
    console.log(value);
    console.log(simpleStore.getValue());
    assertEq(value, simpleStore.getValue());
  }
}
