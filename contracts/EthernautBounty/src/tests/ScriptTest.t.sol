// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "forge-std/Vm.sol";

interface sNFT {
  function mint() external;
}

interface sERC20 {
  function setApprovedMinter(address, bool) external;

  function mint(address, uint256) external;
}

contract ScriptTest is DSTest {
  Vm constant cheats = Vm(HEVM_ADDRESS);

  //change
  address constant deployer = 0x11dc744F9b69b87a1eb19C3900e0fF85B6853990;

  //change
  sNFT constant nft = sNFT(0x0fd6EDC52Ed631d15fF03EeDa70103a92a819EE4);
  sERC20 constant EXP = sERC20(0xff1Bb5806eD355946295D1d6DA2BBA2696396095);

  function setUp() public {
    cheats.label(0x11dc744F9b69b87a1eb19C3900e0fF85B6853990, "deployer");
    cheats.label(0x0fd6EDC52Ed631d15fF03EeDa70103a92a819EE4, "sNFT");
    cheats.label(0xff1Bb5806eD355946295D1d6DA2BBA2696396095, "sERC20");
  }

  function nftMint() public {
    cheats.prank(deployer);
    nft.mint();
  }

  function approveEXP() public {
    cheats.prank(deployer);
    EXP.setApprovedMinter(deployer, true);
  }

  function EXPmint() public {
    cheats.prank(deployer);
    EXP.mint(deployer, 10);
  }
}
