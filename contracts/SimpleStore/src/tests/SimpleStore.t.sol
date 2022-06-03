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
    string memory gm = huffDeployer.deployContract();
    console.log(gm);
  }

  function testGet() public {
    string memory gm = huffDeployer.deployContract();
    assertEq(gm, "gm");
  }
}
