import type { DeployFunction } from "hardhat-deploy/types";
import type { HardhatRuntimeEnvironment } from "hardhat/types";

import type { LightOrb } from "@shunkakinoki/typechain/contracts/LightOrb/src/LightOrb";
import type { LightOrb__factory } from "@shunkakinoki/typechain/factories/contracts/LightOrb/src/LightOrb__factory";

const deploy: DeployFunction = async ({
  getNamedAccounts,
  deployments,
  ethers,
  network,
}: HardhatRuntimeEnvironment) => {
  if (network.name === "hardhat") {
    return;
  }

  const { deploy } = deployments;
  const { BigNumber } = ethers;

  const { deployer } = await getNamedAccounts();
  const LightOrbContract = await deploy("LightOrb", {
    from: deployer,
    log: true,
    gasPrice: BigNumber.from(3000000000),
  });

  const LightOrbFactory = (await ethers.getContractFactory(
    "LightOrb",
  )) as LightOrb__factory;
  const LightOrb: LightOrb = LightOrbFactory.attach(LightOrbContract.address);

  console.log("LightOrb airdrop");
  const txAirdrop = await LightOrb.airdrop([
    "0x4fd9D0eE6D6564E80A9Ee00c0163fC952d0A45Ed",
  ]);
  const receiptTxAirdrop = await txAirdrop.wait();
  console.log(JSON.stringify(receiptTxAirdrop, null, 4));
};

deploy.tags = ["LightOrb"];

export default deploy;
