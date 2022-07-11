// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;
import {Token} from "../src/Token.sol";

contract Example is
    Token("test", "test", 5, 5000, 555, 500, 0.2 ether, 0.1 ether, bytes32(0), "", keccak256(""))
{}
