// SPDX-License-Identifier: MIT

pragma solidity ^0.8.13;

import "@openzeppelin/contracts/utils/math/SafeMath.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";

import "./IFlashLoanReceiver.sol";
import "./ILendingPoolAddressProvider.sol";
import "./ILendingPool.sol";

abstract contract FlashLoanReceiverBase is IFlashLoanReceiver {
  using SafeERC20 for IERC20;
  using SafeMath for uint256;

  // solhint-disable-next-line var-name-mixedcase
  ILendingPoolAddressesProvider public immutable ADDRESSES_PROVIDER;
  // solhint-disable-next-line var-name-mixedcase
  ILendingPool public immutable LENDING_POOL;

  constructor(ILendingPoolAddressesProvider provider) {
    ADDRESSES_PROVIDER = provider;
    LENDING_POOL = ILendingPool(provider.getLendingPool());
  }
}
