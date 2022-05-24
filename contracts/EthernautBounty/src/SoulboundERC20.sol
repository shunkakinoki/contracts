// SPDX-License-Identifier: MIT
// Code from: https://github.com/tahos81/ethernaut-bounty

pragma solidity ^0.8.13;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

interface ISoulboundNFT {
  function updateURI(address addressToUpdate) external;

  function balanceOf(address owner) external view returns (uint256);
}

/// @notice Soulbound ERC20, will be minted by ethernautDAO as a reward token.
/// @author Tahos81 (https://github.com/tahos81/ethernaut-bounty/blob/main/src/SoulboundERC20.sol)
contract SoulboundERC20 is ERC20, Ownable {
  error Soulbound();
  error OnlyApprovedMinter();
  error ZeroBurn();

  ISoulboundNFT immutable sNFT;

  mapping(address => bool) public approvedMinters;

  event MinterApproved(address indexed minter, bool isApproved);

  constructor(
    string memory _name,
    string memory _symbol,
    address nftAdress
  ) ERC20(_name, _symbol) {
    sNFT = ISoulboundNFT(nftAdress);
  }

  function setApprovedMinter(address _approvedMinter, bool isApproved)
    external
    onlyOwner
  {
    approvedMinters[_approvedMinter] = isApproved;
    emit MinterApproved(_approvedMinter, isApproved);
  }

  //Mints _amount tokens to the _to address and makes a call to update corresponding NFT URI
  function mint(address _to, uint256 _amount) external {
    if (!approvedMinters[msg.sender]) revert OnlyApprovedMinter();

    _mint(_to, _amount);

    if (sNFT.balanceOf(_to) != 0) {
      sNFT.updateURI(_to);
    }
  }

  //Burns amount tokens from msg.sender and makes a call to update corresponding NFT URI
  function burn(uint256 amount) external {
    if (amount == 0) revert ZeroBurn();
    _burn(msg.sender, amount);
    if (sNFT.balanceOf(msg.sender) != 0) {
      sNFT.updateURI(msg.sender);
    }
  }

  /*//////////////////////////////////////////////////////////////
                            SOULBOUND LOGIC
    //////////////////////////////////////////////////////////////*/

  //Disallowed for preventing gas waste
  function _approve(
    address owner,
    address spender,
    uint256 amount
  ) internal override {
    revert Soulbound();
  }

  //Only allows transfers if it is minting or burning
  function _beforeTokenTransfer(
    address from,
    address to,
    uint256 amount
  ) internal override {
    if (from != address(0) && to != address(0)) revert Soulbound();
  }
}
