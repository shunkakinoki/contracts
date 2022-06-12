// SPDX-License-Identifier: AGPL-3.0-only
// Copyright (C) 2020 d-xo

pragma solidity ^0.8.13;

import { ERC20 } from "./ERC20.sol";

contract LowDecimalToken is ERC20 {
  constructor(uint256 _totalSupply) public ERC20(_totalSupply) {
    decimals = 2;
  }
}
