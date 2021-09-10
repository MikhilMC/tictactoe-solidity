const tic_tac_toe = artifacts.require("tic_tac_toe");

module.exports = function(_deployer) {
  _deployer.deploy(tic_tac_toe);
};
