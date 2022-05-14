import fs from "fs";
import path from "path";

import solc from "solc";

const getSolcInput = source => {
  return {
    language: "Solidity",
    sources: {
      [path.basename(source)]: {
        content: fs.readFileSync(source, "utf8"),
      },
    },
    settings: {
      optimizer: {
        enabled: false,
        runs: 1,
      },
      evmVersion: "london",
      outputSelection: {
        "*": {
          "*": ["abi", "evm.bytecode"],
        },
      },
    },
  };
};

const findImports = path => {
  try {
    const file = fs.existsSync(path)
      ? fs.readFileSync(path, "utf8")
      : fs.readFileSync(require.resolve(path), "utf8");
    return { contents: file };
  } catch (error) {
    console.error(error);
    return { error };
  }
};

export const compile = source => {
  const input = getSolcInput(source);
  process.chdir(path.dirname(source));
  const output = JSON.parse(
    solc.compile(JSON.stringify(input), { import: findImports }),
  );

  const errors = [];

  if (output.errors) {
    for (const error of output.errors) {
      if (error.severity === "error") {
        errors.push(error.formattedMessage);
      }
    }
  }

  if (errors.length > 0) {
    throw new Error(errors.join("\n\n"));
  }

  const result = output.contracts[path.basename(source)];
  const contractName = Object.keys(result)[0];
  return {
    abi: result[contractName].abi,
    bytecode: result[contractName].evm.bytecode.object,
  };
};
