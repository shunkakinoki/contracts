//SPDX-License-Identifier: Unlicense

pragma solidity ^0.8.13;

import { IOKPC } from "./IOKPC.sol";

interface IOKPCGenesisArtwork {
  function getGenesisArtwork(uint256)
    external
    view
    returns (uint256, IOKPC.Art memory);
}
