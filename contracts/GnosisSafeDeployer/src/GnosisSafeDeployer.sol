// SPDX-License-Identifier: Unlicensed

pragma solidity ^0.8.13;

import "forge-std/Script.sol";
import "@gnosis.pm/safe-contracts/contracts/GnosisSafe.sol";
import "@gnosis.pm/safe-contracts/contracts/GnosisSafeL2.sol";
import "@gnosis.pm/safe-contracts/contracts/proxies/GnosisSafeProxyFactory.sol";

contract GnosisScript is Script {
  address GNOSIS_PROXY_FACTORY_ADDRESS_1_3_0 =
    address(0xa6B71E26C5e0845f74c812102Ca7114b6a896AB2);
  address GNOSIS_L1_SINGLETON_ADDRESS_1_3_0 =
    address(0xd9Db270c1B5E3Bd161E8c8503c55cEABeE709552);
  address GNOSIS_L2_SINGLETON_ADDRESS_1_3_0 =
    address(0x3E5c63644E683549055b9Be8653de26E0B4CD36E);
  address GNOSIS_COMPATIBILITY_FALLBACK_HANDLER =
    address(0xf48f2B2d2a534e402487b3ee7C18c33Aec0Fe5e4);

  address[] internal owners = new address[](1);
  GnosisSafeProxy proxy;
  GnosisSafe safe;
  GnosisSafeL2 public safeL2;

  function run() external {
    owners[0] = address(0xA5A7468f177d94212cd0FDC0886EE732155c47e9);

    GnosisSafeProxyFactory factory = GnosisSafeProxyFactory(
      GNOSIS_PROXY_FACTORY_ADDRESS_1_3_0
    );

    vm.startBroadcast();
    if (block.chainid == 1) {
      proxy = factory.createProxyWithNonce(
        GNOSIS_L1_SINGLETON_ADDRESS_1_3_0,
        abi.encodeWithSignature(
          "setup(address[],uint256,address,bytes,address,address,uint256,address)",
          owners,
          1,
          address(0),
          "",
          GNOSIS_COMPATIBILITY_FALLBACK_HANDLER,
          address(0),
          0,
          0
        ),
        123
      );
      safe = GnosisSafe(payable(address(proxy)));
    } else {
      proxy = factory.createProxyWithNonce(
        GNOSIS_L2_SINGLETON_ADDRESS_1_3_0,
        abi.encodeWithSignature(
          "setup(address[],uint256,address,bytes,address,address,uint256,address)",
          owners,
          1,
          address(0),
          "",
          GNOSIS_COMPATIBILITY_FALLBACK_HANDLER,
          address(0),
          0,
          0
        ),
        123323
      );
      safeL2 = GnosisSafeL2(payable(address(proxy)));
    }
    vm.stopBroadcast();
  }
}
