// SPDX-License-Identifier: MIT
// Code from: https://github.com/FredCoen/cryptotesters-merkle-whitelist-nft/blob/master/src/ERC721CryptoTesters.sol

pragma solidity ^0.8.13;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/cryptography/MerkleProof.sol";
import "./Controller.sol";

contract ERC721CryptoTesters is ERC721, Controller {
  /*//////////////////////////////////////////////////////////////
                                STORAGE
    //////////////////////////////////////////////////////////////*/

  uint256 public constant totalSupply = 2000;
  uint256 public constant mintPrice = 0.3 ether;
  uint256 public currentTokenId;

  mapping(address => bool) public whitelistClaimed;

  /*//////////////////////////////////////////////////////////////
                              CONSTRUCTOR
    //////////////////////////////////////////////////////////////*/

  constructor(
    string memory _name,
    string memory _symbol,
    bytes32 _merkleroot,
    bool _publicMint,
    bool _whitelistMint
  ) ERC721(_name, _symbol) {
    merkleRoot = _merkleroot;
    publicMint = _publicMint;
    whitelistMint = _whitelistMint;
  }

  /*//////////////////////////////////////////////////////////////
                              PUBLIC MINTING LOGIC
    //////////////////////////////////////////////////////////////*/

  /// @dev Approx. 4 million gas well below block limit
  function preMintForTreasury() public onlyOwner {
    require(currentTokenId + 150 <= totalSupply, "Max supply reached");
    for (uint256 id = 0; id < 150; id++) {
      uint256 newTokenId = ++currentTokenId;
      _safeMint(msg.sender, newTokenId);
    }
  }

  function whitelistClaim(bytes32[] calldata proof) public returns (uint256) {
    require(whitelistMint, "Whitelist mint not available yet");
    require(!publicMint, "Whitelised claims have expired");
    require(!whitelistClaimed[msg.sender], "Address already claimed");
    uint256 newTokenId = ++currentTokenId;
    bytes32 leaf = keccak256(abi.encodePacked(msg.sender));
    require(
      MerkleProof.verify(proof, merkleRoot, leaf),
      "Address not whitelisted"
    );
    require(newTokenId <= totalSupply, "Max supply reached");
    whitelistClaimed[msg.sender] = true;
    _safeMint(msg.sender, newTokenId);
    return newTokenId;
  }

  function publicMintTo(address recipient) public payable returns (uint256) {
    require(publicMint, "Public mint not available yet");
    require(
      msg.value == mintPrice,
      "Transaction value did not equal the mint price"
    );
    uint256 newTokenId = ++currentTokenId;
    require(newTokenId <= totalSupply, "Max supply reached");
    _safeMint(recipient, newTokenId);
    return newTokenId;
  }

  /*//////////////////////////////////////////////////////////////
                          METADATA STORAGE/LOGIC
    //////////////////////////////////////////////////////////////*/

  function _baseURI() internal view virtual override returns (string memory) {
    return baseURI;
  }
}
