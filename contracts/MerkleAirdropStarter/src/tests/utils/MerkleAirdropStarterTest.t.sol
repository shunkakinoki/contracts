// SPDX-License-Identifier: AGPL-3.0-only
pragma solidity >=0.8.0;

/// ============ Imports ============

import { DSTest } from "ds-test/test.sol"; // DSTest
import { MerkleAirdropStarter } from "../../MerkleAirdropStarter.sol"; // MerkleAirdropStarter
import { MerkleAirdropStarterUser } from "./MerkleAirdropStarterUser.t.sol"; // MerkleAirdropStarter user

/// @title MerkleAirdropStarterTest
/// @notice Scaffolding for MerkleAirdropStarter tests
/// @author Anish Agnihotri <contact@anishagnihotri.com>
contract MerkleAirdropStarterTest is DSTest {
  /// ============ Storage ============

  /// @dev MerkleAirdropStarter contract
  MerkleAirdropStarter internal TOKEN;
  /// @dev User: Alice (in merkle tree)
  MerkleAirdropStarterUser internal ALICE;
  /// @dev User: Bob (not in merkle tree)
  MerkleAirdropStarterUser internal BOB;

  /// ============ Setup test suite ============

  function setUp() public virtual {
    // Create airdrop token
    TOKEN = new MerkleAirdropStarter(
      "My Token",
      "MT",
      18,
      // Merkle root containing ALICE with 100e18 tokens but no BOB
      0xd0aa6a4e5b4e13462921d7518eebdb7b297a7877d6cfe078b0c318827392fb55
    );

    // Setup airdrop users
    ALICE = new MerkleAirdropStarterUser(TOKEN); // 0x185a4dc360ce69bdccee33b3784b0282f7961aea
    BOB = new MerkleAirdropStarterUser(TOKEN); // 0xefc56627233b02ea95bae7e19f648d7dcd5bb132
  }
}
