// SPDX-License-Identifier: MIT

pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "@shunkakinoki/huff/HuffDeployer.sol";

interface IHelloWorld {
  fallback() external;
}

contract HuffHelloWorldTest is Test {
  HuffDeployer huffDeployer = new HuffDeployer();
  IHelloWorld public helloWorld;
  bytes32 public name;

  function setUp() public {
    helloWorld = IHelloWorld(huffDeployer.deploy("huff_contracts/HelloWorld"));
  }

  function testFallback() public {
    address(helloWorld).call{ value: 0 ether }("");
  }
}
