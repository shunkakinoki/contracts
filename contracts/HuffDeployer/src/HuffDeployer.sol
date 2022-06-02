// SPDX-License-Identifier: MIT

pragma solidity ^0.8.13;
import "forge-std/Test.sol";

contract HuffDeployer is Test {
  function deployContract() public returns (string memory) {
    string[] memory inputs = new string[](3);
    inputs[0] = "echo";
    inputs[1] = "-n";
    inputs[
      2
    ] = "0x00000000000000000000000000000000000000000000000000000000000000200000000000000000000000000000000000000000000000000000000000000002676d000000000000000000000000000000000000000000000000000000000000";

    bytes memory res = vm.ffi(inputs);
    string memory output = abi.decode(res, (string));

    return output;
  }
}
