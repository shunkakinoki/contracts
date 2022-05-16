import * as dotenv from "dotenv";
import { ethers } from "ethers";

dotenv.config();

const WEB3_ENDPOINT = `https://ropsten.infura.io/v3/${process.env.INFURA_PROJECT_ID}`;

const handleError = (err: Error) => {
  return console.error(err);
};

const getTokenMetadata = async (address: string) => {
  const abi = [
    "function tokenURI(uint256 _tokenId) external view returns (string)",
    "function ownerOf(uint256 _tokenId) external view returns (address)",
    "function symbol() view returns (string symbol)",
    "function totalSupply() view returns (uint256 totalSupply)",
  ];
  const { JsonRpcProvider } = ethers.providers;
  const { BigNumber } = ethers;
  const provider = new JsonRpcProvider(WEB3_ENDPOINT);

  const contract = new ethers.Contract(address, abi, provider);
  const [tokenURI, ownerOf, symbol, totalSupplyBigNumber] = await Promise.all([
    contract.tokenURI(0).catch(handleError),
    contract.ownerOf(0).catch(handleError),
    contract.symbol().catch(handleError),
    contract.totalSupply().catch(handleError),
  ]);
  const totalSupply = BigNumber.from(totalSupplyBigNumber).toNumber();
  return { tokenURI, ownerOf, symbol, totalSupply };
};

void (async () => {
  void console.log(
    await getTokenMetadata("0x15477F1885723bAF05ab2De5717cE287A56f5B5f"),
  );
})();
