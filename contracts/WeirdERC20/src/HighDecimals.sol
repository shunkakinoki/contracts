// Copyright (C) 2020 d-xo
// SPDX-License-Identifier: AGPL-3.0-only

pragma solidity ^0.8.13;

import { ERC20 } from "./ERC20.sol";

contract HighDecimalToken is ERC20 {
  constructor(uint256 _totalSupply) public ERC20(_totalSupply) {
    decimals = 50;
  }
}
