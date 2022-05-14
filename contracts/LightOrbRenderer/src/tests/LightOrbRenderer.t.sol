// SPDX-License-Identifier: MIT

pragma solidity ^0.8.13;

import "forge-std/Test.sol";

contract LightOrbRendererTest is Test {
  address blackHole = address(0);

  function testNumberIs42() public {
    bytes32 addrBytes = bytes32(uint256(uint160(blackHole)));
    console2.logBytes32(addrBytes);
    // assertEq(testNumber, 42);
  }
}
