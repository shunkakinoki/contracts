// SPDX-License-Identifier: MIT

pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../FutaSanBirthdayScript.sol";

contract GreeterTest is Test {
  FutaSanBirthdayScript private script;

  function setUp() public {
    script = new FutaSanBirthdayScript();
    script.run();
  }

  function testGreetIsHelloWorld() public {
    vm.warp(1654309451);
    assertEq(
      script.nft().ownerOf(1),
      address(0xe7236c912945C8B915c7C60b55e330b959801B45)
    );
    assertEq(
      script.nft().balanceOf(
        address(0xe7236c912945C8B915c7C60b55e330b959801B45)
      ),
      1
    );
    assertEq(
      script.nft().tokenURI(1),
      "data:application/json;base64,eyJuYW1lIjoiRnV0YS1zYW4gMjd0aCBCaXJ0aGRheSIsImltYWdlIjoiZGF0YTppbWFnZS9zdmcreG1sO2Jhc2U2NCxQSE4yWnlCNGJXeHVjejBpYUhSMGNEb3ZMM2QzZHk1M015NXZjbWN2TWpBd01DOXpkbWNpSUhkcFpIUm9QU0kwTURBaUlHaGxhV2RvZEQwaU5EQXdJaUJ6ZEhsc1pUMGlZbUZqYTJkeWIzVnVaRG9qTURBd0lqNDhkR1Y0ZENCNFBTSTJOU0lnZVQwaU1UWXdJaUJtYjI1MExYTnBlbVU5SWpNd0lpQm1hV3hzUFNKM2FHbDBaU0lnUGp3aFcwTkVRVlJCVzBaMWRHRXRjMkZ1SURJM2RHZ2dRbWx5ZEdoa1lYbGRYVDQ4TDNSbGVIUStQSEpsWTNRZ1ptbHNiRDBpY21Wa0lpQjRQU0kyTlNJZ2VUMGlNakF3SWlCM2FXUjBhRDBpTWpjd0lpQm9aV2xuYUhROUlqRXlJaUErUEM5eVpXTjBQangwWlhoMElIZzlJakV4TlNJZ2VUMGlNall3SWlCbWIyNTBMWE5wZW1VOUlqRTRJaUJtYVd4c1BTSjNhR2wwWlNJZ1Bqd2hXME5FUVZSQlcxUnBiV1VnYkdWbWREb2dYVjArTVRZMU5ETXdPVFExTVR3dmRHVjRkRDQ4TDNOMlp6ND0iLCAiZGVzY3JpcHRpb24iOiAiRnV0YS1zYW4gQmlydGhkYXkgTmlnaHQgaW4gU2FuIEZyYW5jaXNjbyBvbiAyMDIyLzA2LzAzIn0="
    );
  }
}
