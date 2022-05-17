// SPDX-License-Identifier: MIT
// Code from: https://github.com/Perelyn-sama/solidity-hacks/blob/master/src/test/Reentrancy.t.sol

pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "ds-test/test.sol";
import "../HackReentrancy.sol";
import "forge-std/Test.sol";

contract HackReentrancyTest is DSTest {
  EtherStore etherStore;
  EtherStorePrevention etherStorePrevention;
  Attack etherStoreAttack;
  Vm private vm = Vm(HEVM_ADDRESS);

  address addr1 = address(100);
  address addr2 = address(200);

  function setUp() public {
    etherStore = new EtherStore();
    etherStorePrevention = new EtherStorePrevention();
    etherStoreAttack = new Attack(address(etherStore));

    emit log_address(address(etherStore));
    vm.deal(addr1, 100);
    vm.deal(addr2, 100);
  }

  function testAttack() public {
    etherStore.deposit{ value: 2 ether }();
    assertEq(etherStore.getBalance(), 2 ether);

    etherStoreAttack.getBalance();
    assertEq(etherStoreAttack.getBalance(), 0 ether);
    etherStoreAttack.attack{ value: 1 ether }();
    assertEq(etherStoreAttack.getBalance(), 3 ether);
    assertEq(etherStore.getBalance(), 0 ether);
  }

  function testAttackPrevention() public {
    etherStorePrevention.deposit{ value: 2 ether }();
    assertEq(etherStorePrevention.getBalance(), 2 ether);

    etherStoreAttack.getBalance();
    assertEq(etherStoreAttack.getBalance(), 0 ether);
    etherStoreAttack.attack{ value: 1 ether }();
    assertEq(etherStoreAttack.getBalance(), 1 ether);
    assertEq(etherStorePrevention.getBalance(), 2 ether);
  }
}
