// SPDX-License-Identifier: AGPL-3.0

pragma solidity ^0.8.13;

/**


           .o.                    .                            .o8
          .888.                 .o8                           "888
         .8"888.      .oooo.o .o888oo oooo d8b  .ooooo.   .oooo888  oooo d8b  .ooooo.  oo.ooooo.
        .8' `888.    d88(  "8   888   `888""8P d88' `88b d88' `888  `888""8P d88' `88b  888' `88b
       .88ooo8888.   `"Y88b.    888    888     888   888 888   888   888     888   888  888   888
      .8'     `888.  o.  )88b   888 .  888     888   888 888   888   888     888   888  888   888
     o88o     o8888o 8""888P'   "888" d888b    `Y8bod8P' `Y8bod88P" d888b    `Y8bod8P'  888bod8P'
                                                                                        888
                                                                                       o888o


 */

import { Clones } from "@openzeppelin/contracts/proxy/Clones.sol";
import { Shrine } from "./Shrine.sol";

/// @title ShrineFactory
/// @author zefram.eth
/// @notice Clone factory contract for deploying Shrines
contract ShrineFactory {
  using Clones for address;

  event CreateShrine(
    address indexed creator,
    address indexed guardian,
    Shrine indexed shrine
  );

  /// @notice The Shrine template contract used by the minimal proxies
  Shrine public immutable shrineTemplate;

  constructor(Shrine shrineTemplate_) {
    shrineTemplate = shrineTemplate_;
  }

  /// @notice Creates a Shrine given an initial ledger with the distribution shares.
  /// @param guardian The Shrine's initial guardian, who controls the ledger
  /// @param ledger The Shrine's initial ledger with the distribution shares
  /// @param ledgerMetadataIPFSHash The IPFS hash of the initial metadata
  function createShrine(
    address guardian,
    Shrine.Ledger calldata ledger,
    string calldata ledgerMetadataIPFSHash
  ) external returns (Shrine shrine) {
    shrine = Shrine(address(shrineTemplate).clone());

    shrine.initialize(guardian, ledger, ledgerMetadataIPFSHash);

    emit CreateShrine(msg.sender, guardian, shrine);
  }

  /// @notice Creates a Shrine given an initial ledger with the distribution shares.
  /// Uses CREATE2 so that the Shrine's address can be computed deterministically
  /// using predictAddress().
  /// @param guardian The Shrine's initial guardian, who controls the ledger
  /// @param ledger The Shrine's initial ledger with the distribution shares
  /// @param ledgerMetadataIPFSHash The IPFS hash of the initial metadata
  function createShrineDeterministic(
    address guardian,
    Shrine.Ledger calldata ledger,
    string calldata ledgerMetadataIPFSHash,
    bytes32 salt
  ) external returns (Shrine shrine) {
    shrine = Shrine(address(shrineTemplate).cloneDeterministic(salt));

    shrine.initialize(guardian, ledger, ledgerMetadataIPFSHash);

    emit CreateShrine(msg.sender, guardian, shrine);
  }

  /// @notice Predicts the address of a Shrine deployed using CREATE2, given the salt value.
  /// @param salt The salt value used by CREATE2
  function predictAddress(bytes32 salt)
    external
    view
    returns (address pairAddress)
  {
    return address(shrineTemplate).predictDeterministicAddress(salt);
  }
}
