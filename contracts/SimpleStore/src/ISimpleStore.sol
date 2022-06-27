// SPDX-License-Identifier: MIT
pragma solidity >=0.8.13;

interface ISimpleStore {
  function setValue(uint256) external;

  function getValue() external returns (uint256);
}
