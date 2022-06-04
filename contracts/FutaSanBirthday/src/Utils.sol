// SPDX-License-Identifier: MIT
// Code from: https://raw.githubusercontent.com/w1nt3r-eth/hot-chain-svg/main/contracts/Utils.sol

pragma solidity ^0.8.13;

// Core utils used extensively to format CSS and numbers.
library utils {
  // used to simulate empty strings
  string internal constant NULL = "";

  // converts an unsigned integer to a string
  function uint2str(uint256 _i)
    internal
    pure
    returns (string memory _uintAsString)
  {
    if (_i == 0) {
      return "0";
    }
    uint256 j = _i;
    uint256 len;
    while (j != 0) {
      len++;
      j /= 10;
    }
    bytes memory bstr = new bytes(len);
    uint256 k = len;
    while (_i != 0) {
      k = k - 1;
      uint8 temp = (48 + uint8(_i - (_i / 10) * 10));
      bytes1 b1 = bytes1(temp);
      bstr[k] = b1;
      _i /= 10;
    }
    return string(bstr);
  }
}
