// SPDX-License-Identifier: MIT

pragma solidity ^0.8.13;

contract ExampleContract {
  uint256 public store;
  address public addr;

  function testStaticCall() public pure returns (uint256) {
    return 1002;
  }

  function testStore(uint256 i) public {
    store = i;
  }
}
