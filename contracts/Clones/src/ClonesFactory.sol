// SPDX-License-Identifier: MIT

pragma solidity ^0.8.13;

import { Clones } from "@openzeppelin/contracts/proxy/Clones.sol";
import { Example } from "./Example.sol";

contract ClonesFactory {
  using Clones for address;

  event CreateExample(address indexed creator, address indexed);

  Example public immutable exampleTemplate;

  constructor(Example exampleTemplate_) {
    exampleTemplate = exampleTemplate_;
  }

  function createExample() external returns (Example example) {
    example = Example(address(exampleTemplate).clone());

    emit CreateExample(msg.sender, address(example));
  }

  function createExampleDeterministic(bytes32 salt)
    external
    returns (Example example)
  {
    example = Example(address(exampleTemplate).cloneDeterministic(salt));

    emit CreateExample(msg.sender, address(example));
  }

  function predictAddress(bytes32 salt)
    external
    view
    returns (address pairAddress)
  {
    return address(exampleTemplate).predictDeterministicAddress(salt);
  }
}
