// SPDX-License-Identifier: AGPL-3.0-only

// Copyright (C) 2017, 2018, 2019, 2020 dbrock, rain, mrchico, d-xo

pragma solidity ^0.8.13;

contract Math {
  // --- Math ---
  function add(uint256 x, uint256 y) internal pure returns (uint256 z) {
    require((z = x + y) >= x);
  }

  function sub(uint256 x, uint256 y) internal pure returns (uint256 z) {
    require((z = x - y) <= x);
  }
}

contract ERC20 is Math {
  // --- ERC20 Data ---
  string public constant name = "Token";
  string public constant symbol = "TKN";
  uint8 public decimals = 18;
  uint256 public totalSupply;

  mapping(address => uint256) public balanceOf;
  mapping(address => mapping(address => uint256)) public allowance;

  event Approval(address indexed src, address indexed guy, uint256 wad);
  event Transfer(address indexed src, address indexed dst, uint256 wad);

  // --- Init ---
  constructor(uint256 _totalSupply) public {
    totalSupply = _totalSupply;
    balanceOf[msg.sender] = _totalSupply;
    emit Transfer(address(0), msg.sender, _totalSupply);
  }

  // --- Token ---
  function transfer(address dst, uint256 wad) public virtual returns (bool) {
    return transferFrom(msg.sender, dst, wad);
  }

  function transferFrom(
    address src,
    address dst,
    uint256 wad
  ) public virtual returns (bool) {
    require(balanceOf[src] >= wad, "insufficient-balance");
    if (src != msg.sender && allowance[src][msg.sender] != type(uint256).max) {
      require(allowance[src][msg.sender] >= wad, "insufficient-allowance");
      allowance[src][msg.sender] = sub(allowance[src][msg.sender], wad);
    }
    balanceOf[src] = sub(balanceOf[src], wad);
    balanceOf[dst] = add(balanceOf[dst], wad);
    emit Transfer(src, dst, wad);
    return true;
  }

  function approve(address usr, uint256 wad) public virtual returns (bool) {
    allowance[msg.sender][usr] = wad;
    emit Approval(msg.sender, usr, wad);
    return true;
  }
}
