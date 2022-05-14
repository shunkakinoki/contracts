// SPDX-License-Identifier: MIT

pragma solidity ^0.8.13;

import "@openzeppelin/contracts/access/Ownable.sol";

contract Controller is Ownable {
  /*//////////////////////////////////////////////////////////////
                                STORAGE
    //////////////////////////////////////////////////////////////*/

  bool public publicMint;
  bool public whitelistMint;
  string public baseURI;
  bytes32 public merkleRoot;

  /*//////////////////////////////////////////////////////////////
                                GOVERNANCE LOGIC
    //////////////////////////////////////////////////////////////*/

  function setBaseURI(string memory _baseURI) public onlyOwner {
    baseURI = _baseURI;
  }

  function setMerkleRoot(bytes32 _merkleRoot) public onlyOwner {
    merkleRoot = _merkleRoot;
  }

  function startWhitelistMint() public onlyOwner {
    whitelistMint = true;
  }

  function startPublicMint() public onlyOwner {
    publicMint = true;
  }

  function withdrawPayments(address payable payee) external onlyOwner {
    uint256 balance = address(this).balance;
    (bool transferTx, ) = payee.call{ value: balance }("");
    require(transferTx);
  }
}
