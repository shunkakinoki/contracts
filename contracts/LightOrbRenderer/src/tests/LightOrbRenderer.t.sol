// SPDX-License-Identifier: MIT

pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../Renderer.sol";

contract LightOrbRendererTest is Test {
  Renderer private renderer;

  function setUp() public {
    renderer = new Renderer();
  }

  function testAddressIdZero() public {
    uint256 id = renderer.getAddressId(address(0));
    console2.logBytes32(bytes32(id));
    assertEq(bytes32(id), bytes32(0));
  }

  function testAddressIdOne() public {
    uint256 id = renderer.getAddressId(address(1));
    console2.logBytes32(bytes32(id));
    assertEq(bytes32(id), bytes32(uint256(1)));
  }

  function testAddressIdTwo() public {
    uint256 id = renderer.getAddressId(address(2));
    console2.logBytes32(bytes32(id));
    assertEq(bytes32(id), bytes32(uint256(2)));
  }

  function testAddressIdThree() public {
    uint256 id = renderer.getAddressId(address(3));
    console2.logBytes32(bytes32(id));
    assertEq(bytes32(id), bytes32(uint256(3)));
  }

  function testAddressIdFour() public {
    uint256 id = renderer.getAddressId(address(4));
    console2.logBytes32(bytes32(id));
    assertEq(bytes32(id), bytes32(uint256(4)));
  }

  function testAddressIdFive() public {
    uint256 id = renderer.getAddressId(address(5));
    console2.logBytes32(bytes32(id));
    assertEq(bytes32(id), bytes32(uint256(5)));
  }

  function testAddressIdSix() public {
    uint256 id = renderer.getAddressId(address(6));
    console2.logBytes32(bytes32(id));
    assertEq(bytes32(id), bytes32(uint256(6)));
  }

  function testAddressIdSeven() public {
    uint256 id = renderer.getAddressId(address(7));
    console2.logBytes32(bytes32(id));
    assertEq(bytes32(id), bytes32(uint256(7)));
  }

  function testAddressIdEight() public {
    uint256 id = renderer.getAddressId(address(8));
    console2.logBytes32(bytes32(id));
    assertEq(bytes32(id), bytes32(uint256(8)));
  }

  function testAddressIdNine() public {
    uint256 id = renderer.getAddressId(address(9));
    console2.logBytes32(bytes32(id));
    assertEq(bytes32(id), bytes32(uint256(9)));
  }

  function testAddressIdTen() public {
    uint256 id = renderer.getAddressId(address(10));
    console2.logBytes32(bytes32(id));
    assertEq(bytes32(id), bytes32(uint256(0)));
  }

  function testAddressIdEleven() public {
    uint256 id = renderer.getAddressId(address(11));
    console2.logBytes32(bytes32(id));
    assertEq(bytes32(id), bytes32(uint256(1)));
  }

  function testAddressIdTwelve() public {
    uint256 id = renderer.getAddressId(address(12));
    console2.logBytes32(bytes32(id));
    assertEq(bytes32(id), bytes32(uint256(2)));
  }
}
