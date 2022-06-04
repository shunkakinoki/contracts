// SPDX-License-Identifier: MIT

pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import { EVM } from "../EVM.sol";

contract EVMTest is Test {
  EVM evm;

  function setUp() public {
    evm = new EVM();
  }

  // GAS 3: add(uint256, uint256)
  function testAdd() public {
    assertEq(evm.add(1, 2), 3);
    // overflows on 2**256
    assertEq(evm.add(1, (2**256 - 1)), 0);
    // same as above
    assertEq(
      evm.add(
        1,
        0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      ),
      0
    );
  }

  // GAS 5: mul(uint256, uint256)
  function testMul() public {
    assertEq(evm.mul(1, 2), 2);
    // overflows on 2**256
    assertEq(evm.mul(2, (2**256 - 1)), (2**256 - 2));
    // same as above
    assertEq(
      evm.mul(
        2,
        0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      ),
      0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE
    );
  }
}
