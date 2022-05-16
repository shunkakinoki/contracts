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
    assertEq(id, 0);
  }

  function testAddressIdOne() public {
    uint256 id = renderer.getAddressId(address(1));
    console2.logBytes32(bytes32(id));
    assertEq(id, 1);
  }

  function testAddressIdTwo() public {
    uint256 id = renderer.getAddressId(address(2));
    console2.logBytes32(bytes32(id));
    assertEq(id, 2);
  }

  function testAddressIdThree() public {
    uint256 id = renderer.getAddressId(address(3));
    console2.logBytes32(bytes32(id));
    assertEq(id, 3);
  }

  function testAddressIdFour() public {
    uint256 id = renderer.getAddressId(address(4));
    console2.logBytes32(bytes32(id));
    assertEq(id, 4);
  }

  function testAddressIdFive() public {
    uint256 id = renderer.getAddressId(address(5));
    console2.logBytes32(bytes32(id));
    assertEq(id, 5);
  }

  function testAddressIdSix() public {
    uint256 id = renderer.getAddressId(address(6));
    console2.logBytes32(bytes32(id));
    assertEq(id, 6);
  }

  function testAddressIdSeven() public {
    uint256 id = renderer.getAddressId(address(7));
    console2.logBytes32(bytes32(id));
    assertEq(id, 7);
  }

  function testAddressIdEight() public {
    uint256 id = renderer.getAddressId(address(8));
    console2.logBytes32(bytes32(id));
    assertEq(id, 8);
  }

  function testAddressIdNine() public {
    uint256 id = renderer.getAddressId(address(9));
    console2.logBytes32(bytes32(id));
    assertEq(id, 9);
  }

  function testAddressIdTen() public {
    uint256 id = renderer.getAddressId(address(10));
    console2.logBytes32(bytes32(id));
    assertEq(id, 10);
  }

  function testAddressIdEleven() public {
    uint256 id = renderer.getAddressId(address(11));
    console2.logBytes32(bytes32(id));
    assertEq(id, 11);
  }

  function testAddressIdTwelve() public {
    uint256 id = renderer.getAddressId(address(12));
    console2.logBytes32(bytes32(id));
    assertEq(id, 12);
  }

  function testAddressIdThirteen() public {
    uint256 id = renderer.getAddressId(address(13));
    console2.logBytes32(bytes32(id));
    assertEq(id, 0);
  }

  function testAddressIdFourteen() public {
    uint256 id = renderer.getAddressId(address(14));
    console2.logBytes32(bytes32(id));
    assertEq(id, 1);
  }

  function testAddressIdFifthteen() public {
    uint256 id = renderer.getAddressId(address(15));
    console2.logBytes32(bytes32(id));
    assertEq(id, 2);
  }

  function testAddressIdA() public {
    uint256 id = renderer.getAddressId(
      0x000000000000000000000000000000000000000A
    );
    console2.logUint(id);
    assertEq(id, 10);
  }

  function testAddressIdB() public {
    uint256 id = renderer.getAddressId(
      0x000000000000000000000000000000000000000b
    );
    console2.logUint(id);
    assertEq(id, 11);
  }

  function testAddressIdC() public {
    uint256 id = renderer.getAddressId(
      0x000000000000000000000000000000000000000C
    );
    console2.logUint(id);
    assertEq(id, 12);
  }

  function testAddressIdD() public {
    uint256 id = renderer.getAddressId(
      0x000000000000000000000000000000000000000d
    );
    console2.logUint(id);
    assertEq(id, 0);
  }

  function testAddressIdE() public {
    uint256 id = renderer.getAddressId(
      0x000000000000000000000000000000000000000E
    );
    console2.logUint(id);
    assertEq(id, 1);
  }

  function testAddressIdF() public {
    uint256 id = renderer.getAddressId(
      0x000000000000000000000000000000000000000F
    );
    console2.logUint(id);
    assertEq(id, 2);
  }

  function testAddressIdLong() public {
    uint256 id = renderer.getAddressId(
      0x1111111111111111111111111111111111111111
    );
    console2.logUint(id);
    assertEq(id, 1);
  }

  function testRenderAddressZero() public {
    string memory svg = renderer.render(address(0));
    console2.logString(svg);
    assertEq(
      svg,
      '<svg width="300" height="300" viewBox="0 0 48 48" fill="none" xmlns="http://www.w3.org/2000/svg"><circle cx="24" cy="24" r="24" fill="url(#r)"/><defs><radialGradient id="r" cx="0" cy="0" r="1" gradientUnits="userSpaceOnUse" gradientTransform="translate(38 24) rotate(180) scale(38 39.1805)"><stop stop-color="#3d505c"/><stop offset="0.670535" stop-color="#101417"/><stop offset="0.950763" stop-color="#6b7280"/><stop offset="1" stop-color="#e5e7eb"/></radialGradient></defs></svg>'
    );
  }

  function testRenderAddressOne() public {
    string memory svg = renderer.render(address(1));
    console2.logString(svg);
    assertEq(
      svg,
      '<svg width="300" height="300" viewBox="0 0 48 48" fill="none" xmlns="http://www.w3.org/2000/svg"><circle cx="24" cy="24" r="24" fill="url(#r)"/><defs><radialGradient id="r" cx="0" cy="0" r="1" gradientUnits="userSpaceOnUse" gradientTransform="translate(38 24) rotate(180) scale(38 39.1805)"><stop stop-color="#3d505c"/><stop offset="0.670535" stop-color="#101417"/><stop offset="0.950763" stop-color="#ef4444"/><stop offset="1" stop-color="#ef4444"/></radialGradient></defs></svg>'
    );
  }

  function testRenderAddressTwo() public {
    string memory svg = renderer.render(address(2));
    console2.logString(svg);
    assertEq(
      svg,
      '<svg width="300" height="300" viewBox="0 0 48 48" fill="none" xmlns="http://www.w3.org/2000/svg"><circle cx="24" cy="24" r="24" fill="url(#r)"/><defs><radialGradient id="r" cx="0" cy="0" r="1" gradientUnits="userSpaceOnUse" gradientTransform="translate(38 24) rotate(180) scale(38 39.1805)"><stop stop-color="#3d505c"/><stop offset="0.670535" stop-color="#101417"/><stop offset="0.950763" stop-color="#f97316"/><stop offset="1" stop-color="#fed7aa"/></radialGradient></defs></svg>'
    );
  }
}
