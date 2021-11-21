import { task } from "hardhat/config";
import type { TaskArguments } from "hardhat/types";

task("deploy:Greeter")
  .addParam("greeting", "Say hello, be nice")
  .setAction(async (taskArguments: TaskArguments, { ethers }) => {
    const greeterFactory = await ethers.getContractFactory("Greeter");
    const greeter = await greeterFactory.deploy(taskArguments.greeting);
    await greeter.deployed();
    console.log("Greeter deployed to: ", greeter.address);
  });
