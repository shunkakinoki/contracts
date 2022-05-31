// SPDX-License-Identifier: The Unlicense

pragma solidity ^0.8.13;

import "./IShields.sol";

/// @dev Generate ShieldBadge SVG
interface IShieldBadgeSVGs {
  function generateShieldBadgeSVG(IShields.ShieldBadge shieldBadge)
    external
    view
    returns (string memory);
}
