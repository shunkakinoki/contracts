import type { HardhatRuntimeEnvironment } from "hardhat/types";

import type { Greeter } from "@/typechain/Greeter";

const deploy = async ({
  getNamedAccounts,
  deployments,
  ethers,
  network,
}: HardhatRuntimeEnvironment) => {
  if (network.name !== "hardhat") {
    return;
  }

  // eslint-disable-next-line @typescript-eslint/unbound-method
  const { deploy } = deployments;
  const { deployer } = await getNamedAccounts();
  await deploy("Greeter", {
    args: ["Hello World"],
    from: deployer,
    log: true,
  });

  const greeterFactory = await ethers.getContractFactory("Greeter");
  const greeter: Greeter = await greeterFactory.deploy("Hello from Greeter");
  await greeter.deployed();
};

deploy.tags = ["Greeter"];

export default deploy;
