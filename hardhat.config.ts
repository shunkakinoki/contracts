import * as dotenv from "dotenv";

import { removeConsoleLog } from "hardhat-preprocessor";
import { TASK_COMPILE_SOLIDITY_GET_SOURCE_PATHS } from "hardhat/builtin-tasks/task-names";
import type { HardhatUserConfig } from "hardhat/config";
import "@nomiclabs/hardhat-ethers";
import "@nomiclabs/hardhat-etherscan";
import "@openzeppelin/hardhat-upgrades";
import "@typechain/hardhat";
import "hardhat-abi-exporter";
import "hardhat-deploy";
import "hardhat-gas-reporter";
import "hardhat-spdx-license-identifier";
import "hardhat-watcher";
import { subtask } from "hardhat/config";

const EXCLUDED_CONTRACT_PATHS = ["Shrine"];

subtask(TASK_COMPILE_SOLIDITY_GET_SOURCE_PATHS).setAction(
  async (_, __, runSuper) => {
    const paths = await runSuper();

    // eslint-disable-next-line @typescript-eslint/no-explicit-any
    return paths.filter((p: any) => {
      if (
        EXCLUDED_CONTRACT_PATHS.some(substring => {
          return p.includes(substring);
        })
      ) {
        return false;
      }
      return !p.endsWith(".t.sol");
    });
  },
);

dotenv.config();

const accounts =
  process.env.WALLET_PRIVATE_KEY !== undefined
    ? [process.env.WALLET_PRIVATE_KEY]
    : [];

const config: HardhatUserConfig = {
  solidity: "0.8.13",
  defaultNetwork: "hardhat",
  namedAccounts: {
    deployer: {
      default: 0,
    },
  },
  networks: {
    localhost: {
      live: false,
      saveDeployments: true,
      tags: ["local"],
    },
    hardhat: {
      forking: {
        enabled: process.env.FORKING === "true",
        url: `${process.env.ALCHEMY_MAINNET_URL}`,
      },
      live: false,
      saveDeployments: true,
    },
    mainnet: {
      url: `https://mainnet.infura.io/v3/${process.env.INFURA_PROJECT_ID}`,
      accounts: accounts,
      saveDeployments: true,
    },
    rinkeby: {
      url: `https://rinkeby.infura.io/v3/${process.env.INFURA_PROJECT_ID}`,
      accounts: accounts,
      saveDeployments: true,
      tags: ["staging"],
      gasMultiplier: 2,
    },
    ropsten: {
      url: `https://ropsten.infura.io/v3/${process.env.INFURA_PROJECT_ID}`,
      accounts: accounts,
      saveDeployments: true,
      tags: ["staging"],
      gasMultiplier: 2,
    },
    polygon: {
      url: `https://polygon-mainnet.infura.io/v3/${process.env.INFURA_PROJECT_ID}`,
      accounts: accounts,
      saveDeployments: true,
    },
    munbai: {
      url: `https://polygon-mumbai.infura.io/v3/${process.env.INFURA_PROJECT_ID}`,
      accounts: accounts,
      saveDeployments: true,
      tags: ["staging"],
      gasMultiplier: 2,
    },
    arbitrum: {
      url: `https://arbitrum-mainnet.infura.io/v3/${process.env.INFURA_PROJECT_ID}`,
      accounts: accounts,
      saveDeployments: true,
    },
    arbitrumRinkeby: {
      url: `https://arbitrum-rinkeby.infura.io/v3/${process.env.INFURA_PROJECT_ID}`,
      accounts: accounts,
      saveDeployments: true,
      tags: ["staging"],
    },
    xdai: {
      url: "https://rpc.xdaichain.com/",
      accounts: accounts,
      saveDeployments: true,
    },
    avalanche: {
      url: "https://api.avax.network/ext/bc/C/rpc",
      gasPrice: 225000000000,
      chainId: 43114,
      accounts: accounts,
      saveDeployments: true,
    },
    fuji: {
      url: "https://api.avax-test.network/ext/bc/C/rpc",
      gasPrice: 225000000000,
      chainId: 43113,
      accounts: accounts,
      saveDeployments: true,
      tags: ["staging"],
    },
    harmony: {
      url: "https://api.harmony.one",
      gasPrice: 1000000000,
      chainId: 1666600000,
      accounts: accounts,
      saveDeployments: true,
    },
    "harmony-testnet": {
      url: "https://api.s0.b.hmny.io",
      gasPrice: 1000000000,
      chainId: 1666700000,
      accounts: accounts,
      saveDeployments: true,
      tags: ["staging"],
      gasMultiplier: 2,
    },
    fantom: {
      url: "https://rpcapi.fantom.network",
      accounts: accounts,
      chainId: 250,
      saveDeployments: true,
      gasPrice: 22000000000,
    },
    "fantom-testnet": {
      url: "https://rpc.testnet.fantom.network",
      accounts: accounts,
      chainId: 4002,
      saveDeployments: true,
      tags: ["staging"],
      gasMultiplier: 2,
    },
    bsc: {
      url: "https://bsc-dataseed.binance.org",
      accounts: accounts,
      chainId: 56,
      saveDeployments: true,
    },
    "bsc-testnet": {
      url: "https://data-seed-prebsc-2-s3.binance.org:8545",
      accounts: accounts,
      chainId: 97,
      saveDeployments: true,
      tags: ["staging"],
      gasMultiplier: 2,
    },
    moonriver: {
      url: "https://rpc.moonriver.moonbeam.network",
      accounts: accounts,
      chainId: 1285,
      saveDeployments: true,
    },
    moonbase: {
      url: "https://rpc.testnet.moonbeam.network",
      accounts: accounts,
      chainId: 1287,
      saveDeployments: true,
      tags: ["staging"],
      gas: 5198000,
      gasMultiplier: 2,
    },
  },
  paths: {
    artifacts: "artifacts",
    cache: "cache",
    deploy: "deploy",
    deployments: "deployments",
    imports: "imports",
    sources: "contracts",
    tests: "test",
  },
  abiExporter: {
    path: "./abi",
    clear: true,
  },
  gasReporter: {
    enabled: true,
    coinmarketcap: process.env.COINMARKETCAP_API_KEY,
    currency: "USD",
  },
  etherscan: {
    apiKey: process.env.ETHERSCAN_API_KEY,
  },
  typechain: {
    outDir: "typechain",
    target: "ethers-v5",
    alwaysGenerateOverloads: true,
  },
  preprocess: {
    eachLine: removeConsoleLog(bre => {
      return bre.network.name !== "hardhat" && bre.network.name !== "localhost";
    }),
  },
  spdxLicenseIdentifier: {
    overwrite: false,
    runOnCompile: true,
  },
  watcher: {
    compile: {
      tasks: ["compile"],
      files: ["./contracts"],
      verbose: true,
    },
  },
};

export default config;
