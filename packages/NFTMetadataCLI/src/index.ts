import * as dotenv from "dotenv";
import { ethers } from "ethers";

dotenv.config();

const WEB3_ENDPOINT = `https://ropsten.infura.io/v3/${process.env.INFURA_PROJECT_ID}`;

const handleError = () => {
  return undefined;
};

const getTokenMetadata = async (address: string) => {
  const abi = [
    "function tokenURI() view returns (string name)",
    "function symbol() view returns (string symbol)",
    "function totalSupply() view returns (uint256 totalSupply)",
  ];
  const { JsonRpcProvider } = ethers.providers;
  const { BigNumber } = ethers;
  const provider = new JsonRpcProvider(WEB3_ENDPOINT);

  const contract = new ethers.Contract(address, abi, provider);
  const [tokenURI, symbol, totalSupplyBigNumber] = await Promise.all([
    contract.tokenURI(1).catch(handleError),
    contract.symbol().catch(handleError),
    contract.totalSupply().catch(handleError),
  ]);
  const totalSupply = BigNumber.from(totalSupplyBigNumber).toNumber();
  return { tokenURI, symbol, totalSupply };
};

void (async () => {
  void console.log(
    await getTokenMetadata("0x9c7eafd6b1ac93040b8a08336af601d80e64c9ca"),
  );
})();
