// SPDX-License-Identifier: MIT
// Code from: https://github.com/johncpalmer/LevelNFT

pragma solidity ^0.8.13;

import "./ILevelChecker.sol";
import "solmate/src/tokens/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "base64-sol/base64.sol";

contract LevelNFT is ERC721, Ownable {
  // Level numbers auto-increment as they are added by the contract owner.
  uint256 public latestLevel;

  // Mapping from level numbers to addresses of their implementations.
  mapping(uint256 => ILevelChecker) public levels;

  // Mapping from level number to how many points it's worth to complete it.
  mapping(uint256 => uint256) public levelValues;

  // Keeps track of the levels beaten by a given tokenId, while owned by a specific address.
  // This allows a previous owner of a token ID to resume if they get the token back.
  mapping(bytes32 => mapping(uint256 => bool)) public levelsBeatenByTokenKey;

  // The current score of each key, how many levels a token ID and owner pair has beaten.
  mapping(bytes32 => uint256) public scoreByKey;

  constructor() ERC721("LevelNFT", "LNFT") {
    latestLevel = 1;
  }

  // Generate a unique key based on tokenId + owner address.
  function getKey(uint256 tokenId, address owner)
    internal
    pure
    returns (bytes32)
  {
    return keccak256(abi.encodePacked(tokenId, owner));
  }

  function getScore(uint256 tokenId) internal view returns (uint256) {
    return scoreByKey[getKey(tokenId, ownerOf(tokenId))];
  }

  // Allows the owner of the contract to add new levels.
  function addLevel(address levelAddress, uint256 levelValue) public onlyOwner {
    levels[latestLevel] = ILevelChecker(levelAddress);
    levelValues[latestLevel] = levelValue;
    latestLevel++;
  }

  // Helper function to check if this token ID has previously beaten a level.
  function hasTokenIdBeatenLevel(uint256 tokenId, uint256 level)
    public
    view
    returns (bool)
  {
    bytes32 key = getKey(tokenId, ownerOf(tokenId));
    return levelsBeatenByTokenKey[key][level];
  }

  // Function to beat a level. If successful, adds to this token's score and tracks as beaten by this owner + tokenID.
  function beatLevel(
    uint256 level,
    uint256 tokenId,
    bytes memory userData
  ) public returns (bool) {
    // Only the owner can call the function to beat the level.
    require(ownerOf(tokenId) == msg.sender);

    ILevelChecker _level = ILevelChecker(levels[level]);

    if (_level.isCompleted(msg.sender, userData)) {
      // Make sure this user has not already beaten this level with this tokenId;
      require(!hasTokenIdBeatenLevel(tokenId, level));

      // Mark this level as completed by this token ID.
      bytes32 key = getKey(tokenId, msg.sender);
      levelsBeatenByTokenKey[key][level] = true;

      // Increase this token's score.
      scoreByKey[getKey(tokenId, ownerOf(tokenId))] += levelValues[level];
      return true;
    }
    return false;
  }

  function generateSVG(uint256 tokenId)
    internal
    view
    returns (bytes memory svg)
  {
    svg = abi.encodePacked(
      '<svg xmlns="http://www.w3.org/2000/svg" preserveAspectRatio="xMinYMin meet" viewBox="0 0 350 350"><style>.base { fill: white; font-family: serif; font-size: 14px; }</style><rect width="100%" height="100%" fill="black" /><text x="10" y="20" class="base">"',
      scoreByKey[getKey(tokenId, ownerOf(tokenId))],
      '"</text></svg>'
    );
  }

  function tokenURI(uint256 tokenId)
    public
    view
    override
    returns (string memory)
  {
    return
      string(
        abi.encodePacked(
          "data:application/json;base64,",
          Base64.encode(
            bytes(
              abi.encodePacked(
                '{"name":"LevelNFT",',
                '"image":"data:image/svg+xml;base64,',
                Base64.encode(bytes(generateSVG(tokenId))),
                '", "description": "NFT that can beat levels.",',
                '"score": "',
                scoreByKey[getKey(tokenId, ownerOf(tokenId))],
                '"}'
              )
            )
          )
        )
      );
  }
}
