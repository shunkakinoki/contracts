// SPDX-License-Identifier: AGPL-3.0-only

// Copyright (C) 2020 d-xo

pragma solidity ^0.8.13;

import { ERC20 } from "./ERC20.sol";

contract RevertZeroToken is ERC20 {
  // --- Init ---
  constructor(uint256 _totalSupply) public ERC20(_totalSupply) {}

  // --- Token ---
  function transferFrom(
    address src,
    address dst,
    uint256 wad
  ) public override returns (bool) {
    require(wad != 0, "zero-value-transfer");
    return super.transferFrom(src, dst, wad);
  }
}
