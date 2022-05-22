// SPDX-License-Identifier: MIT

pragma solidity ^0.8.13;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract WagumiToken is ERC20, ERC20Burnable, Ownable {
  constructor() ERC20("Wagumi DAO", "WAGUMI") {
    _mint(_msgSender(), 10_000_000 * 1e18);
  }

  function mint(address _to, uint256 _amount) external onlyOwner {
    _mint(_to, _amount);
  }
}
