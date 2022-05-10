// SPDX-License-Identifier: AGPL-3.0-only
// Code from: https://raw.githubusercontent.com/Anish-Agnihotri/merkle-airdrop-starter/master/contracts/src/test/utils/MerkleAirdropStarterUser.sol

pragma solidity ^0.8.13;

/// ============ Imports ============

import { MerkleAirdropStarter } from "../../MerkleAirdropStarter.sol"; // MerkleAirdropStarter

/// @title MerkleAirdropStarterUser
/// @notice Mock MerkleAirdropStarter user
/// @author Anish Agnihotri <contact@anishagnihotri.com>
contract MerkleAirdropStarterUser {
  /// ============ Immutable storage ============

  /// @dev MerkleAirdropStarter contract
  MerkleAirdropStarter internal immutable TOKEN;

  /// ============ Constructor ============

  /// @notice Creates a new MerkleAirdropStarterUser
  /// @param _TOKEN MerkleAirdropStarter contract
  constructor(MerkleAirdropStarter _TOKEN) {
    TOKEN = _TOKEN;
  }

  /// ============ Helper functions ============

  /// @notice Returns users' token balance
  function tokenBalance() public view returns (uint256) {
    return TOKEN.balanceOf(address(this));
  }

  /// ============ Inherited functionality ============

  /// @notice Allows user to claim tokens from contract
  /// @param to address of claimee
  /// @param amount of tokens owed to claimee
  /// @param proof merkle proof to prove address and amount are in tree
  function claim(
    address to,
    uint256 amount,
    bytes32[] calldata proof
  ) public {
    TOKEN.claim(to, amount, proof);
  }
}
