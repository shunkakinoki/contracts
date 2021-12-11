// SPDX-License-Identifier: MIT

pragma solidity ^0.8.4;

import "@openzeppelin/contracts/security/ReentrancyGuard.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract KiyoSanBirthday is ERC721, ReentrancyGuard, Ownable {
  using Counters for Counters.Counter;

  constructor(string memory customBaseURI_)
    ERC721("Kiyo-san Birthday 2021", "0xKiyo")
  {
    customBaseURI = customBaseURI_;
  }

  mapping(address => uint256) private mintCountMap;

  mapping(address => uint256) private allowedMintCountMap;

  uint256 public constant MINT_LIMIT_PER_WALLET = 1;

  function allowedMintCount(address minter) public view returns (uint256) {
    return MINT_LIMIT_PER_WALLET - mintCountMap[minter];
  }

  function updateMintCount(address minter, uint256 count) private {
    mintCountMap[minter] += count;
  }

  uint256 public constant MAX_SUPPLY = 27;

  Counters.Counter private supplyCounter;

  function mint() public nonReentrant {
    if (allowedMintCount(_msgSender()) >= 1) {
      updateMintCount(_msgSender(), 1);
    } else {
      revert("Minting limit exceeded");
    }

    require(totalSupply() < MAX_SUPPLY, "Exceeds max supply");

    _safeMint(_msgSender(), totalSupply());

    supplyCounter.increment();
  }

  function totalSupply() public view returns (uint256) {
    return supplyCounter.current();
  }

  string private customBaseURI;

  function setBaseURI(string memory customBaseURI_) external onlyOwner {
    customBaseURI = customBaseURI_;
  }

  function _baseURI() internal view virtual override returns (string memory) {
    return customBaseURI;
  }
}
