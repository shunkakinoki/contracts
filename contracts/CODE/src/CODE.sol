// SPDX-License-Identifier: MIT
// Code from: https://github.com/Developer-DAO/code-claim-site/blob/main/packages/hardhat/src/CODE.sol

pragma solidity ^0.8.13;

import "@openzeppelin/contracts/access/AccessControl.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/draft-ERC20Permit.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";

contract CODE is ERC20, ERC20Permit, AccessControl, ERC20Burnable {
  bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");

  constructor() ERC20("Developer DAO", "CODE") ERC20Permit("Developer DAO") {
    _setupRole(DEFAULT_ADMIN_ROLE, _msgSender());
    _mint(_msgSender(), 10_000_000 * 1e18);
  }

  function mint(address _to, uint256 _amount) external onlyRole(MINTER_ROLE) {
    _mint(_to, _amount);
  }
}
