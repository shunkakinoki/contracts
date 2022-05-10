import { upgrades } from "hardhat";
import type { HardhatRuntimeEnvironment } from "hardhat/types";

import type { Box__factory } from "@shunkakinoki/typechain/factories/contracts/Box/src/Box__factory";

const deploy = async ({ ethers, network }: HardhatRuntimeEnvironment) => {
  if (network.name === "hardhat") {
    return;
  }

  const BoxContract = (await ethers.getContractFactory("Box")) as Box__factory;
  const box = await upgrades.deployProxy(BoxContract, [42], {
    initializer: "initialize",
  });
  await box.deploy();

  console.log("Box Proxy deployed to:", box.address);
};

deploy.tags = ["NFT"];

export default deploy;
