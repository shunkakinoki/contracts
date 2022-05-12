//SPDX-License-Identifier: MIT

pragma solidity ^0.8.13;

import "./MerkleProof.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/security/Pausable.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/utils/structs/BitMaps.sol";

import "hardhat/console.sol";

contract ClaimCODE is Ownable, Pausable {
  using BitMaps for BitMaps.BitMap;

  BitMaps.BitMap private claimed;

  bytes32 public merkleRoot;
  uint256 public claimPeriodEnds;

  IERC20 public immutable codeToken;

  event MerkleRootChanged(bytes32 _merkleRoot);
  event Claim(address indexed _claimant, uint256 _amount);

  error Address0Error();
  error InvalidProof();
  error AlreadyClaimed();
  error ClaimEnded();
  error ClaimNotEnded();
  error InitError();

  constructor(uint256 _claimPeriodEnds, address _codeToken) {
    if (_codeToken == address(0)) revert Address0Error();
    claimPeriodEnds = _claimPeriodEnds;
    codeToken = IERC20(_codeToken);
  }

  function verify(bytes32[] calldata proof, bytes32 leaf)
    public
    view
    returns (bool, uint256)
  {
    return MerkleProof.verify(proof, merkleRoot, leaf);
  }

  function claimTokens(uint256 _amount, bytes32[] calldata _merkleProof)
    external
    whenNotPaused
  {
    bytes32 leaf = keccak256(abi.encodePacked(msg.sender, _amount));
    (bool valid, uint256 index) = verify(_merkleProof, leaf);
    if (!valid) revert InvalidProof();
    if (isClaimed(index)) revert AlreadyClaimed();
    if (block.timestamp > claimPeriodEnds) revert ClaimEnded();

    claimed.set(index);
    emit Claim(msg.sender, _amount);

    codeToken.transfer(msg.sender, _amount);
  }

  function isClaimed(uint256 index) public view returns (bool) {
    return claimed.get(index);
  }

  function setMerkleRoot(bytes32 _merkleRoot) external onlyOwner {
    if (merkleRoot != bytes32(0)) revert InitError();
    merkleRoot = _merkleRoot;
    emit MerkleRootChanged(_merkleRoot);
  }

  function sweep() external onlyOwner {
    if (block.timestamp <= claimPeriodEnds) revert ClaimNotEnded();
    codeToken.transfer(owner(), codeToken.balanceOf(address(this)));
  }

  function pause() external onlyOwner {
    _pause();
  }

  function unpause() external onlyOwner {
    _unpause();
  }
}
