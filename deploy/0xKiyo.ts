import type { HardhatRuntimeEnvironment } from "hardhat/types";

import type { KiyoSanBirthday } from "@/typechain/KiyoSanBirthday";

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
  await deploy("NFT", {
    args: [],
    from: deployer,
    log: true,
  });

  const nftFactory = await ethers.getContractFactory("KiyoSanBirthday");
  const nft: KiyoSanBirthday = await nftFactory.deploy(
    "https://0xkiyo.xyz/metadata/",
  );
  await nft.deployed();
};

deploy.tags = ["0xKiyo"];

export default deploy;
