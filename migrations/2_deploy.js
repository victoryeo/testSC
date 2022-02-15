// migrations/2_deploy.js
// SPDX-License-Identifier: MIT
const instance = artifacts.require("testSC");

module.exports = function(deployer) {
  deployer.deploy(instance);
};