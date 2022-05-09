// SPDX-License-Identifier: MIT

pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../ViewAndPure.sol";

contract ViewAndPureTest is Test {
  uint256 testNumber;
  ViewAndPure private vap;

  function setUp() public {
    vap = new ViewAndPure();
  }

  function testNumberIs4() public {
    testNumber = vap.addToX(3);
    assertEq(testNumber, 4);
  }

  function testFailSubtract43() public {
    testNumber -= 43;
  }
}
