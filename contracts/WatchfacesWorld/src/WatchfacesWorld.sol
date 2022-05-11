// SPDX-License-Identifier: Unlicense
// Contract derived from etherscan at: https://etherscan.io/address/0x8d3b078d9d9697a8624d4b32743b02d270334af1#code
// All rights reserved to the author.

pragma solidity ^0.8.13;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "./EIP712Signing.sol";
import "./Renderer.sol";

/*
 _    _       _       _      __                     _    _            _     _
| |  | |     | |     | |    / _|                   | |  | |          | |   | |
| |  | | __ _| |_ ___| |__ | |_ __ _  ___ ___  ___ | |  | | ___  _ __| | __| |
| |/\| |/ _` | __/ __| '_ \|  _/ _` |/ __/ _ \/ __|| |/\| |/ _ \| '__| |/ _` |
\  /\  / (_| | || (__| | | | || (_| | (_|  __/\__ \\  /\  / (_) | |  | | (_| |
 \/  \/ \__,_|\__\___|_| |_|_| \__,_|\___\___||___(_)/  \/ \___/|_|  |_|\__,_|

  https://www.watchfaces.world/ | https://twitter.com/watchfacesworld

*/

interface IERC2981 is IERC165 {
  function royaltyInfo(uint256 _tokenId, uint256 _salePrice)
    external
    view
    returns (address receiver, uint256 royaltyAmount);
}

// External contract for early access to minting
interface IWatchfacesPriorityPass {
  function redeem(address holder) external;
}

