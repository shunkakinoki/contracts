module.exports = {
  ...require("@shunkakinoki/lint-staged"),
  "*.sol": ["yarn run lint:solhint"],
};
