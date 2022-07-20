// SPDX-License-Identifier: MIT

pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "forge-std/console2.sol";
import "@shunkakinoki/huff/HuffDeployer.sol";

interface IHelloWorld {
  fallback() external;
}

contract HuffHelloWorldTest is Test {
  HuffDeployer huffDeployer = new HuffDeployer();
  IHelloWorld public helloWorld;
  bytes public result;

  function setUp() public {
    helloWorld = IHelloWorld(huffDeployer.deploy("huff_contracts/HelloWorld"));
  }

  function testFallback() public {
    (, result) = address(helloWorld).call{ value: 0 ether }("");
    console2.logBytes(result);
  }
}
