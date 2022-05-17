// SPDX-License-Identifier: MIT
// Code from: https://github.com/Perelyn-sama/solidity-hacks/blob/master/src/test/Phishing.t.sol

pragma solidity 0.8.13;

import "ds-test/test.sol";
import "forge-std/Test.sol";
import "../HackPhishing.sol";

contract PhishingTest is DSTest {
  Wallet wallet;
  WalletPrevent walletPrevent;
  Attack attack;
  Attack attackPrevent;

  Vm private vm = Vm(HEVM_ADDRESS);

  address alice;
  address eve = address(200);

  function setUp() public {
    wallet = new Wallet{ value: 10 ether }();
    walletPrevent = new WalletPrevent{ value: 10 ether }();
    alice = wallet.owner();

    vm.prank(eve);
    attack = new Attack(wallet);
    attackPrevent = new Attack(walletPrevent);
  }

  function testAttack() public {
    assertEq(address(wallet).balance, 10 ether);
    assertEq(eve.balance, 0 ether);
    vm.prank(alice, alice);
    attack.attack();

    emit log_named_uint(
      "Balance of Wallet Contract after attack",
      address(wallet).balance
    );
    assertEq(address(wallet).balance, 0 ether);

    vm.prank(eve);
    attack.withdraw();
    assertEq(address(attack).balance, 0 ether);
    assertEq(eve.balance, 10 ether);
  }

  function testFailAttackPrevent() public {
    assertEq(address(walletPrevent).balance, 10 ether);
    assertEq(eve.balance, 0 ether);
    vm.prank(alice, alice);
    attackPrevent.attack();
  }
}
