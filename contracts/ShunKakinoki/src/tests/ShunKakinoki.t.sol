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
    assertEq(
      shunkakinoki.shunkakinoki(),
      75851138138918604175079504560600488958015440181295160126060851023364826770682
    );
  }
}
