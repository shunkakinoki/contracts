// SPDX-License-Identifier: MIT

pragma solidity ^0.8.13;

import { Private } from "../Private.sol";

import "forge-std/Test.sol";

contract PrivateTest is Test {
  uint256 testNumber;
  Private private privateContract;
  address receiver = address(1);

  function setUp() public {
    vm.prank(address(receiver), address(receiver));
    privateContract = new Private(bytes32("password"));
    privateContract.addUser(bytes32("AAABBBCCC"));
    privateContract.addUser(bytes32("DDDEEEFFF"));
  }

  function testStoargeSlot0() public {
    bytes32 one = vm.load(address(privateContract), bytes32(uint256(0)));
    assertEq(one, bytes32(uint256(123)));
  }

  function testStoargeSlot1() public {
    bytes32 two = vm.load(address(privateContract), bytes32(uint256(1)));
    assertEq(
      two,
      // msg.sender is the address of the sender of the transaction
      // 0000000000000000000000000000000000000001 is the address of the sender
      // 01 is the boolean value of true
      // 1f is the uint16 value of 31
      bytes32(
        0x000000000000000000001f010000000000000000000000000000000000000001
      )
    );
  }

  function testStoargeSlot2() public {
    bytes32 three = vm.load(address(privateContract), bytes32(uint256(2)));
    // slot 2 equals the bytes32 value of password
    assertEq(three, bytes32("password"));
  }

  function testStoargeSlot3() public {
    bytes32 four = vm.load(address(privateContract), bytes32(uint256(3)));
    assertEq(four, bytes32(uint256(0)));
  }

  function testStoargeSlot4() public {
    bytes32 four = vm.load(address(privateContract), bytes32(uint256(4)));
    assertEq(four, bytes32(uint256(0)));
  }

  function testStoargeSlot5() public {
    bytes32 five = vm.load(address(privateContract), bytes32(uint256(5)));
    assertEq(five, bytes32(uint256(0)));
  }

  function testStoargeSlot6() public {
    bytes32 six = vm.load(address(privateContract), bytes32(uint256(6)));
    assertEq(six, bytes32(uint256(2)));
  }

  function testStoargeSlot6Hash1() public {
    bytes32 result;
    bytes32 encoded = keccak256(abi.encode(6));
    assembly {
      // increment slot by 1
      result := add(encoded, 1)
    }
    bytes32 six = vm.load(address(privateContract), result);
    // bytes32 password of the first user is "first user"
    assertEq(six, bytes32("AAABBBCCC"));
  }

  function testStoargeSlot6Hash2() public {
    bytes32 result;
    bytes32 encoded = keccak256(abi.encode(6));
    assembly {
      // increment slot by 2
      result := add(encoded, 2)
    }
    bytes32 six = vm.load(address(privateContract), result);
    // id for the first user is 0
    assertEq(six, bytes32(uint256(1)));
  }

  function testStoargeSlot6Hash3() public {
    bytes32 result;
    bytes32 encoded = keccak256(abi.encode(6));
    assembly {
      //increment slot by 3
      result := add(encoded, 3)
    }
    bytes32 six = vm.load(address(privateContract), result);
    // bytes32 password of the first user is "first user"
    assertEq(six, bytes32("DDDEEEFFF"));
  }

  function testStoargeSlot7() public {
    bytes32 seven = vm.load(address(privateContract), bytes32(uint256(7)));
    assertEq(seven, bytes32(uint256(0)));
  }

  function testStoargeSlot7Hash0() public {
    bytes32 encoded = keccak256(abi.encode(1, 7));
    bytes32 seven = vm.load(address(privateContract), encoded);
    assertEq(seven, bytes32(uint256(1)));
  }

  function testStoargeSlot7Key0Hash1() public {
    bytes32 result;
    bytes32 encoded = keccak256(abi.encode(0, 7));
    assembly {
      //increment slot by 1
      result := add(encoded, 1)
    }
    bytes32 seven = vm.load(address(privateContract), result);
    assertEq(seven, bytes32("AAABBBCCC"));
  }

  function testStoargeSlot7Key0Hash2() public {
    bytes32 result;
    bytes32 encoded = keccak256(abi.encode(0, 7));
    assembly {
      //increment slot by 2
      result := add(encoded, 2)
    }
    bytes32 seven = vm.load(address(privateContract), encoded);
    assertEq(seven, bytes32(uint256(0)));
  }

  function testStoargeSlot7Key1Hash1() public {
    bytes32 result;
    bytes32 encoded = keccak256(abi.encode(1, 7));
    assembly {
      //increment slot by 1
      result := add(encoded, 1)
    }
    bytes32 seven = vm.load(address(privateContract), result);
    assertEq(seven, bytes32("DDDEEEFFF"));
  }

  function testStoargeSlot7Key1Hash2() public {
    bytes32 result;
    bytes32 encoded = keccak256(abi.encode(1, 7));
    assembly {
      //increment slot by 2
      result := add(encoded, 2)
    }
    bytes32 seven = vm.load(address(privateContract), encoded);
    assertEq(seven, bytes32(uint256(1)));
  }
}
