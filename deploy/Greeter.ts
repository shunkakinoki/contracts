import type { HardhatRuntimeEnvironment } from "hardhat/types";

import type { Greeter } from "@shunkakinoki/typechain/contracts/Greeter/src/Greeter";
import type { Greeter__factory } from "@shunkakinoki/typechain/factories/contracts/Greeter/src/Greeter__factory";

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
  await deploy("Greeter", {
    args: ["Hello World"],
    from: deployer,
    log: true,
  });

  const greeterFactory = (await ethers.getContractFactory(
    "Greeter",
  )) as Greeter__factory;
  const greeter: Greeter = await greeterFactory.deploy("Hello from Greeter");
  await greeter.deployed();
};

deploy.tags = ["Greeter"];

export default deploy;
