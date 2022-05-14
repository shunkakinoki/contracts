// Code from: https://github.com/FredCoen/cryptotesters-merkle-whitelist-nft/blob/master/index.js

import keccak256 from "keccak256";
import { MerkleTree } from "merkletreejs";

// Input whitelist adresses
const whiteList = ["address_one", "address_two", "address_three"];

const leaves = whiteList.map(address => {
  return keccak256(address);
});
const tree = new MerkleTree(leaves, keccak256, { sortPairs: true });

const leaf = "address_two";
const proof = tree.getHexProof(keccak256(leaf));
console.log("Merkle root:", tree.getHexRoot());
console.log("Merkle proof:", proof);
