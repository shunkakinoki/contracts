// SPDX-License-Identifier: MIT

import { ENSNameResolver } from "./libs/ENSNameResolver.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
pragma solidity ^0.8.13;

contract Renderer is ENSNameResolver {
  using Strings for uint256;

  function render(string memory _owner, uint256 _rank)
    public
    pure
    returns (string memory)
  {
    string memory rankString = Strings.toString(_rank);

    return
      string.concat(
        '<svg xmlns="http://www.w3.org/2000/svg" preserveAspectRatio="xMinYMin meet" viewBox="0 0 350 350"><style>.base { fill: white; font-family: serif; font-size: 14px; }</style><rect width="100%" height="100%" fill="black" /><text x="10" y="20" class="base">Tsuji Poker Night</text><text x="10" y="40" class="base">Player:</text><text x="10" y="60" class="base">',
        _owner,
        '</text><text x="10" y="80" class="base">Rank:</text><text x="10" y="100" class="base">',
        rankString,
        "</text></svg>"
      );
  }
}
