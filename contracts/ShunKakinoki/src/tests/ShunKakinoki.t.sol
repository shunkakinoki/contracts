// SPDX-License-Identifier: MIT

pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import { ShunKakinoki } from "../ShunKakinoki.sol";

contract ShunKakinokiTest is Test {
  ShunKakinoki shunkakinoki;

  function setUp() public {
    shunkakinoki = new ShunKakinoki();
  }

  function testHashShunKakinoki() public {
    assertEq(uint256(keccak256("shunkakinoki")), shunkakinoki.shunkakinoki());
  }
}
