// SPDX-License-Identifier: Unlicense

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/utils/cryptography/ECDSA.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract EIP712Signing is Ownable {
  using ECDSA for bytes32;

  // The key used for signatures.
  // We will check to ensure that the key that signed the signature
  // is this one that we expect.
  address signingKey = address(0);

  // The typehash for the data type specified in the structured data
  // https://github.com/ethereum/EIPs/blob/master/EIPS/eip-712.md#rationale-for-typehash
  // This should match whats in the client side whitelist signing code
  // https://github.com/msfeldstein/EIP712-whitelisting/blob/main/test/signWhitelist.ts#L22
  bytes32 internal constant MINTER_TYPEHASH =
    keccak256(
      "Minter(address wallet,uint256 tokenId,bool usePass,uint256 price,string engraving)"
    );
  bytes32 internal constant DOMAIN_TYPEHASH =
    keccak256(
      "EIP712Domain(string name,string version,uint256 chainId,address verifyingContract)"
    );

  function setSigningAddress(address _signingKey) public onlyOwner {
    signingKey = _signingKey;
  }

  constructor(address _signingKey) {
    signingKey = _signingKey;
  }

  function requireValidSignature(
    address _minter,
    uint256 _tokenId,
    bool usePass,
    uint256 _price,
    string calldata _engraving,
    bytes calldata _signature
  ) internal view {
    require(signingKey != address(0), "Minting not available");

    // Domain Separator is the EIP-712 defined structure that defines what contract
    // and chain these signatures can be used for.  This ensures people can't take
    // a signature used to mint on one contract and use it for another, or a signature
    // from testnet to replay on mainnet.
    // It has to be created in the constructor so we can dynamically grab the chainId.
    // https://github.com/ethereum/EIPs/blob/master/EIPS/eip-712.md#definition-of-domainseparator
    bytes32 domainSeparator = keccak256(
      abi.encode(
        DOMAIN_TYPEHASH,
        // This should match the domain you set in your client side signing.
        keccak256(bytes("WatchfacesWorld")),
        keccak256(bytes("1")),
        block.chainid,
        address(this)
      )
    );

    // Verify EIP-712 signature by recreating the data structure
    // that we signed on the client side, and then using that to recover
    // the address that signed the signature for this data.
    bytes32 digest = keccak256(
      abi.encodePacked(
        "\x19\x01",
        domainSeparator,
        keccak256(
          abi.encode(
            MINTER_TYPEHASH,
            _minter,
            _tokenId,
            usePass,
            _price,
            keccak256(bytes(_engraving))
          )
        )
      )
    );
    // Use the recover method to see what address was used to create
    // the signature on this data.
    // Note that if the digest doesn't exactly match what was signed we'll
    // get a random recovered address.
    address recoveredAddress = digest.recover(_signature);
    require(recoveredAddress == signingKey, "Invalid Signature");
  }
}
