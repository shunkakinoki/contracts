// SPDX-License-Identifier: MIT

pragma solidity ^0.8.13;

import { VanityResolver } from "./VanityResolver.sol";

error NotVanityOwner();
error VanityCallError(bytes);

contract VanityWallet {
  address internal immutable resolver;
  address public owner;

  constructor(address _resolver) {
    resolver = _resolver;
  }

  function setOwner(address _owner) public {
    require(msg.sender == resolver);
    owner = _owner;
  }

  // prettier-ignore
  fallback(bytes calldata callData) external payable returns(bytes memory) {
    (address to, bytes memory data, uint256 value) = abi.decode(
      callData,
      (address, bytes, uint256)
    );

    if (msg.sender != owner) revert NotVanityOwner();

    (bool success, bytes memory returnData) = to.call{ value: value }(data);
    if (!success) revert VanityCallError(returnData);
    return returnData;
  }

  receive() external payable {}
}