contract WatchfacesWorld is ERC721, IERC2981, EIP712Signing {
  // Token ID
  // We encode each of the traits into the actual tokenId as an 8 digit number:
  //    00   00   00      00
  // bezel face mood glasses

  // Emitted when we know that something about the token has changed
  // tokenId is 0xfff...ff when all tokens have been updated
  event MetadataUpdated(uint256 indexed tokenId);

  uint256 public totalSupply;

  // Store renderer as separate contract so we can update it if needed
  Renderer public renderer;

  // Need to check if current minter has a priority pass, and if so, redeem it
  IWatchfacesPriorityPass public pass;

  // Once all watchfaces sell out and any moderation issues are resolved,
  // we will turn this flag on and lock all engravings in permanently
  bool public engravingsLockedForever;

  // In case we want to have a more complex logic for royalties, we can delegate
  // to a separate contract. If it's not available, default to 5%
  IERC2981 public royaltyInfoDelegate;

  // Token Id -> Minted (or transferred) Timestamp
  mapping(uint256 => uint256) public timestamps;

  // We store the engravings separately from the watchface tokenIds
  // This lets us moderate engravings before locking them in forever
  mapping(uint256 => string) public engravings;

  // This flag lets us check
  mapping(uint256 => bool) private heldForAtLeast8WeeksBeforeTransfer;

  // Use a special ID for glow in the dark to view the correct rendering
  uint256 constant GLOW_IN_THE_DARK_TOKEN_ID = 4049999;

  constructor(address _whitelistSigningKey)
    ERC721("Watchfaces", "WFW")
    EIP712Signing(_whitelistSigningKey)
  {
    // Initial total supply is 1 (the Glow In The Dark watch)
    totalSupply = 1;

    // We automatically mint the glow in the dark watch to one of the admins.
    // We'll give this away in the future
    _mint(msg.sender, GLOW_IN_THE_DARK_TOKEN_ID);
  }

  function mint(
    uint256 _tokenId,
    bool _usePass,
    string calldata _engraving,
    bytes calldata _signature
  ) public payable {
    require(totalSupply < 3600, "No more left");
    unchecked {
      // Can't overflow, save gas
      totalSupply++;
    }

    // All token parameters must be signed by a trusted server. This way we
    // can avoid storing prices and supply data on chain, making the mint
    // function use less gas.
    requireValidSignature(
      msg.sender,
      _tokenId,
      _usePass,
      msg.value,
      _engraving,
      _signature
    );

    if (bytes(_engraving).length > 0) {
      engravings[_tokenId] = _engraving;
    }

    // We could use pass.balanceOf() to see if the sender has a pass, but
    // this adds gas and is only useful to the 360 passes holders. To make
    // minting cheaper, we ask the frontend do the check
    if (_usePass) {
      require(address(pass) != address(0), "Pass not set");
      pass.redeem(msg.sender);
    }

    // Each watch is unique, and we rely on OpenZeppelin ERC721 implementation
    // to do the existance check
    _mint(msg.sender, _tokenId);
  }

  // Any owner can wipe the engraving off a watchface, but not rewrite it.
  // This helps us avoid any long term moderation issues while still giving
  // control to new owners
  function wipeEngraving(uint256 _tokenId) public {
    require(ownerOf(_tokenId) == msg.sender, "Not yours");
    delete engravings[_tokenId];
    emit MetadataUpdated(_tokenId);
  }

  function tokenURI(uint256 _tokenId)
    public
    view
    override
    returns (string memory)
  {
    return
      renderer.render(
        _tokenId,
        ownerOf(_tokenId),
        timestamps[_tokenId],
        holdingProgress(_tokenId),
        engravings[_tokenId]
      );
  }

  function _beforeTokenTransfer(
    address _from,
    address _to,
    uint256 _tokenId
  ) internal virtual override {
    super._beforeTokenTransfer(_from, _to, _tokenId);

    // We want to reward holding watchfaces for a long time. Once a watchface
    // has been "cared-for", we set a special flag so the new owner can benefit
    // from it.
    // Note: this function is also called on _mint, and we know that timestamps[_tokenId]
    // is not set yet, so no point in checking the rest of this logic
    if (_from != address(0)) {
      if (!heldForAtLeast8WeeksBeforeTransfer[_tokenId]) {
        if (timestamps[_tokenId] + 8 weeks <= block.timestamp) {
          heldForAtLeast8WeeksBeforeTransfer[_tokenId] = true;
        }
      }
    }

    timestamps[_tokenId] = block.timestamp;
    emit MetadataUpdated(_tokenId);
  }

  // Holding progress is 0...1000 showing how much time the watchface has been
  // held for. If the watchface has been "cared-for", it's always going to be 1000
  function holdingProgress(uint256 _tokenId) public view returns (uint256) {
    require(timestamps[_tokenId] != 0, "Token does not exist");

    if (heldForAtLeast8WeeksBeforeTransfer[_tokenId]) {
      return 1000;
    }

    if (timestamps[_tokenId] + 8 weeks <= block.timestamp) {
      return 1000;
    }

    return ((block.timestamp - timestamps[_tokenId]) * 1000) / 8 weeks;
  }

  function supportsInterface(bytes4 _interfaceId)
    public
    view
    override(ERC721, IERC165)
    returns (bool)
  {
    return
      _interfaceId == type(IERC2981).interfaceId ||
      super.supportsInterface(_interfaceId);
  }

  function royaltyInfo(uint256 _tokenId, uint256 _salePrice)
    external
    view
    override
    returns (address, uint256)
  {
    if (address(royaltyInfoDelegate) != address(0)) {
      return royaltyInfoDelegate.royaltyInfo(_tokenId, _salePrice);
    }

    // Return 5% royalties.
    return (owner(), (_salePrice * 5) / 100);
  }

  /* ADMIN */
  // If an engraving contains any text that goes against our engraving and community guidelines,
  // admins can rewrite it after discussing with the watchface owner.
  function rewriteEngraving(uint256 _tokenId, string calldata _engraving)
    external
    onlyOwner
  {
    require(!engravingsLockedForever, "Locked forever");
    engravings[_tokenId] = _engraving;
    emit MetadataUpdated(_tokenId);
  }

  // After all watches sell out, we call this lock function to lock the engravings in place.
  function lockEngravingsForever() external onlyOwner {
    engravingsLockedForever = true;
  }

  function withdrawAll() external {
    payable(owner()).transfer(address(this).balance);
  }

  function withdrawAllERC20(IERC20 _erc20Token) external {
    _erc20Token.transfer(owner(), _erc20Token.balanceOf(address(this)));
  }

  function setRenderer(Renderer _renderer) external onlyOwner {
    renderer = _renderer;
    emit MetadataUpdated(type(uint256).max);
  }

  function setRoyaltyInfoDelegate(IERC2981 _royaltyInfoDelegate)
    external
    onlyOwner
  {
    royaltyInfoDelegate = _royaltyInfoDelegate;
  }

  function setPass(IWatchfacesPriorityPass _pass) external onlyOwner {
    pass = _pass;
  }
}
