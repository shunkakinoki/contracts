// SPDX-License-Identifier: MIT

pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../LightOrb.sol";

contract LightOrbTest is Test {
  LightOrb private orb;

  function setUp() public {
    orb = new LightOrb();
  }
}
