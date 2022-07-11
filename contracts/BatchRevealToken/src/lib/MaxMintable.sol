// SPDX-License-Identifier: MIT
pragma solidity >=0.8.4;
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";
import {ERC721A} from "erc721a/contracts/ERC721A.sol";

///@notice Ownable ERC721A contract with restrictions on how many times an address can mint
contract MaxMintable is ERC721A, Ownable {
    uint256 public maxMintsPerWallet;

    constructor(
        string memory name,
        string memory symbol,
        uint256 _maxMintsPerWallet
    ) ERC721A(name, symbol) {
        maxMintsPerWallet = _maxMintsPerWallet;
    }

    error MaxMintedForWallet();

    modifier checkMaxMintedForWallet(uint256 quantity) {
        // get num minted from ERC721A
        uint256 numMinted = _numberMinted(msg.sender);
        if ((numMinted + quantity) > maxMintsPerWallet) {
            revert MaxMintedForWallet();
        }
        _;
    }

    ///@notice set maxMintsPerWallet. OnlyOwner
    function setMaxMintsPerWallet(uint256 _maxMints) public onlyOwner {
        maxMintsPerWallet = _maxMints;
    }
}
