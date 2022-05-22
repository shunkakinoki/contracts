// SPDX-License-Identifier: MIT

pragma solidity ^0.8.13;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

import "forge-std/console2.sol";

/// @title Wagumi Token
/// @author Shun Kakinoki
/// @notice A RFC proposal for a token that can be used to mint for Wagumi DAO.
contract WagumiToken is ERC20, ERC20Burnable, Ownable {
  /* -------------------------------------------------------------------------- */
  /*                                   CONFIG                                   */
  /* -------------------------------------------------------------------------- */
  uint8 MAX_MINTABLE_PERCENTAGE = 10;
  /* --------------------------------- ****** --------------------------------- */

  /* -------------------------------------------------------------------------- */
  /*                                   EVENTS                                   */
  /* -------------------------------------------------------------------------- */
  error MaxMintableExceeded();

  /* --------------------------------- ****** --------------------------------- */

  constructor() ERC20("Wagumi DAO", "WAGUMI") {
    _mint(_msgSender(), 10_000_000 * 1e18);
  }

  /* -------------------------------------------------------------------------- */
  /*                                   ADMIN                                    */
  /* -------------------------------------------------------------------------- */

  /// @notice Allows owner to mint a number of tokens to a given address
  /// @param _to The address to send the minted tokens to
  function mint(address _to, uint256 _amount) external onlyOwner {
    if (_amount > ((MAX_MINTABLE_PERCENTAGE * totalSupply()) / 100)) {
      revert MaxMintableExceeded();
    }
    _mint(_to, _amount);
  }

  /// @notice Allows owner to set a percentage of total supply that can be minted at once
  /// @param _percentage The percentage in whole numbers
  function setPercentage(uint8 _percentage) external onlyOwner {
    MAX_MINTABLE_PERCENTAGE = _percentage;
  }

  /* -------------------------------------------------------------------------- */
  /*                                   PUBLIC                                   */
  /* -------------------------------------------------------------------------- */

  /// @notice Allows
  function getPercentage() external view returns (uint8) {
    return MAX_MINTABLE_PERCENTAGE;
  }
}
