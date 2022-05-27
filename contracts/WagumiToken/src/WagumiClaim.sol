// SPDX-License-Identifier: MIT

pragma solidity ^0.8.13;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import { MerkleProof } from "@openzeppelin/contracts/utils/cryptography/MerkleProof.sol";

/// @title Wagumi Token <https://wagumi.xyz>
/// @author Shun Kakinoki <https://shunkakinoki.com>
/// @notice A RFC proposal for a continuous claiming contract for Wagumi DAO.
contract WagumiClaim is Ownable {
  /* -------------------------------------------------------------------------- */
  /*                                   CONFIG                                   */
  /* -------------------------------------------------------------------------- */
  IERC20 public immutable wagumiToken;
  bytes32[] public merkleRootList;
  mapping(address => mapping(uint256 => bool)) public hasClaimed;
  uint256 public claimPeriodEnds;

  /* -------------------------------------------------------------------------- */
  /*                                   EVENTS                                   */
  /* -------------------------------------------------------------------------- */
  /// @notice A claim has been made to the address of a specified amount
  event Claim(address indexed to, uint256[] index, uint256 totalAmount);

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
  /*                                   ADMIN                                    */
  /* -------------------------------------------------------------------------- */

  /// @notice Add a new merkle root to the list of merkle roots
  /// @param _root The merkle root to add
  function setMerkleRoot(bytes32 _root) external onlyOwner {
    merkleRootList.push(_root);
  }

  /* -------------------------------------------------------------------------- */
  /*                                 CONSTRUCTOR                                */
  /* -------------------------------------------------------------------------- */
  constructor(address _wagumiToken) {
    wagumiToken = IERC20(_wagumiToken);
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
    uint256[] calldata _amount,
    bytes32[] calldata _proof
  ) external {
    /// Verify Merkle proof, or revert if not in tree
    bytes32 leaf = keccak256(abi.encodePacked(msg.sender, _amount));
    (bool valid, uint256[] memory index) = verify(_proof, leaf);
    if (!valid) {
      revert InvalidProof();
    }

    uint256 totalAmount;
    for (uint256 i = 0; i < index.length - 1; i++) {
      hasClaimed[_to][i] = true;
      totalAmount += _amount[i];
    }
    wagumiToken.transfer(_to, totalAmount);
    emit Claim(_to, index, totalAmount);
  }

  /// @notice Verify a merkle proof of a claim
  /// @param _proof The merkle proof to verify
  /// @param _leaf The leaf to verify
  function verify(bytes32[] calldata _proof, bytes32 _leaf)
    public
    view
    returns (bool, uint256[] memory)
  {
    bool isVerified = false;
    uint256[] memory verifiedList;
    for (uint256 i = 0; i < merkleRootList.length - 1; i++) {
      isVerified = MerkleProof.verify(_proof, merkleRootList[i], _leaf);
      verifiedList[i] = i;
    }
    return (isVerified, verifiedList);
  }

  function removeMerkleRootList(uint256 index) external onlyOwner {
    if (index >= merkleRootList.length) return;

    for (uint256 i = index; i < merkleRootList.length - 1; i++) {
      merkleRootList[i] = merkleRootList[i + 1];
    }

    merkleRootList.pop();
  }
}
