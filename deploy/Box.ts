import { upgrades } from "hardhat";
import type { HardhatRuntimeEnvironment } from "hardhat/types";

import type { Box } from "@/typechain/Box";

const deploy = async ({ ethers, network }: HardhatRuntimeEnvironment) => {
  if (network.name === "hardhat") {
    return;
  }

  const BoxContract = await ethers.getContractFactory("Box");
  const box = (await upgrades.deployProxy(BoxContract, [42], {
    initializer: "initialize",
  })) as Box;
  await box.deployed();

  console.log("Box Proxy deployed to:", box.address);
};

deploy.tags = ["NFT"];

export default deploy;
