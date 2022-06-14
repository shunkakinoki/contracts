// SPDX-License-Identifier: MIT
// Code from: https://github.com/fracton-ventures/foundry-transparent-proxy-pattern

pragma solidity ^0.8.13;

import { FooV1 } from "./upgrades/FooV1.sol";
import { FooV2 } from "./upgrades/FooV2.sol";
import { ProxyAdmin } from "@openzeppelin/contracts/proxy/transparent/ProxyAdmin.sol";
import { TransparentUpgradeableProxy } from "@openzeppelin/contracts/proxy/transparent/TransparentUpgradeableProxy.sol";

import "forge-std/Test.sol";

contract TransparentUpgradeableProxyTest is Test {
  ProxyAdmin internal admin;
  TransparentUpgradeableProxy internal proxy;
  FooV1 internal fooV1;
  FooV2 internal fooV2;

  // The state of the contract gets reset before each
  // test is run, with the `setUp()` function being called
  // each time after deployment. Think of this like a JavaScript
  // `beforeEach` block
  function setUp() public {
    fooV1 = new FooV1();
    admin = new ProxyAdmin();
    proxy = new TransparentUpgradeableProxy(address(fooV1), address(admin), "");
    fooV1 = FooV1(address(proxy));
    fooV1.initialize();
    require(fooV1.x() == 1, "x is not 1");
    fooV1.double();
    require(fooV1.x() == 2, "x is not 2");
    fooV2 = new FooV2();
  }

  // A simple unit test
  function testProxy() public {
    admin.upgrade(proxy, address(fooV2));
    fooV2 = FooV2(address(proxy));
    require(fooV2.x() == 2, "x is not 2");
    fooV2.triple();
    require(fooV2.x() == 6, "x is not 6");
  }

  // A failing unit test (function name starts with `testFail`)
  function testProxyFail() public {
    vm.expectRevert(bytes("Ownable: caller is not the owner"));
    vm.prank(address(0));
    admin.upgrade(proxy, address(fooV2));
  }
}
