// SPDX-License-Identifier: MIT

pragma solidity ^0.8.13;

import "hardhat/console.sol";

contract ShunKakinoki {
  string public name = "shunkakinoki";
  uint256 public shunkakinoki = uint256(keccak256(abi.encodePacked(name)));
}
