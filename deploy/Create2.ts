import type { HardhatRuntimeEnvironment } from "hardhat/types";

import type { Create2Factory } from "@shunkakinoki/typechain/contracts/Create2/src/Create2.sol/Create2Factory";
import type { Create2Factory__factory } from "@shunkakinoki/typechain/factories/contracts/Create2/src/Create2.sol/Create2Factory__factory";

const deploy = async ({
  getNamedAccounts,
  deployments,
  ethers,
}: HardhatRuntimeEnvironment) => {
  // eslint-disable-next-line @typescript-eslint/unbound-method
  const { deploy } = deployments;
  const { deployer } = await getNamedAccounts();
  await deploy("Create2Factory", {
    args: [],
    from: deployer,
    log: true,
  });

  const create2Factory = (await ethers.getContractFactory(
    "Create2Factory",
  )) as Create2Factory__factory;
  const factory: Create2Factory = await create2Factory.deploy();
  await factory.deployed();

  const deployedBytecode = await factory.getBytecode(deployer, 1);
  const deployedAddress = await factory.getAddress(deployedBytecode, 123);

  console.log(deployedAddress);
};

deploy.tags = ["Create2"];

export default deploy;
