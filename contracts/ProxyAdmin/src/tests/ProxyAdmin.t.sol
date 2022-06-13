// SPDX-License-Identifier: MIT

pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import { OZProxyAdmin } from "../ProxyAdmin.sol";

contract ProxyAdminTest is Test {
  OZProxyAdmin proxy;
  event OwnershipTransferred(
    address indexed previousOwner,
    address indexed newOwner
  );

  function setUp() public {
    vm.deal(address(1), 1 ether);
    vm.startPrank(address(1));
    proxy = new OZProxyAdmin();
  }

  function testOwner() public {
    assertEq(proxy.owner(), address(1));
  }

  function testRenounceOwnership() public {
    vm.expectEmit(true, true, false, false);
    emit OwnershipTransferred(address(1), address(0));
    proxy.renounceOwnership();
    assertEq(proxy.owner(), address(0));
  }

  function testRenounceOwnershipExplicit() public {
    vm.expectEmit(true, true, false, true, address(proxy));
    emit OwnershipTransferred(address(1), address(0));
    proxy.renounceOwnership();
    assertEq(proxy.owner(), address(0));
  }
}
