// SPDX-License-Identifier: MIT

pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../Example.sol";
import "../ClonesFactory.sol";

contract ClonesTest is Test {
  Example example;
  ClonesFactory factory;

  event CreateExample(address indexed creator, address indexed);

  function setUp() public {
    example = new Example();
    factory = new ClonesFactory(example);
  }

  function testCreateExample() public {
    Example deployed;

    vm.expectEmit(true, true, false, false);
    emit CreateExample(
      address(this),
      address(0x9cC6334F1A7Bc20c9Dde91Db536E194865Af0067)
    );

    deployed = factory.createExample();
  }

  function testCreate2Example() public {
    Example deployed;

    address addr = factory.predictAddress(keccak256("salt"));
    vm.expectEmit(true, true, false, false);
    emit CreateExample(
      address(this),
      address(0x8278f96a10D170E85bc496D819304fC3D8CE6bc0)
    );

    deployed = factory.createExampleDeterministic(keccak256("salt"));
    assertEq(addr, address(deployed));
  }
}
