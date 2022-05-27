// SPDX-License-Identifier: MIT

pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import { Create2Factory } from "../Create2.sol";

contract Create2Test is Test {
  Create2Factory create2;
  address deployedAddress;
  address deployer = address(1);
  bytes deployedBytecode;

  function setUp() public {
    vm.prank(deployer);
    create2 = new Create2Factory();
    // Init Bytecode with constructor of 1
    deployedBytecode = create2.getBytecode(deployer, 1);
    // Init Address with salt of 123
    deployedAddress = create2.getAddress(deployedBytecode, 123);
  }

  function testCheckDeployedAddress() public {
    console.log(deployedAddress);
    console.log(address(deployedAddress).balance);
    console.logBytes(deployedBytecode);

    assertEq(
      deployedAddress,
      address(0x4cBC64D399F793221529607d2Ca4e562CCf0594f)
    );
  }
}
