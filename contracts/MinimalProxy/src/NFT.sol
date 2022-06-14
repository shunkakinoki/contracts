// SPDX-License-Identifier: MIT

pragma solidity 0.8.13;

import "@openzeppelin/contracts-upgradeable/token/ERC721/ERC721Upgradeable.sol";
import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";

contract NFT is Initializable, OwnableUpgradeable, ERC721Upgradeable {
  using Counters for Counters.Counter;
  Counters.Counter private _tokenIds;

  function initialize(
    address _owner,
    string memory _name,
    string memory _symbol
  ) public initializer {
    __Ownable_init_unchained();
    transferOwnership(_owner);
    __ERC721_init_unchained(_name, _symbol);
  }

  function mintNft(address receiver) external onlyOwner returns (uint256) {
    _tokenIds.increment();

    uint256 newNftTokenId = _tokenIds.current();
    _mint(receiver, newNftTokenId);

    return newNftTokenId;
  }
}
