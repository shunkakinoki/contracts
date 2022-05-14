/* eslint-disable @typescript-eslint/restrict-plus-operands */

import fs from "fs";
import os from "os";
import path from "path";

import { DOMParser } from "xmldom";

import { boot } from "./boot";
import { call } from "./call";
import { compile } from "./compile";
import { deploy } from "./deploy";

const SOURCE = path.join(process.cwd(), "src", "Renderer.sol");
const DESTINATION = path.join(os.tmpdir(), "hot-chain-svg-");

const main = async () => {
  const { vm, pk } = await boot();
  const { abi, bytecode } = compile(SOURCE);
  const address = await deploy(vm, pk, bytecode);

  const tempFolder = fs.mkdtempSync(DESTINATION);
  console.log("Saving to", tempFolder);

  for (let i = 1; i < 256; i++) {
    const fileName = path.join(tempFolder, i + ".svg");
    console.log("Rendering", fileName);
    const svg = await call(vm, address, abi, "render", [i]);
    fs.writeFileSync(fileName, svg);

    // Throws on invalid XML
    new DOMParser().parseFromString(svg);
  }
};

main().catch(error => {
  console.error(error);
  process.exit(1);
});
