// SPDX-License-Identifier: MIT

pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "forge-std/console2.sol";
import "@shunkakinoki/huff/HuffDeployer.sol";

interface IShunKakinoki {
  fallback() external;
}

contract HuffShunKakinokiTest is Test {
  HuffDeployer huffDeployer = new HuffDeployer();
  IShunKakinoki public shunKakinoki;
  bytes public result;

  function setUp() public {
    shunKakinoki = IShunKakinoki(
      huffDeployer.deploy("huff_contracts/ShunKakinoki")
    );
  }

  function testFallback() public {
    (, result) = address(shunKakinoki).call{ value: 0 ether }("");
    console2.logBytes(result);
    assertEq(
      result,
      hex"0000000000000000000000000000000000000000000000000000000000000020000000000000000000000000000000000000000000000000000000000000000c007368756e6b616b696e6f6b6900000000000000000000000000000000000000"
    );
  }
}
