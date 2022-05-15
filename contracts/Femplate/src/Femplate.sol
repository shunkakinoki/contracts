// SPDX-License-Identifier: AGPL-3.0-only
// Code from: https://raw.githubusercontent.com/abigger87/femplate/master/src/Greeter.sol

pragma solidity 0.8.13;

/// @title Greeter
/// @author andreas@nascent.xyz
contract Femplate {
  string public _gm;
  address public owner;

  // CUSTOMS
  error BadGm();
  event GMEverybodyGM();

  constructor(string memory newGm) {
    _gm = newGm;
    owner = msg.sender;
  }

  function gm(string memory myGm) external returns (string memory greeting) {
    if (
      keccak256(abi.encodePacked((myGm))) !=
      keccak256(abi.encodePacked((greeting = _gm)))
    ) revert BadGm();
    emit GMEverybodyGM();
  }

  function setGm(string memory newGm) external {
    _gm = newGm;
  }
}
