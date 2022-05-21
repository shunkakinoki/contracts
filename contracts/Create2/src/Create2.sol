// SPDX-License-Identifier: MIT
// Code from: https://solidity-by-example.org/app/create2

pragma solidity ^0.8.13;

import "hardhat/console.sol";

contract DeployWithCreate2 {
  address public owner;

  constructor(address _owner) {
    owner = _owner;
  }
}

contract Create2Factory {
  event Deploy(address addr);

  function deploy(uint256 _salt) external {
    DeployWithCreate2 _contract = new DeployWithCreate2{ salt: bytes32(_salt) }(
      msg.sender
    );
    emit Deploy(address(_contract));
  }

  function getBytecode(address _owner, uint256 _foo)
    public
    pure
    returns (bytes memory)
  {
    bytes memory bytecode = type(DeployWithCreate2).creationCode;

    return abi.encodePacked(bytecode, abi.encode(_owner, _foo));
  }

  // 2. Compute the address of the contract to be deployed
  // NOTE: _salt is a random number used to create an address
  function getAddress(bytes memory bytecode, uint256 _salt)
    public
    view
    returns (address)
  {
    bytes32 hash = keccak256(
      abi.encodePacked(bytes1(0xff), address(this), _salt, keccak256(bytecode))
    );

    // NOTE: cast last 20 bytes of hash to address
    return address(uint160(uint256(hash)));
  }
}
