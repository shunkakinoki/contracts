// SPDX-License-Identifier: MIT
pragma solidity ^0.8.6;

import "ds-test/test.sol";
import "forge-std/console2.sol";

import { VanityResolver } from "../VanityResolver.sol";

import { VanityWalletUser } from "./utils/VanityWalletUser.t.sol";
import { ExampleContract } from "./utils/ExampleContract.t.sol";

contract VanityResolverTest is DSTest {
  VanityResolver resolver;
  VanityWalletUser user;
  ExampleContract exampleContract;

  function setUp() public {
    resolver = new VanityResolver();
    user = new VanityWalletUser(address(resolver));
    exampleContract = new ExampleContract();
  }

  function testMint() public {
    resolver.mint(bytes32(0));
  }

  function testFailMintDuplicateSalt() public {
    resolver.mint(bytes32(0));
    resolver.mint(bytes32(0));
  }

  function testExpectedMintAddress() public {
    bytes32 salt = bytes32(uint256(10));

    address expected = resolver.getExpectedAddress(salt);
    address actual = address(resolver.mint(salt));

    assertEq(actual, expected);
  }

  function testTotalSupply() public {
    resolver.mint(hex"ffffffff");
    assertEq(resolver.totalSupply(), 1);
  }

  function testOwnership() public {
    resolver.mint(bytes32(0));

    assertEq(resolver.ownerOf(0), address(this));
  }

  function testTransferAndCall() public {
    resolver.mint(bytes32(0));

    resolver.transferFrom(address(this), address(user), 0);

    bytes memory data = abi.encodeWithSelector(
      ExampleContract.testStore.selector,
      12002
    );
    user.call(resolver.idToVanity(0), address(exampleContract), data, 0);
  }

  function testSafeTransferAndCall() public {
    resolver.mint(bytes32(0));

    resolver.safeTransferFrom(address(this), address(user), 0);

    bytes memory data = abi.encodeWithSelector(
      ExampleContract.testStore.selector,
      12002
    );
    user.call(resolver.idToVanity(0), address(exampleContract), data, 0);
  }

  function testTransferAndCallNotOwner() public {
    resolver.mint(bytes32(0));

    resolver.transferFrom(address(this), address(user), 0);

    bytes memory data = abi.encodeWithSelector(
      ExampleContract.testStore.selector,
      12002
    );
    bytes memory callData = abi.encode(address(exampleContract), data, 0);
    (bool success, ) = address(resolver.idToVanity(0)).call(callData);
    assertTrue(!success);
  }

  /// cmd: forge test -c contracts/VanityResolver --match-test testMineVanity -vvvvv
  function testMineVanity() public {
    bytes memory bytecode = resolver.getVanityCreationCode();
    for (uint256 i = 1; ; i++) {
      address vanity = address(
        uint160(
          uint256(
            keccak256(
              abi.encodePacked(
                hex"ff",
                address(resolver),
                bytes32(i),
                keccak256(bytecode)
              )
            )
          )
        )
      );

      console2.logAddress(vanity);

      bytes1 firstByte = bytes20(vanity)[0];
      bytes1 secondByte = bytes20(vanity)[1];
      if (firstByte == hex"00" && secondByte == hex"00") {
        emit log_named_address("Found Vanity", vanity);
        emit log_named_bytes32("salt", bytes32(i));
        return;
      }
    }
  }

  function testExpectedMintAddressZero() public {
    bytes32 salt = bytes32(
      0x000000000000000000000000000000000000000000000000000000000000faf3
    );

    address expected = resolver.getExpectedAddress(salt);
    console2.logAddress(expected);
    address actual = address(resolver.mint(salt));

    assertEq(actual, expected);
  }
}
