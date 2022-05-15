// Code from: https://github.com/FredCoen/cryptotesters-merkle-whitelist-nft/blob/master/index.js

import * as dotenv from "dotenv";
import { ethers } from "ethers";

dotenv.config();

const WEB3_ENDPOINT = `https://ropsten.infura.io/v3/${process.env.INFURA_PROJECT_ID}`;

const handleError = () => {
  return undefined;
};

const getTokenMetadata = async (address: string) => {
  const abi = [
    "function name() view returns (string name)",
    "function symbol() view returns (string symbol)",
    "function decimals() view returns (uint8 decimals)",
  ];
  const { JsonRpcProvider } = ethers.providers;
  const provider = new JsonRpcProvider(WEB3_ENDPOINT);

  const contract = new ethers.Contract(address, abi, provider);
  const [name, symbol, decimals] = await Promise.all([
    contract.name().catch(handleError),
    contract.symbol().catch(handleError),
    contract.decimals().catch(handleError),
  ]);
  return { decimals, name, symbol };
};

void (async () => {
  void console.log(
    await getTokenMetadata("0x9c7eafd6b1ac93040b8a08336af601d80e64c9ca"),
  );
})();
