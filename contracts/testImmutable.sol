// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract TestImmutable {
    uint256 immutable public holde;
    uint256 constant public fixo = 9;
    uint256 public changeo = 1;

    constructor() {
        holde = 20;
    }

    function setValue(uint256 arg) public {
        changeo = arg;
    }
}
