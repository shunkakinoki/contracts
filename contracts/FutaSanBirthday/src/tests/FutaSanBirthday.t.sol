// SPDX-License-Identifier: MIT

pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import { FutaSanBirthday } from "../FutaSanBirthday.sol";

contract FutaSanBirthdayTest is Test {
  FutaSanBirthday nft;
  address kaki = address(0x4fd9D0eE6D6564E80A9Ee00c0163fC952d0A45Ed);

  function setUp() public {
    nft = new FutaSanBirthday();
  }

  function testMint() public {
    vm.deal(kaki, 1 ether);
    vm.warp(1654309451);
    vm.prank(kaki);
    nft.mint{ value: 0.01 ether }();
    assertEq(nft.ownerOf(1), kaki);
    assertEq(
      nft.tokenURI(1),
      "data:application/json;base64,eyJuYW1lIjoiRnV0YS1zYW4gMjd0aCBCaXJ0aGRheSIsImltYWdlIjoiZGF0YTppbWFnZS9zdmcreG1sO2Jhc2U2NCxQSE4yWnlCNGJXeHVjejBpYUhSMGNEb3ZMM2QzZHk1M015NXZjbWN2TWpBd01DOXpkbWNpSUhkcFpIUm9QU0kwTURBaUlHaGxhV2RvZEQwaU5EQXdJaUJ6ZEhsc1pUMGlZbUZqYTJkeWIzVnVaRG9qTURBd0lqNDhkR1Y0ZENCNFBTSTJOU0lnZVQwaU1UWXdJaUJtYjI1MExYTnBlbVU5SWpNd0lpQm1hV3hzUFNKM2FHbDBaU0lnUGp3aFcwTkVRVlJCVzBaMWRHRXRjMkZ1SURJM2RHZ2dRbWx5ZEdoa1lYbGRYVDQ4TDNSbGVIUStQSEpsWTNRZ1ptbHNiRDBpY21Wa0lpQjRQU0kyTlNJZ2VUMGlNakF3SWlCM2FXUjBhRDBpTWpjd0lpQm9aV2xuYUhROUlqRXlJaUErUEM5eVpXTjBQangwWlhoMElIZzlJakV4TlNJZ2VUMGlNall3SWlCbWIyNTBMWE5wZW1VOUlqRTRJaUJtYVd4c1BTSjNhR2wwWlNJZ1Bqd2hXME5FUVZSQlcxUnBiV1VnYkdWbWREb2dYVjArTVRZMU5ETXdPVFExTVR3dmRHVjRkRDQ4TDNOMlp6ND0iLCAiZGVzY3JpcHRpb24iOiAiRnV0YS1zYW4gQmlydGhkYXkgTmlnaHQgaW4gU2FuIEZyYW5jaXNjbyBvbiAyMDIyLzA2LzAzIn0="
    );
  }
}
