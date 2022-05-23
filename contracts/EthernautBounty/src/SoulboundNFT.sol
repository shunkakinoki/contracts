// SPDX-License-Identifier: MIT
// Code from: https://github.com/tahos81/ethernaut-bounty

pragma solidity ^0.8.13;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import { Base64 } from "./libraries/Base64.sol";

interface IERC20 {
  function balanceOf(address _owner) external view returns (uint256);
}

/// @notice Soulbound NFT showcasing an addresses EXP tokens.
/// @author Tahos81 (https://github.com/tahos81/ethernaut-bounty/blob/main/src/SoulboundNFT.sol)
contract SoulboundNFT is ERC721URIStorage {
  error Soulbound();

  //License: CC Attribution. Made by game-icons.net: https://game-icons.net/
  string constant SVGpart1 =
    "<svg width='270' height='270' viewBox='0 0 270 270' xmlns='http://www.w3.org/2000/svg'><path fill='url(#a)' d='M0 0h142.383v142.383H0z'/><defs><filter id='a' color-interpolation-filters='sRGB' filterUnits='userSpaceOnUse' height='270' width='270'><feDropShadow dx='1' dy='1' stdDeviation='2' flood-opacity='.625' width='200%' height='200%'/></filter></defs><path d='M135 12.129c-8.478 0-17.073 1.967-25.406 5.4-1.121 3.441-2.045 7.784-2.572 12.527-.691 6.217-.912 13.029-.986 19.416 17.858-1.953 40.071-1.953 57.929 0-.074-6.388-.295-13.199-.986-19.417-.527-4.742-1.45-9.085-2.572-12.526-8.334-3.433-16.929-5.4-25.407-5.4zm53.032 10.195c4.912 3.72 9.549 7.846 13.86 12.252a21.639 21.639 0 0 1 4.762-9.331zm-89.664.786C80.082 33.773 64.066 50.908 54.835 68.638c-17.445 33.505-20.93 82.77-.279 113.273 15.468 22.845 51.058 31.663 80.444 31.663 29.386 0 64.977-8.817 80.445-31.664 20.652-30.503 17.165-79.768-.279-113.273-9.231-17.729-25.247-34.864-43.532-45.527.305 1.925.557 3.896.779 5.898.803 7.221 1.008 14.87 1.062 21.762 9.863 1.662 17.423 4.074 20.588 7.238 16.875 16.875 39.834 71.031 8.438 118.125-19.857 29.784-115.143 29.784-135 0-31.396-47.094-8.438-101.25 8.438-118.125 3.164-3.164 10.724-5.576 20.587-7.239.054-6.892.26-14.54 1.063-21.762.221-2.002.475-3.973.779-5.898zM33.75 25.313a8.438 8.438 0 0 0-8.438 8.438 8.438 8.438 0 0 0 3.691 6.975v36.003l9.493-7.12V40.716a8.438 8.438 0 0 0 3.692-6.966 8.438 8.438 0 0 0-8.438-8.438zm189.216 1.941c-6.755 0-12.129 5.374-12.129 12.129s5.374 12.129 12.129 12.129 12.129-5.374 12.129-12.129-5.374-12.129-12.129-12.129zm13.327 29.112c-3.681 2.899-8.31 4.638-13.326 4.638-.393 0-.78-.014-1.168-.035a114.207 114.207 0 0 1 1.255 2.304l15.742 11.807zm-125.941 1.318c-9.1.047-19.647 1.981-28.072 8.501-14.045 10.867-22.694 60.52-17.661 77.395 8.745-32.572 16.871-65.401 56.911-85.047a70.371 70.371 0 0 0-11.178-.849zm-71.22 23.314L21.173 94.467l-7.636 38.184 20.134 24.16c-5.773-24.534-3.046-52.061 5.461-75.813zm191.737 0c8.506 23.753 11.233 51.28 5.461 75.813l20.134-24.16-7.636-38.184zM56.239 198.244c-1.889.617-3.824 1.796-5.422 3.393-2.181 2.181-3.523 4.973-3.778 7.438.111.192.318.61.912 1.14 1.294 1.154 3.53 2.726 6.395 4.408 5.731 3.364 14.001 7.255 23.311 10.875 11.168 4.344 23.915 8.281 35.721 10.747v-14.56c-20.814-2.7-42.133-9.664-57.14-23.441zm157.523 0c-15.008 13.777-36.327 20.741-57.141 23.441v14.56c11.806-2.466 24.553-6.404 35.721-10.747 9.31-3.62 17.581-7.511 23.311-10.875 2.866-1.682 5.102-3.254 6.395-4.409.594-.529.802-.948.912-1.139-.254-2.465-1.596-5.258-3.777-7.438-1.598-1.598-3.533-2.776-5.422-3.393zM40.775 216.528 9.492 237.384v23.124h19.512v-9.492h9.492v9.492h193.008v-9.492h9.492v9.492h19.512v-23.124l-31.283-20.855c-.283.257-.57.512-.856.768-2.068 1.844-4.71 3.633-7.909 5.512-6.398 3.755-15.003 7.775-24.677 11.537-19.349 7.523-42.721 14.033-60.783 14.033s-41.434-6.509-60.783-14.033c-9.674-3.763-18.279-7.782-24.677-11.537-3.199-1.877-5.841-3.668-7.909-5.512-.286-.257-.573-.512-.856-.769zm82.096 6.108v15.289c4.343.613 8.444.962 12.129.962 3.685 0 7.786-.349 12.129-.962v-15.289a171.34 171.34 0 0 1-24.258 0z'/><text x='50%' y='50%' class='base' fill='#28f' dominant-baseline='middle' text-anchor='middle' style='font-family:sans-serif,Josefin;font-size:75px'>";
  string constant SVGpart2 = "</text></svg>";

  IERC20 immutable EXPToken;

  constructor(
    string memory _name,
    string memory _symbol,
    address _EXPAdress
  ) ERC721(_name, _symbol) {
    EXPToken = IERC20(_EXPAdress);
  }

  function mint() external {
    require(balanceOf(msg.sender) == 0, "one token per wallet");

    uint160 tokenId = uint160(msg.sender);

    string memory initialSVG = string.concat(SVGpart1, "0", SVGpart2);

    string memory json = Base64.encode(
      bytes(
        string(
          abi.encodePacked(
            '{"description": "An NFT showcasing EXP tokens of an individual", "image": "data:image/svg+xml;base64,',
            Base64.encode(bytes(initialSVG)),
            '"}'
          )
        )
      )
    );

    string memory finalTokenUri = string(
      abi.encodePacked("data:application/json;base64,", json)
    );

    _safeMint(msg.sender, tokenId);
    _setTokenURI(tokenId, finalTokenUri);
  }

  //gets the EXP token balance of the address and updates the URI of the corresponding NFT
  function updateURI(address addressToUpdate) external {
    uint256 balance = EXPToken.balanceOf(addressToUpdate);
    uint256 tokenId = uint160(addressToUpdate);

    string memory newSVG = string.concat(
      SVGpart1,
      Strings.toString(balance),
      SVGpart2
    );

    string memory json = Base64.encode(
      bytes(
        string(
          abi.encodePacked(
            '{"description": "An NFT showcasing EXP tokens of an individual", "image": "data:image/svg+xml;base64,',
            Base64.encode(bytes(newSVG)),
            '"}'
          )
        )
      )
    );

    string memory newTokenUri = string(
      abi.encodePacked("data:application/json;base64,", json)
    );

    _setTokenURI(tokenId, newTokenUri);
  }

  /*//////////////////////////////////////////////////////////////
                            SOULBOUND LOGIC
    //////////////////////////////////////////////////////////////*/

  //Disallowed for preventing gas waste
  function _approve(address to, uint256 tokenId) internal override {
    revert Soulbound();
  }

  //Disallowed for preventing gas waste
  function _setApprovalForAll(
    address owner,
    address operator,
    bool approved
  ) internal override {
    revert Soulbound();
  }

  //Only allows transfers if it is minting
  function _beforeTokenTransfer(
    address from,
    address to,
    uint256 tokenId
  ) internal override {
    if (from != address(0)) revert Soulbound();
  }
}
