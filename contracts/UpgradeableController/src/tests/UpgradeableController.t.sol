// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/proxy/transparent/ProxyAdmin.sol";
import "@openzeppelin/contracts/proxy/transparent/TransparentUpgradeableProxy.sol";
import "../ControllerV1.sol";
import "../ControllerV4.sol";
import "ds-test/test.sol";

contract OZUpgradeTest is DSTest {
  ControllerV1 controllerV1;
  ControllerV4 controllerV4;
  TransparentUpgradeableProxy transparentProxy;
  ProxyAdmin proxyAdmin;

  ControllerV4 latestController;

  function setUp() public {
    controllerV1 = new ControllerV1();

    controllerV4 = new ControllerV4();

    transparentProxy = new TransparentUpgradeableProxy(
      address(controllerV1),
      address(this),
      ""
    );

    proxyAdmin = new ProxyAdmin();

    transparentProxy.changeAdmin(address(proxyAdmin));

    ControllerV1(address(transparentProxy)).initialize(
      address(this),
      address(this),
      address(this)
    );

    proxyAdmin.upgrade(transparentProxy, address(controllerV4));

    latestController = ControllerV4(address(transparentProxy));
  }

  function testControllerDeploy() public {
    address admin = latestController.admin();
    uint256 version = latestController.getVersion();
    assertEq(version, 4);
    assertEq(admin, address(this));
  }
}
