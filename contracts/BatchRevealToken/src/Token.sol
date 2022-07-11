// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import { ERC721A } from "erc721a/contracts/ERC721A.sol";
import { IERC2981 } from "@openzeppelin/contracts/interfaces/IERC2981.sol";
import { IERC165 } from "@openzeppelin/contracts/interfaces/IERC165.sol";
import { AllowList } from "./lib/AllowList.sol";
import { BatchReveal } from "./lib/BatchReveal.sol";
import { MaxMintable } from "./lib/MaxMintable.sol";
import { Withdrawable } from "./lib/Withdrawable.sol";
import { TwoStepOwnable } from "./lib/TwoStepOwnable.sol";
import { Ownable } from "@openzeppelin/contracts/access/Ownable.sol";

contract Token is
  MaxMintable,
  IERC2981,
  AllowList,
  BatchReveal,
  TwoStepOwnable,
  Withdrawable
{
  uint256 immutable MAX_PUBLIC_MINTABLE;
  uint256 immutable MAX_DEV_MINTABLE;

  address royaltyRecipient;
  uint96 public mintPrice;
  uint96 public allowListMintPrice;
  uint16 numDevMinted;
  uint16 public royaltyBps;
  SaleState public saleState;

  enum SaleState {
    PAUSED,
    ALLOW_LIST,
    PUBLIC
  }

  error SalePaused();
  error PublicSaleInactive();
  error MaxSupply();
  error IncorrectPayment();
  error MaxDevMinted();
  error InvalidRoyaltyBps();

  ///@notice modifier to restrict function only when SaleState is PUBLIC
  modifier onlyPublic() {
    if (saleState != SaleState.PUBLIC) {
      revert PublicSaleInactive();
    }
    _;
  }

  ///@notice modifier to restrict function only when SaleState is not PAUSED
  modifier whenNotPaused() {
    if (saleState == SaleState.PAUSED) {
      revert SalePaused();
    }
    _;
  }

  ///@notice modifier to restrict function when quantity + number minted is <= MAX_PUBLIC_MINTABLE
  modifier canMint(uint256 quantity) {
    if (quantity + _nextTokenId() > MAX_PUBLIC_MINTABLE) {
      revert MaxSupply();
    }
    _;
  }

  ///@notice modifier to restrict function to only accept msg.value of _mintPrice * quantity
  modifier includesCorrectPayment(uint96 _mintPrice, uint256 quantity) {
    if (quantity * _mintPrice != msg.value) {
      revert IncorrectPayment();
    }
    _;
  }

  constructor(
    string memory name,
    string memory symbol,
    uint256 _maxMintsPerWallet,
    uint256 numPublicMintable,
    uint256 numDevMintable,
    uint16 _royaltyBps,
    uint96 _mintPrice,
    uint96 _allowListMintPrice,
    bytes32 _merkleRoot,
    string memory _defaultURI,
    bytes32 provenanceHash
  )
    MaxMintable(name, symbol, _maxMintsPerWallet)
    BatchReveal(_defaultURI, provenanceHash)
    AllowList(_merkleRoot)
  {
    royaltyRecipient = msg.sender;
    MAX_DEV_MINTABLE = numDevMintable;
    MAX_PUBLIC_MINTABLE = numPublicMintable;
    royaltyBps = _royaltyBps;
    mintPrice = _mintPrice;
    allowListMintPrice = _allowListMintPrice;
  }

  /// @notice mint a token when public sale is active, up to max supply, up to max quantity per wallet,
  /// given correct public mint payment
  function mint(uint256 quantity)
    public
    payable
    onlyPublic
    canMint(quantity)
    checkMaxMintedForWallet(quantity)
    includesCorrectPayment(mintPrice, quantity)
  {
    _mint(msg.sender, quantity);
  }

  /// @notice mint a token when not paused, up to max supply, up to max quantity per wallet,
  /// given correct allowlist mint payment and proof of inclusion on allowlist
  function allowListMint(uint256 quantity, bytes32[] calldata proof)
    public
    payable
    whenNotPaused
    canMint(quantity)
    onlyAllowListed(proof)
    checkMaxMintedForWallet(quantity)
    includesCorrectPayment(allowListMintPrice, quantity)
  {
    _mint(msg.sender, quantity);
  }

  ///@notice contract owner can mint up to MAX_DEV_MINTABLE tokens
  function devMint(uint16 amount, address to) public onlyOwner {
    if (uint256(numDevMinted) + amount > MAX_DEV_MINTABLE) {
      revert MaxDevMinted();
    }
    numDevMinted += amount;
    _safeMint(to, amount);
  }

  /// @notice set public mint price. onlyOwner
  function setMintPrice(uint96 newPrice) public onlyOwner {
    mintPrice = newPrice;
  }

  /// @notice set allowlist mint price. onlyOwner
  function setAllowListMintPrice(uint96 newPrice) public onlyOwner {
    allowListMintPrice = newPrice;
  }

  /// @notice set SaleState. onlyOwner
  function setSaleState(SaleState _saleState) public onlyOwner {
    saleState = _saleState;
  }

  /// @notice set royalty recipient. onlyOwner
  function setRoyaltyInfo(address recipient, uint16 bps) public onlyOwner {
    if (bps > 10000) {
      revert InvalidRoyaltyBps();
    }
    royaltyBps = bps;
    royaltyRecipient = recipient;
  }

  function supportsInterface(bytes4 interfaceId)
    public
    view
    virtual
    override(ERC721A, IERC165)
    returns (bool)
  {
    return
      ERC721A.supportsInterface(interfaceId) ||
      type(IERC2981).interfaceId == interfaceId;
  }

  /// @dev Returns the royalty recipient and amount, given a tokenId and sale price.
  function royaltyInfo(uint256, uint256 salePrice)
    external
    view
    virtual
    override
    returns (address receiver, uint256 royaltyAmount)
  {
    return (royaltyRecipient, (royaltyBps * salePrice) / 10_000);
  }

  function _baseURI()
    internal
    view
    virtual
    override(ERC721A, BatchReveal)
    returns (string memory)
  {
    return BatchReveal._baseURI();
  }

  function tokenURI(uint256 tokenId)
    public
    view
    override(ERC721A, BatchReveal)
    returns (string memory)
  {
    return BatchReveal.tokenURI(tokenId);
  }

  function transferOwnership(address newOwner)
    public
    virtual
    override(Ownable, TwoStepOwnable)
    onlyOwner
  {
    TwoStepOwnable.transferOwnership(newOwner);
  }
}
