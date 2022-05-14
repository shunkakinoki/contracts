import fs from "fs";
import path from "path";

import { boot } from "./boot";
import { call } from "./call";
import { compile } from "./compile";
import { deploy } from "./deploy";
import { serve } from "./serve";

const SOURCE = path.join(process.cwd(), "src", "Renderer.sol");

async function main() {
  const { vm, pk } = await boot();

  async function handler() {
    const { abi, bytecode } = compile(SOURCE);
    const address = await deploy(vm, pk, bytecode);
    const result = await call(vm, address, abi, "example");
    return result;
  }

  const { notify } = await serve(handler);

  fs.watch(path.dirname(SOURCE), notify);
  console.log("Watching", path.dirname(SOURCE));
  console.log("Serving  http://localhost:9901/");
}

void main();
