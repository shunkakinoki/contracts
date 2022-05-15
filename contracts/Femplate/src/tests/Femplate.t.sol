// SPDX-License-Identifier: AGPL-3.0-only

pragma solidity 0.8.13;

import { Femplate } from "../Femplate.sol";

import "forge-std/Test.sol";

contract FemplateTest is Test {
  using stdStorage for StdStorage;

  Femplate femplate;
  ErrorsTest test;

  event GMEverybodyGM();

  function setUp() public {
    console.log(unicode"🧪 Testing Femplate...");
    femplate = new Femplate("gm");
    test = new ErrorsTest();
  }

  // VM Cheatcodes can be found in ./lib/forge-std/src/Vm.sol
  // Or at https://github.com/foundry-rs/forge-std
  function testSetGm() public {
    femplate.setGm("gm gm");

    // Expect the GMEverybodyGM event to be fired
    vm.expectEmit(true, true, true, true);
    emit GMEverybodyGM();
    femplate.gm("gm gm");

    // Expect the gm() call to revert
    vm.expectRevert(abi.encodeWithSignature("BadGm()"));
    femplate.gm("gm");

    // We can read slots directly
    uint256 slot = stdstore
      .target(address(femplate))
      .sig(femplate.owner.selector)
      .find();
    assertEq(slot, 1);
    bytes32 owner = vm.load(address(femplate), bytes32(slot));
    assertEq(address(this), address(uint160(uint256(owner))));

    console.log(unicode"✅ good morning tests passed!");
  }

  // Standard Errors can be found in ./lib/forge-std/src/Test.sol
  // Or at https://github.com/foundry-rs/forge-std
  function testExpectArithmetic() public {
    vm.expectRevert(stdError.arithmeticError);
    test.arithmeticError(10);
  }
}

contract ErrorsTest {
  function arithmeticError(uint256 a) external pure {
    a - 100;
  }
}
