// SPDX-License-Identifier: AGPL-3.0-only

pragma solidity ^0.8.13;

abstract contract Hevm {
  /// @notice Sets the block timestamp to x
  function warp(uint256 x) public virtual;
}
