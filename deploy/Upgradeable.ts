import type { HardhatRuntimeEnvironment } from "hardhat/types";

import type { Upgradeable } from "@shunkakinoki/typechain/contracts/Upgradeable/src/Upgradeable";
import type { Upgradeable__factory } from "@shunkakinoki/typechain/factories/contracts/Upgradeable/src/Upgradeable__factory";

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

  const upgradeableFactory = (await ethers.getContractFactory(
    "Upgradeable",
  )) as Upgradeable__factory;
  const upgradeable: Upgradeable = await upgradeableFactory.deploy();
  await upgradeable.deployed();
};

deploy.tags = ["Upgradeable"];

export default deploy;
