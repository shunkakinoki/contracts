// SPDX-License-Identifier: MIT

pragma solidity ^0.8.13;

import "./Pizza.sol";

contract PizzaV2 is Pizza {
  ///@dev increments the slices when called
  function refillSlice() external {
    slices += 1;
  }

  ///@dev returns the contract version
  function pizzaVersion() external pure returns (uint256) {
    return 2;
  }
}
