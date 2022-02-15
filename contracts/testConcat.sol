// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract testConcat {
    string public a;
    string public b;

    function exFunction1 () external {
        a = string(abi.encode("hello", " world"));
        b = string(abi.encodePacked("hello", " world"));
    }

    function exFunction2 () external {
        bool y=true;
        a = string(abi.encode(y, " world"));
        b = string(abi.encodePacked(y, " world"));
    }

    function exFunction3 () external {
        bool y=true;
        uint256 nonce=123;
        a = string(abi.encode(y, nonce));
        b = string(abi.encodePacked(y, nonce));
    }

    function getValue() public view returns (string memory, string memory) {
      return (a, b);
    }

    
}