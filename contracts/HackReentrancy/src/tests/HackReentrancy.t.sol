// SPDX-License-Identifier: MIT

pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "ds-test/test.sol";
import "../HackReentrancy.sol";
import "forge-std/Test.sol";

contract HackReentrancyTest is DSTest {
  EtherStore etherStore;
  Attack etherStoreAttack;
  Vm private vm = Vm(HEVM_ADDRESS);

  address addr1 = address(100);
  address addr2 = address(200);

  function setUp() public {
    etherStore = new EtherStore();
    etherStoreAttack = new Attack(address(etherStore));

    emit log_address(address(etherStore));
    vm.deal(addr1, 100);
    vm.deal(addr2, 100);
  }

  function testAttack() public {
    etherStore.deposit{ value: 2 ether }();
    emit log_named_uint(
      "Ether in Store contract after deposit",
      etherStore.getBalance()
    );

    emit log_named_uint(
      "Ether in Attack contract after before attack",
      etherStoreAttack.getBalance()
    );
    etherStoreAttack.attack{ value: 1 ether }();
    emit log_named_uint(
      "Ether in Attack contract after after attack",
      etherStoreAttack.getBalance()
    );

    emit log_named_uint(
      "Ether in Store contract after attack",
      etherStore.getBalance()
    );
  }
}
