//SPDX-License-Identifier: Unlicense

pragma solidity ^0.8.13;

interface IOKPCFont {
  error CharacterNotFound();
  error NotSingleCharacter();

  function getChar(string memory char) external view returns (string memory);

  function getChar(bytes1) external view returns (string memory);
}
