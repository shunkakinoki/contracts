// SPDX-License-Identifier: MIT

pragma solidity ^0.8.13;

import { ERC721 } from "@rari-capital/solmate/src/tokens/ERC721.sol";

import { ERC721User } from "./ERC721User.t.sol";
import { VanityResolver } from "../../VanityResolver.sol";
import { VanityWallet } from "../../VanityWallet.sol";

contract VanityWalletUser is ERC721User {
  constructor(address resolver) ERC721User(ERC721(resolver)) {}

  function call(
    VanityWallet wallet,
    address to,
    bytes calldata data,
    uint256 value
  ) public returns (bool, bytes memory) {
    bytes memory callData = abi.encode(to, data, value);
    return address(wallet).call(callData);
  }
}
