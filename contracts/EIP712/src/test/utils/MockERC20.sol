// SPDX-License-Identifier: UNLICENSED

pragma solidity 0.8.13;

import { ERC20 } from "solmate/src/tokens/ERC20.sol";

contract MockERC20 is ERC20 {
  constructor() ERC20("Mock Token", "MOCK", 18) {}

  function mint(address _to, uint256 _amount) public {
    _mint(_to, _amount);
  }
}
