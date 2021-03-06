/* eslint-disable import/no-anonymous-default-export */

export default function (plop) {
  plop.setGenerator("addAndNameFile", {
    description: "Name that file",
    prompts: [
      {
        type: "input",
        name: "name",
        message: "What should the file name be?",
      },
    ],
    actions: [
      {
        type: "add",
        path: "./contracts/{{name}}/package.json",
        templateFile: "./templates/package.json.template",
      },
      {
        type: "add",
        path: "./contracts/{{name}}/src/{{name}}.sol",
        templateFile: "./templates/Greeter.sol.template",
      },
      {
        type: "add",
        path: "./contracts/{{name}}/src/tests/{{name}}.t.sol",
        templateFile: "./templates/Test.t.sol.template",
      },
    ],
  });
}
