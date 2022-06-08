// SPDX-License-Identifier: MIT

pragma solidity ^0.8.13;

// Code from: https://twitter.com/m1guelpf/status/1529340774286073857?s=20&t=I_X_6QPRQzU9xZpdo-6dqA
contract TheMerge {
  function hasMergeSucceeded() public view returns (bool) {
    return block.difficulty > 2**64;
  }
}
