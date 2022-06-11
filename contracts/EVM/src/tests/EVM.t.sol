// SPDX-License-Identifier: MIT

pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import { EVM } from "../EVM.sol";

contract EVMTest is Test {
  EVM evm;

  function setUp() public {
    evm = new EVM();
  }

  // 01 GAS 3: add(uint256, uint256)
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

  // 02 GAS 5: mul(uint256, uint256)
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

  // 03 GAS 3: sub(uint256, uint256)
  function testSub() public {
    assertEq(evm.sub(10, 10), 0);
    // underflow on 2**256
    assertEq(evm.sub(0, 1), (2**256 - 1));
    // same as above
    assertEq(
      evm.sub(0, 1),
      0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
    );
  }

  // 04 GAS 3: div(uint256, uint256)
  function testDiv() public {
    assertEq(evm.div(10, 10), 1);
    // underflow on 2**256 - if the denominator is 0, resuit=0.
    assertEq(evm.div(1, 2), 0);
    // underflow on 2**256
    assertEq(evm.div((2**256 - 2), (2**256 - 1)), 0);
    // same as above
    assertEq(
      evm.div(
        0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE,
        0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      ),
      0
    );
  }

  // 05 GAS 5: sdiv(uint256, uint256)
  function testSdiv() public {
    assertEq(evm.sdiv(10, 10), 1);
    // underflow on 2**256 - if the denominator is 0, resuit=0.
    assertEq(evm.sdiv(1, 2), 0);
    // overflows on -2**255
    assertEq(evm.sdiv((2**256 - 2), (2**256 - 1)), 2);
    // same as above
    assertEq(
      evm.sdiv(
        0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE,
        0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      ),
      2
    );
  }

  // 06 GAS 5: mod(uint256, uint256)
  function testMod() public {
    assertEq(evm.mod(10, 3), 1);
    // underflow on 2**256
    assertEq(evm.mod(17, 5), 2);
  }

  // 07 GAS 5: smod(uint256, uint256)
  function testSmod() public {
    assertEq(evm.smod(10, 3), 1);
    // underflow on 2**256
    assertEq(evm.smod(17, 5), 2);
    // underflows on -2**255
    assertEq(
      evm.smod((2**256 - 6), (2**256 - 4)),
      0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE
    );
    assertEq(
      evm.smod(
        0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8,
        0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD
      ),
      0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE
    );
  }

  // 08 GAS 8: addMod(uint256, uint256, uint256)
  function testAddMod() public {
    assertEq(evm.addMod(10, 10, 8), 4);
    assertEq(
      evm.addMod(
        0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF,
        2,
        2
      ),
      1
    );
  }

  // 09 GAS 8: mulMod(uint256, uint256, uint256)
  function testMulMod() public {
    assertEq(evm.mulMod(10, 10, 8), 4);
    assertEq(
      evm.mulMod(
        0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF,
        0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF,
        12
      ),
      9
    );
  }

  // 0A GAS 10: exp(uint256, uint256)
  function testExp() public {
    assertEq(evm.exp(10, 2), 100);
    assertEq(evm.exp(2, 2), 4);
  }

  // 0B GAS 5: mulMod(uint256, uint256, uint256)
  function testSignExtend() public {
    assertEq(
      evm.signExtend(0, 0xFF),
      0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
    );
    assertEq(evm.signExtend(0, 0x7F), 0x7F);
  }

  // 10 GAS 3: mulMod(uint256, uint256, uint256)
  function testLt() public {
    assertEq(evm.lt(9, 10), 1);
    assertEq(evm.lt(10, 10), 0);
  }
}
