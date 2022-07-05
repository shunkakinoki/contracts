// SPDX-License-Identifier: MIT

/*
CrypToadz Created By:
  ___  ____  ____  __  __  ____  __    ____  _  _
 / __)(  _ \( ___)(  \/  )(  _ \(  )  (_  _)( \( )
( (_-. )   / )__)  )    (  )___/ )(__  _)(_  )  (
 \___/(_)\_)(____)(_/\/\_)(__)  (____)(____)(_)\_)
(https://cryptoadz.io)

ChainToadz Programmed By:
 __      __         __    __
/  \    /  \_____ _/  |__/  |_  _________.__.
\   \/\/   /\__  \\   __\   __\/  ___<   |  |
 \        /  / __ \|  |  |  |  \___ \ \___  |
  \__/\  /  (____  /__|  |__| /____  >/ ____|
       \/        \/                \/ \/
(https://wattsy.art)
*/

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "./GIFEncoder.sol";

error ImageNotFound();
error AnimationNotFound();

/** @notice Pixel renderer using basic drawing instructions: fill, line, and dot. */
library PixelRenderer {
  struct Point2D {
    int32 x;
    int32 y;
  }

  struct Line2D {
    Point2D v0;
    Point2D v1;
    uint32 color;
  }

  struct DrawFrame {
    bytes buffer;
    uint256 position;
    GIFEncoder.GIFFrame frame;
    uint32[255] colors;
  }

  function drawFrame(DrawFrame memory f)
    internal
    pure
    returns (DrawFrame memory)
  {
    (uint32 instructionCount, uint256 position) = readUInt32(
      f.buffer,
      f.position
    );
    f.position = position;

    for (uint32 i = 0; i < instructionCount; i++) {
      uint8 instructionType = uint8(f.buffer[f.position++]);

      if (instructionType == 0) {
        uint32 color = f.colors[uint8(f.buffer[f.position++])];
        for (uint16 x = 0; x < f.frame.width; x++) {
          for (uint16 y = 0; y < f.frame.height; y++) {
            f.frame.buffer[f.frame.width * y + x] = color;
          }
        }
      } else if (instructionType == 1) {
        uint32 color = f.colors[uint8(f.buffer[f.position++])];
        line(
          f.frame,
          PixelRenderer.Line2D(
            PixelRenderer.Point2D(
              int8(uint8(f.buffer[f.position++])),
              int8(uint8(f.buffer[f.position++]))
            ),
            PixelRenderer.Point2D(
              int8(uint8(f.buffer[f.position++])),
              int8(uint8(f.buffer[f.position++]))
            ),
            color
          )
        );
      } else if (instructionType == 2) {
        uint32 color = f.colors[uint8(f.buffer[f.position++])];
        dot(
          f.frame,
          int8(uint8(f.buffer[f.position++])),
          int8(uint8(f.buffer[f.position++])),
          color
        );
      }
    }

    return f;
  }

  function getColorTable(bytes memory buffer, uint256 position)
    internal
    pure
    returns (uint32[255] memory colors, uint256)
  {
    colors[0] = 0xFF000000;
    uint8 colorCount = uint8(buffer[position++]);
    for (uint8 i = 0; i < colorCount; i++) {
      uint32 r = uint32(uint8(buffer[position++]));
      uint32 g = uint32(uint8(buffer[position++]));
      uint32 b = uint32(uint8(buffer[position++]));
      uint32 color = 0;
      color |= 255 << 24;
      color |= r << 16;
      color |= g << 8;
      color |= b << 0;
      colors[i + 1] = color;
    }
    return (colors, position);
  }

  function dot(
    GIFEncoder.GIFFrame memory frame,
    int32 x,
    int32 y,
    uint32 color
  ) private pure {
    uint32 p = uint32(int16(frame.width) * y + x);
    frame.buffer[p] = color;
  }

  function line(GIFEncoder.GIFFrame memory frame, Line2D memory f)
    private
    pure
  {
    int256 x0 = f.v0.x;
    int256 x1 = f.v1.x;
    int256 y0 = f.v0.y;
    int256 y1 = f.v1.y;

    int256 dx = abs(x1 - x0);
    int256 dy = abs(y1 - y0);

    int256 err = (dx > dy ? dx : -dy) / 2;

    for (;;) {
      if (
        x0 <= int32(0) + int16(frame.width) - 1 &&
        x0 >= int32(0) &&
        y0 <= int32(0) + int16(frame.height) - 1 &&
        y0 >= int32(0)
      ) {
        uint256 p = uint256(int16(frame.width) * y0 + x0);
        frame.buffer[p] = f.color;
      }

      if (x0 == x1 && y0 == y1) break;
      int256 e2 = err;
      if (e2 > -dx) {
        err -= dy;
        x0 += x0 < x1 ? int8(1) : -1;
      }
      if (e2 < dy) {
        err += dx;
        y0 += y0 < y1 ? int8(1) : -1;
      }
    }
  }

  function readUInt32(bytes memory buffer, uint256 position)
    private
    pure
    returns (uint32, uint256)
  {
    uint8 d1 = uint8(buffer[position++]);
    uint8 d2 = uint8(buffer[position++]);
    uint8 d3 = uint8(buffer[position++]);
    uint8 d4 = uint8(buffer[position++]);
    return ((16777216 * d4) + (65536 * d3) + (256 * d2) + d1, position);
  }

  function abs(int256 x) private pure returns (int256) {
    return x >= 0 ? x : -x;
  }
}

