// SPDX-License-Identifier: MIT

pragma solidity ^0.8.13;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import { MerkleProof } from "@openzeppelin/contracts/utils/cryptography/MerkleProof.sol";
import "@openzeppelin/contracts/utils/structs/BitMaps.sol";
import "@openzeppelin/contracts/security/Pausable.sol";

/// @title Wagumi Token <https://wagumi.xyz>
/// @author Shun Kakinoki <https://shunkakinoki.com>
/// @notice A RFC proposal for a token that can be used to govern Wagumi DAO.
contract WagumiClaim is Ownable, Pausable {
  /* -------------------------------------------------------------------------- */
  /*                                   CONFIG                                   */
  /* -------------------------------------------------------------------------- */
  IERC20 public immutable wagumiToken;
  bytes32 public merkleRoot;
  mapping(address => bool) public hasClaimed;
  uint256 public claimPeriodEnds;

  /* -------------------------------------------------------------------------- */
  /*                                   EVENTS                                   */
  /* -------------------------------------------------------------------------- */
  /// @notice A claim has been made to the address of a specified amount
  event Claim(address indexed to, uint256 amount);

  /* -------------------------------------------------------------------------- */
  /*                                   ERROR                                    */
  /* -------------------------------------------------------------------------- */
  /// @notice Thrown if address has already claimed
  error AlreadyClaimed();
  /// @notice Thrown error if proof is invalid
  error InvalidProof();
  /// @notice Thrown if claim period has ended
  error ClaimEnded();

  /* -------------------------------------------------------------------------- */
  /*                                 CONSTRUCTOR                                */
  /* -------------------------------------------------------------------------- */
  constructor(address _wagumiToken) {
    wagumiToken = IERC20(_wagumiToken);
  }

  /* -------------------------------------------------------------------------- */
  /*                                   ADMIN                                    */
  /* -------------------------------------------------------------------------- */

  /// @notice Allows owner to pause state
  function pause() external onlyOwner {
    _pause();
  }

  /// @notice Allows owner to unpause state
  function unpause() external onlyOwner {
    _unpause();
  }

  /* -------------------------------------------------------------------------- */
  /*                                   PUBLIC                                   */
  /* -------------------------------------------------------------------------- */

  /// @notice Allows claiming a number of tokens to a given address
  /// @param _to The address to send the minted tokens to
  /// @param _amount The amount of tokens to claim
  /// @param _proof The merkle proof of the claim
  function claim(
    address _to,
    uint256 _amount,
    bytes32[] calldata _proof
  ) external whenNotPaused {
    /// Revert if already claimed
    if (!isClaimed(_to)) {
      revert AlreadyClaimed();
    }

    /// Revert if claim period has ended
    if (block.timestamp > claimPeriodEnds) {
      revert ClaimEnded();
    }

    /// Verify Merkle proof, or revert if not in tree
    bytes32 leaf = keccak256(abi.encodePacked(msg.sender, _amount));
    bool valid = verify(_proof, leaf);
    if (!valid) {
      revert InvalidProof();
    }

    /// Send tokens to address with specified amount
    hasClaimed[_to] = true;
    wagumiToken.transfer(_to, _amount);
    emit Claim(_to, _amount);
  }

  /// @notice Get whether a given address has already claimed tokens
  /// @param _to The address to check
  function isClaimed(address _to) public view returns (bool) {
    return hasClaimed[_to];
  }

  /// @notice Verify a merkle proof of a claim
  /// @param _proof The merkle proof to verify
  /// @param _leaf The leaf to verify
  function verify(bytes32[] calldata _proof, bytes32 _leaf)
    public
    view
    returns (bool)
  {
    return MerkleProof.verify(_proof, merkleRoot, _leaf);
  }
}
