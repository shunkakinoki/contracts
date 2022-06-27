// SPDX-License-Identifier: MIT

pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "@shunkakinoki/huff/HuffDeployer.sol";
import "../ISimpleStore.sol";

contract SimpleStoreTest is Test {
  ///@notice create a new instance of HuffDeployer
  HuffDeployer huffDeployer = new HuffDeployer();

  ISimpleStore simpleStore;

  function setUp() public {
    ///@notice deploy a new instance of ISimplestore by passing in the address of the deployed Huff contract
    simpleStore = ISimpleStore(
      huffDeployer.deploy("huff_contracts/SimpleStore")
    );
  }

  function testSetAndGetValue(uint256 value) public {
    simpleStore.setValue(value);
    console.log(value);
    console.log(simpleStore.getValue());
    assertEq(value, simpleStore.getValue());
  }
}