/** @notice Interface describing ChainToadz, so other contracts can wrap and call into it if they want to share our data. */
interface IChainToadz {
  /** @notice Produces the token metadata as a JSON document  */
  function getTokenMetadata(uint256 tokenId)
    external
    view
    returns (string memory metadata);

  /** @notice Renders the canonical token image as an embedded data URI  */
  function getImageDataUri(uint256 tokenId)
    external
    view
    returns (string memory uri);

  /** @notice Renders a custom animation as an embedded data URI  */
  function getAnimationDataUri(uint256 tokenId, uint256 animationId)
    external
    view
    returns (string memory uri);

  /** @notice Renders the raw GIF image for the canonical token image */
  function getImage(uint256 tokenId)
    external
    view
    returns (GIFEncoder.GIF memory gif);

  /** @notice Renders the raw GIF image for a custom animation */
  function getAnimation(uint256 tokenId, uint256 animationId)
    external
    view
    returns (GIFEncoder.GIF memory gif);
}

contract ChainToadz is ERC721, IChainToadz {
  bytes private constant JSON_URI_PREFIX = "data:application/json;base64,";
  bytes private constant SVG_URI_PREFIX = "data:image/svg+xml;base64,";

  struct Point2D {
    int32 x;
    int32 y;
  }

  struct Line2D {
    Point2D v0;
    Point2D v1;
    uint32 color;
  }

  address private _admin;

  string private _tokenName;
  string private _externalUrl;
  string private _description;

  mapping(uint256 => bytes) public tokenData;
  mapping(uint256 => mapping(uint256 => bytes)) public animationData;
  mapping(uint256 => mapping(uint256 => string)) public animationName;

  mapping(uint256 => uint256) tokenAnimation;

  mapping(uint8 => string) public accessoryOne;
  mapping(uint8 => string) public accessoryTwo;
  mapping(uint8 => string) public background;
  mapping(uint8 => string) public body;
  mapping(uint8 => string) public clothes;
  mapping(uint8 => string) public custom;
  mapping(uint8 => string) public eyes;
  mapping(uint8 => string) public head;
  mapping(uint8 => string) public mouth;
  mapping(uint8 => string) public names;

  function setAccessoryOne(uint8 key, string memory value) external {
    require(_msgSender() == _admin);
    accessoryOne[key] = value;
  }

  function setAccessoryTwo(uint8 key, string memory value) external {
    require(_msgSender() == _admin);
    accessoryTwo[key] = value;
  }

  function setBackground(uint8 key, string memory value) external {
    require(_msgSender() == _admin);
    background[key] = value;
  }

  function setBody(uint8 key, string memory value) external {
    require(_msgSender() == _admin);
    body[key] = value;
  }

  function setClothes(uint8 key, string memory value) external {
    require(_msgSender() == _admin);
    clothes[key] = value;
  }

  function setCustom(uint8 key, string memory value) external {
    require(_msgSender() == _admin);
    custom[key] = value;
  }

  function setEyes(uint8 key, string memory value) external {
    require(_msgSender() == _admin);
    eyes[key] = value;
  }

  function setHead(uint8 key, string memory value) external {
    require(_msgSender() == _admin);
    head[key] = value;
  }

  function setMouth(uint8 key, string memory value) external {
    require(_msgSender() == _admin);
    mouth[key] = value;
  }

  function setName(uint8 key, string memory value) external {
    require(_msgSender() == _admin);
    names[key] = value;
  }

  constructor() ERC721("ChainToadz", "CHAINTOADZ") {
    _admin = _msgSender();

    _tokenName = "ChainToadz";
    _externalUrl = "https://cryptoadz.io";
    _description = "A small, warty, amphibious creature that resides in the metaverse (and entirely on the blockchain).";

    accessoryOne[1] = "Drive-thru";
    accessoryOne[2] = "Explorer";
    accessoryOne[3] = "Fly Lick";
    accessoryOne[4] = "Four Flies";
    accessoryOne[5] = "Mysterious Hoodie";
    accessoryOne[6] = "One Fly";
    accessoryOne[7] = "Three Flies";
    accessoryOne[8] = "Toxic Lumps";
    accessoryOne[9] = "Two Flies";

    accessoryTwo[1] = "Blush";
    accessoryTwo[2] = "Chocolate";
    accessoryTwo[3] = "Earring";
    accessoryTwo[4] = "Just for the Looks";
    accessoryTwo[5] = "Long Cigarette";
    accessoryTwo[6] = "Shackles";
    accessoryTwo[7] = "Short Cigarette";
    accessoryTwo[8] = "Watch";

    background[1] = "95";
    background[2] = "Blanket";
    background[3] = "Blood";
    background[4] = "Bruise";
    background[5] = "Bubblegum";
    background[6] = "Damp";
    background[7] = "Dark";
    background[8] = "Ghost Crash";
    background[9] = "Greige";
    background[10] = "Grey Foam";
    background[11] = "Greyteal";
    background[12] = "Matrix";
    background[13] = "Middlegrey";
    background[14] = "Mold";
    background[15] = "Salmon";
    background[16] = "Universe Foam";
    background[17] = "Violet";

    body[1] = "Albino";
    body[2] = "Alien";
    body[3] = "Angry";
    body[4] = "Ape";
    body[5] = "Berry";
    body[6] = "Big Ghost";
    body[7] = "Blood Bones";
    body[8] = "Blue Cat";
    body[9] = "Bones";
    body[10] = "Booger";
    body[11] = "Chimp";
    body[12] = "Creep";
    body[13] = "Dog";
    body[14] = "Gargoyle";
    body[15] = "Ghost";
    body[16] = "Ghost Bones";
    body[17] = "Gorilla";
    body[18] = "Gremplin Blue";
    body[19] = "Gremplin Green";
    body[20] = "Gummy Blue";
    body[21] = "Gummy Peach";
    body[22] = "Gummy Raspberry";
    body[23] = "Gummy Slime";
    body[24] = "Gummy Tropical";
    body[25] = "Hypnotic";
    body[26] = "Lasagna";
    body[27] = "Normal";
    body[28] = "Only Socks";
    body[29] = "Pasty";
    body[30] = "Pox";
    body[31] = "Sleepy";
    body[32] = "Toadbot";
    body[33] = "Toadenza";
    body[34] = "Undead";

    clothes[1] = "Force Hoodie";
    clothes[2] = "Grey Hoodie";
    clothes[3] = "Slime Hoodie";

    custom[1] = "Legendary";
    custom[2] = "Licked - Don't Look in the Mirror";
    custom[3] = "Licked - Hallucination";
    custom[4] = "Licked - Warped";
    custom[5] = "Murdered by Fronkz";

    eyes[1] = "3D";
    eyes[2] = "Anime";
    eyes[3] = "Awake";
    eyes[4] = "Bandit";
    eyes[5] = "Big Crazy Orange";
    eyes[6] = "Big Crazy Red";
    eyes[7] = "Big Yellow Side-eye";
    eyes[8] = "Black & Blue Goggles";
    eyes[9] = "Blue Eyeshadow";
    eyes[10] = "Butthole";
    eyes[11] = "Cool Shades";
    eyes[12] = "Creep";
    eyes[13] = "Croaked";
    eyes[14] = "Dilated";
    eyes[15] = "Glowing Blue";
    eyes[16] = "Glowing Red";
    eyes[17] = "Gold Specs";
    eyes[18] = "Green Eyeshadow";
    eyes[19] = "Gremplin";
    eyes[20] = "Judgment";
    eyes[21] = "Nerd";
    eyes[22] = "Nice Shades";
    eyes[23] = "Nounish Blue";
    eyes[24] = "Nounish Red";
    eyes[25] = "Patch";
    eyes[26] = "Red & Black Goggles";
    eyes[27] = "Round Shades";
    eyes[28] = "Thick Round";
    eyes[29] = "Thick Square";
    eyes[30] = "Undead";
    eyes[31] = "Vampire";
    eyes[32] = "Violet Goggles";
    eyes[33] = "White & Red Goggles";

    head[1] = "Aqua Mohawk";
    head[2] = "Aqua Puff";
    head[3] = "Aqua Shave";
    head[4] = "Aqua Sidepart";
    head[5] = "Backward Cap";
    head[6] = "Black Sidepart";
    head[7] = "Blonde Pigtails";
    head[8] = "Blue Pigtails";
    head[9] = "Blue Shave";
    head[10] = "Bowlcut";
    head[11] = "Brain";
    head[12] = "Crazy Blonde";
    head[13] = "Dark Pigtails";
    head[14] = "Dark Single Bun";
    head[15] = "Dark Tall Hat";
    head[16] = "Fez";
    head[17] = "Floppy Hat";
    head[18] = "Fun Cap";
    head[19] = "Grey Knit Hat";
    head[20] = "Orange Bumps";
    head[21] = "Orange Double Buns";
    head[22] = "Orange Knit Hat";
    head[23] = "Orange Shave";
    head[24] = "Orange Tal Hat";
    head[25] = "Periwinkle Cap";
    head[26] = "Pink Puff";
    head[27] = "Plaid Cap";
    head[28] = "Rainbow Mohawk";
    head[29] = "Red Gnome";
    head[30] = "Rusty Cap";
    head[31] = "Short Feathered Hat";
    head[32] = "Stringy";
    head[33] = "Super Stringy";
    head[34] = "Swampy Bumps";
    head[35] = "Swampy Crazy";
    head[36] = "Swampy Double Bun";
    head[37] = "Swampy Flattop";
    head[38] = "Swampy Sidepart";
    head[39] = "Swampy Single Bun";
    head[40] = "Swept Orange";
    head[41] = "Swept Purple";
    head[42] = "Swept Teal";
    head[43] = "Teal Gnome";
    head[44] = "Teal Knit Hat";
    head[45] = "Toadstool";
    head[46] = "Tophat";
    head[47] = "Truffle";
    head[48] = "Vampire";
    head[49] = "Wild Black";
    head[50] = "Wild Orange";
    head[51] = "Wild White";
    head[52] = "Wizard";
    head[53] = "Yellow Flattop";

    mouth[1] = "Bandit Smile";
    mouth[2] = "Bandit Wide";
    mouth[3] = "Beard";
    mouth[4] = "Blue Smile";
    mouth[5] = "Croak";
    mouth[6] = "Green Bucktooth";
    mouth[7] = "Lincoln";
    mouth[8] = "Peach Smile";
    mouth[9] = "Pink Bucktooth";
    mouth[10] = "Purple Wide";
    mouth[11] = "Ribbit Blue";
    mouth[12] = "Sad";
    mouth[13] = "Shifty";
    mouth[14] = "Slimy";
    mouth[15] = "Teal Smile";
    mouth[16] = "Teal Wide";
    mouth[17] = "Vampire";
    mouth[18] = "Well Actually";

    names[1] = "0xtoad";
    names[2] = "2croakchanes";
    names[3] = "41croak6";
    names[4] = "91croak5";
    names[5] = "9croak99";
    names[6] = "Adventurer";
    names[7] = "Aversanoad";
    names[8] = "BNToad";
    names[9] = "Barcroaka";
    names[10] = "Basglyphtoad";
    names[11] = "Bastoad";
    names[12] = "Belethtoad";
    names[13] = "Chanzerotoad";
    names[14] = "Cheftoad";
    names[15] = "Clairetoad";
    names[16] = "Colonel Floorbin";
    names[17] = "Croaklehat";
    names[18] = "Crycroak";
    names[19] = "Deezetoad";
    names[20] = "Dinfoad";
    names[21] = "Domtoad";
    names[22] = "Drocroak";
    names[23] = "Emmytoad";
    names[24] = "Erintoad";
    names[25] = "Fronkz Henchman 1";
    names[26] = "Fronkz Henchman 2";
    names[27] = "Geebztoad";
    names[28] = "Gustoad";
    names[29] = "Heeeeeeeetoad";
    names[30] = "Hero Of The Swamp";
    names[31] = "Herrerratoad";
    names[32] = "Huntoad";
    names[33] = "Hypetoad";
    names[34] = "Jeztoad";
    names[35] = "King Gremplin";
    names[36] = "Koppertoad";
    names[37] = "Leetoad";
    names[38] = "Little Sister";
    names[39] = "Marlotoad";
    names[40] = "Miketoad";
    names[41] = "Motitoad";
    names[42] = "Moxtoad";
    names[43] = "Mr7croak3";
    names[44] = "Nourtoad";
    names[45] = "Onitoad";
    names[46] = "Rastertoad";
    names[47] = "Samjtoad";
    names[48] = "Senecatoad";
    names[49] = "Slowbrodicktoad";
    names[50] = "Snowfroad";
    names[51] = "Sobytoad";
    names[52] = "Spcvetovd";
    names[53] = "Sumtoad";
    names[54] = "Tappytoad";
    names[55] = "Termitoad";
    names[56] = "Tiodan";
    names[57] = "Toadbeef";
    names[58] = "Trilltoad";
    names[59] = "VGFtoad";
    names[60] = "Vegtoad";
    names[61] = "Westoad";
    names[62] = "Yuppietoad";
    names[63] = "Zolitoad";
  }

  /** @notice Emitted when a single token metadata updates. */
  event TokenMetadataUpdated(uint256 indexed tokenId);

  /** @notice Emitted when all token metadata is considered stale. */
  event TokensMetadataUpdated();

  function setTokenDetails(
    string memory tokenName,
    string memory external_url,
    string memory description
  ) external {
    require(_msgSender() == _admin);
    _tokenName = tokenName;
    _externalUrl = external_url;
    _description = description;
    emit TokensMetadataUpdated();
  }

  function setTokenAnimation(uint256 tokenId, uint256 animationId) external {
    require(ownerOf(tokenId) == _msgSender());
    if (animationId != 0 && animationData[tokenId][animationId].length == 0)
      revert AnimationNotFound();
    tokenAnimation[tokenId] = animationId;
    emit TokenMetadataUpdated(tokenId);
  }

  function setTokenData(uint256 tokenId, bytes memory data) external {
    require(_msgSender() == _admin);
    tokenData[tokenId] = data;
    require(tokenData[tokenId].length == data.length);
    emit TokenMetadataUpdated(tokenId);
  }

  function setAnimationData(
    uint256 tokenId,
    uint256 animationId,
    bytes memory data
  ) external {
    require(_msgSender() == _admin);
    require(animationId > 0);
    animationData[tokenId][animationId] = data;
    require(animationData[tokenId][animationId].length == data.length);
    if (tokenAnimation[tokenId] == animationId) {
      emit TokenMetadataUpdated(tokenId);
    }
  }

  function setAnimationName(
    uint256 tokenId,
    uint256 animationId,
    string memory value
  ) external {
    require(_msgSender() == _admin);
    if (
      animationId == 0 ||
      (animationId != 0 && animationData[tokenId][animationId].length == 0)
    ) revert AnimationNotFound();
    animationName[tokenId][animationId] = value;
    if (tokenAnimation[tokenId] == animationId) {
      emit TokenMetadataUpdated(tokenId);
    }
  }

  /** @notice Produces the token metadata as a JSON document  */
  function getTokenMetadata(uint256 tokenId)
    public
    view
    override
    returns (string memory metadata)
  {
    return createTokenMetadata(tokenId);
  }

  function createTokenMetadata(uint256 tokenId)
    private
    view
    returns (string memory metadata)
  {
    uint256 animationId = tokenAnimation[tokenId];

    string memory imageUri = GIFEncoder.getDataUri(
      animationId == 0 ? getImage(tokenId) : getAnimation(tokenId, animationId)
    );

    string memory imageData = string(
      abi.encodePacked(
        '<svg version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px" viewBox="0 0 100 100" style="enable-background:new 0 0 100 100;" xml:space="preserve">',
        '<image style="image-rendering:-moz-crisp-edges;image-rendering:-webkit-crisp-edges;image-rendering:pixelated;" width="100" height="100" xlink:href="',
        imageUri,
        '"/></svg>'
      )
    );

    metadata = string(
      abi.encodePacked(
        '{"description":"',
        _description,
        '","external_url":"',
        _externalUrl,
        '","image_data":"',
        abi.encodePacked(
          SVG_URI_PREFIX,
          Base64.encode(bytes(imageData), bytes(imageData).length)
        ),
        '","name":"',
        _tokenName,
        " #",
        toString(tokenId),
        '",',
        getTokenMetadataAttributes(tokenId),
        "}"
      )
    );
  }

  function getTokenMetadataAttributes(uint256 tokenId)
    private
    view
    returns (string memory attributes)
  {
    bytes memory buffer = tokenData[tokenId];
    uint256 position = 0;
    require(buffer.length > 0);

    uint8 numberOfTraits = 0;

    attributes = string(abi.encodePacked('"attributes":['));
    {
      (string memory a, uint8 t) = appendTrait(
        attributes,
        "Background",
        background[uint8(buffer[position++])],
        numberOfTraits
      );
      attributes = a;
      numberOfTraits = t;
    }

    {
      (string memory a, uint8 t) = appendTrait(
        attributes,
        "Body",
        body[uint8(buffer[position++])],
        numberOfTraits
      );
      attributes = a;
      numberOfTraits = t;
    }

    position++;

    {
      (string memory a, uint8 t) = appendTrait(
        attributes,
        "Clothes",
        clothes[uint8(buffer[position++])],
        numberOfTraits
      );
      attributes = a;
      numberOfTraits = t;
    }

    {
      (string memory a, uint8 t) = appendTrait(
        attributes,
        "Eyes",
        eyes[uint8(buffer[position++])],
        numberOfTraits
      );
      attributes = a;
      numberOfTraits = t;
    }

    {
      (string memory a, uint8 t) = appendTrait(
        attributes,
        "Head",
        head[uint8(buffer[position++])],
        numberOfTraits
      );
      attributes = a;
      numberOfTraits = t;
    }

    {
      (string memory a, uint8 t) = appendTrait(
        attributes,
        "Mouth",
        mouth[uint8(buffer[position++])],
        numberOfTraits
      );
      attributes = a;
      numberOfTraits = t;
    }

    {
      (string memory a, uint8 t) = appendTrait(
        attributes,
        "Accessory I",
        accessoryOne[uint8(buffer[position++])],
        numberOfTraits
      );
      attributes = a;
      numberOfTraits = t;
    }

    {
      (string memory a, uint8 t) = appendTrait(
        attributes,
        "Accessory II",
        accessoryTwo[uint8(buffer[position++])],
        numberOfTraits
      );
      attributes = a;
      numberOfTraits = t;
    }

    {
      (string memory a, uint8 t) = appendTrait(
        attributes,
        "Custom",
        custom[uint8(buffer[position++])],
        numberOfTraits
      );
      attributes = a;
      numberOfTraits = t;
    }

    if (tokenAnimation[tokenId] != 0) {
      (string memory a, uint8 t) = appendTrait(
        attributes,
        "Animation",
        animationName[tokenId][tokenAnimation[tokenId]],
        numberOfTraits
      );
      attributes = a;
      numberOfTraits = t;
    }

    {
      (string memory a, uint8 t) = appendTrait(
        attributes,
        "Name",
        names[uint8(buffer[position++])],
        numberOfTraits
      );
      attributes = a;
      numberOfTraits = t;
    }

    attributes = string(
      abi.encodePacked(
        attributes,
        ',{"trait_type":"# Traits","value":"',
        toString(numberOfTraits),
        '"}]'
      )
    );
  }

  function appendTrait(
    string memory attributes,
    string memory trait_type,
    string memory value,
    uint8 numberOfTraits
  ) private pure returns (string memory, uint8) {
    if (bytes(value).length > 0) {
      numberOfTraits++;
      attributes = string(
        abi.encodePacked(
          attributes,
          numberOfTraits > 1 ? "," : "",
          '{"trait_type":"',
          trait_type,
          '","value":"',
          value,
          '"}'
        )
      );
    }
    return (attributes, numberOfTraits);
  }

  /** @notice Renders the raw GIF image for the canonical token image */
  function getImage(uint256 tokenId)
    public
    view
    override
    returns (GIFEncoder.GIF memory gif)
  {
    bytes memory buffer = tokenData[tokenId];
    if (buffer.length == 0) revert ImageNotFound();
    uint256 position = 11;

    (uint32[255] memory colors, uint256 p) = PixelRenderer.getColorTable(
      buffer,
      position
    );
    position = p;

    gif.width = 36;
    gif.height = 36;

    {
      GIFEncoder.GIFFrame memory frame;
      frame.width = gif.width;
      frame.height = gif.height;

      PixelRenderer.DrawFrame memory f = PixelRenderer.DrawFrame(
        buffer,
        position,
        frame,
        colors
      );
      f = PixelRenderer.drawFrame(f);

      frame.buffer = f.frame.buffer;
      frame.width = f.frame.width;
      frame.height = f.frame.height;

      gif.frames[gif.frameCount++] = frame;
    }
  }

  /** @notice Renders the canonical token image as an embedded data URI  */
  function getImageDataUri(uint256 tokenId)
    external
    view
    override
    returns (string memory)
  {
    GIFEncoder.GIF memory gif = getImage(tokenId);
    string memory dataUri = GIFEncoder.getDataUri(gif);
    return dataUri;
  }

  /** @notice Renders the raw GIF image for a custom animation */
  function getAnimation(uint256 tokenId, uint256 animationId)
    public
    view
    override
    returns (GIFEncoder.GIF memory gif)
  {
    uint32[255] memory colors;
    {
      bytes memory tokenBuffer = tokenData[tokenId];
      if (tokenBuffer.length == 0) revert ImageNotFound();
      (colors, ) = PixelRenderer.getColorTable(tokenBuffer, 11);
      require(colors[1] != 0);
    }

    gif.width = 36;
    gif.height = 36;

    {
      bytes memory buffer = animationData[tokenId][animationId];
      if (buffer.length == 0) revert AnimationNotFound();
      uint256 position = 0;

      uint8 frameCount = uint8(buffer[position++]);

      for (uint8 i = 0; i < frameCount; i++) {
        GIFEncoder.GIFFrame memory frame;
        frame.width = gif.width;
        frame.height = gif.height;

        uint16 delay;
        {
          uint8 d1 = uint8(buffer[position++]);
          uint8 d2 = uint8(buffer[position++]);
          delay = (256 * d2) + d1;

          frame.delay = delay;
        }

        PixelRenderer.DrawFrame memory f = PixelRenderer.DrawFrame(
          buffer,
          position,
          frame,
          colors
        );
        f = PixelRenderer.drawFrame(f);
        position = f.position;
        gif.frames[gif.frameCount++] = f.frame;
      }
    }
  }

  /** @notice Renders a custom animation as an embedded data URI  */
  function getAnimationDataUri(uint256 tokenId, uint256 animationId)
    external
    view
    override
    returns (string memory)
  {
    GIFEncoder.GIF memory gif = getAnimation(tokenId, animationId);
    string memory dataUri = GIFEncoder.getDataUri(gif);
    return dataUri;
  }

  function toString(uint256 value) private pure returns (string memory) {
    bytes memory reversed = new bytes(78);
    uint256 i = 0;
    while (value != 0) {
      uint256 remainder = value % 10;
      value = value / 10;
      reversed[i++] = bytes1(uint8(48 + remainder));
    }
    bytes memory s = new bytes(i);
    for (uint256 j = 0; j < i; j++) {
      s[j] = reversed[i - 1 - j];
    }
    return string(s);
  }

  function tokenURI(uint256 tokenId)
    public
    view
    override
    returns (string memory)
  {
    require(
      _exists(tokenId),
      "ERC721Metadata: URI query for nonexistent token"
    );
    string memory metadata = createTokenMetadata(tokenId);
    string memory dataUri = string(
      abi.encodePacked(
        JSON_URI_PREFIX,
        Base64.encode(bytes(metadata), bytes(metadata).length)
      )
    );
    return dataUri;
  }

  function updateAdmin(address newAdmin) public {
    require(_msgSender() == _admin);
    require(newAdmin != address(0x0));
    _admin = newAdmin;
  }

  function mint(uint256 tokenId) public {
    require(_msgSender() == _admin);
    _safeMint(_msgSender(), tokenId);
  }
}
