// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "remix_tests.sol"; // Remix Assert Library

contract Bench {
    uint256 public data;
    event gasRecord(uint256 startGas, uint256 gasUsed);

    function increment() public {
        uint256 startGas = gasleft();
        uint256 dataLocal = data;
        uint256 gasUsed = startGas - gasleft();
        dataLocal += gasUsed;
        data = dataLocal;

        emit gasRecord(startGas, gasUsed);
    }
}

contract TestGasUsed {
    function checkGas() public {
        Bench bench = new Bench();
        bench.increment();
        Assert.equal(bench.data(), 2121, "GAS USED");
    }
}