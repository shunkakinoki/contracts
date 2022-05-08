module.exports = {
  extends: "@shunkakinoki",
  ignorePatterns: ["**/contracts/**/*.sol"],
  rules: {
    "@typescript-eslint/no-unsafe-argument": "off",
    "@typescript-eslint/no-unsafe-call": "off",
    "@typescript-eslint/unbound-method": "off",
  },
};
