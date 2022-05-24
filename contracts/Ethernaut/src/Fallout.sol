// SPDX-License-Identifier: MIT

pragma solidity ^0.8.13;

import "@openzeppelin/contracts/utils/math/SafeMath.sol";

contract Fallout {
  using SafeMath for uint256;
  mapping(address => uint256) allocations;
  address payable public owner;

  function Fal1out() public payable {
    owner = payable(msg.sender);
    allocations[owner] = msg.value;
  }

  modifier onlyOwner() {
    require(msg.sender == owner, "caller is not the owner");
    _;
  }

  function allocate() public payable {
    allocations[msg.sender] = allocations[msg.sender].add(msg.value);
  }

  function sendAllocation(address payable allocator) public {
    // solhint-disable-next-line reason-string
    require(allocations[allocator] > 0);
    allocator.transfer(allocations[allocator]);
  }

  function collectAllocations() public onlyOwner {
    payable(msg.sender).transfer(address(this).balance);
  }

  function allocatorBalance(address allocator) public view returns (uint256) {
    return allocations[allocator];
  }
}
