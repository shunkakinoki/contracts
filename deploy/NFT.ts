import type { HardhatRuntimeEnvironment } from "hardhat/types";

import type { NFT } from "@/typechain/NFT";

const deploy = async ({
  getNamedAccounts,
  deployments,
  ethers,
}: HardhatRuntimeEnvironment) => {
  // eslint-disable-next-line @typescript-eslint/unbound-method
  const { deploy } = deployments;
  const { deployer } = await getNamedAccounts();
  await deploy("NFT", {
    args: [],
    from: deployer,
    log: true,
  });

  const nftFactory = await ethers.getContractFactory("NFT");
  const nft: NFT = await nftFactory.deploy();
  await nft.deployed();
};

deploy.tags = ["NFT"];

export default deploy;
