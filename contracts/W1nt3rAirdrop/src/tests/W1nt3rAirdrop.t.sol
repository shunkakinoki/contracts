// SPDX-License-Identifier: MIT

pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../W1nt3rAirdrop.sol";

contract W1nt3rAirdropTest is Test {
  W1nt3rAirdrop airdrop;

  function setUp() public {
    airdrop = new W1nt3rAirdrop();
  }

  function testRun() public {
    bytes32 calc = bytes32(
      keccak256(
        abi.encodePacked(address(0x4fd9D0eE6D6564E80A9Ee00c0163fC952d0A45Ed))
      )
    );
    console2.logBytes32(calc);
    assertEq(airdrop.key(), calc);
  }
}
