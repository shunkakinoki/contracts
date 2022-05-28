// SPDX-License-Identifier: MIT

pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import { SimpleAuction } from "../SimpleAuction.sol";

contract User {}

contract SimpleAuctionTest is Test {
  SimpleAuction private auction;
  address internal userA = address(1);
  address internal userB = address(2);

  function setUp() public {
    auction = new SimpleAuction(300, payable(address(3)));
    console.log(block.timestamp);
  }

  function testBid() public {
    auction.bid{ value: 3 }();
  }

  function testBidContinuous() public {
    auction.bid{ value: 4 }();
    auction.bid{ value: 5 }();
    auction.bid{ value: 6 }();
  }
}
