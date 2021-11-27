import type { HardhatRuntimeEnvironment } from "hardhat/types";

import type { Upgradeable } from "@/typechain/Upgradeable";

const deploy = async ({
  getNamedAccounts,
  deployments,
  ethers,
  network,
}: HardhatRuntimeEnvironment) => {
  if (network.name === "hardhat") {
    return;
  }

  // eslint-disable-next-line @typescript-eslint/unbound-method
  const { deploy } = deployments;
  const { deployer } = await getNamedAccounts();
  await deploy("Upgradeable", {
    args: [],
    from: deployer,
    log: true,
  });

  const upgradeableFactory = await ethers.getContractFactory("Upgradeable");
  const upgradeable: Upgradeable = await upgradeableFactory.deploy();
  await upgradeable.deployed();
};

deploy.tags = ["Upgradeable"];

export default deploy;
