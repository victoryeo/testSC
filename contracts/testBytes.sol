// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract StorageBytes {
    bytes  valBytes;
    address public my_address;

    function getBytes() public view returns(bytes memory) {
        return valBytes;
    }

    function setBytes(bytes1 _val) public returns(bytes memory) {
        valBytes.push(bytes1(_val));
        return valBytes;
    }

    function leftShiftBinary(
        bytes32 a, 
        uint n
    ) public pure returns (bytes32) {
        return a << n;
    }

    function rightShiftBinary2(
        bytes32 a, 
        uint n
    ) public pure returns (bytes32) {
        return a >> n;
    }

    function accessByte(
        bytes32 _number_in_hex, 
        uint8 _index
    ) public pure returns (bytes1) {
        bytes1 value = _number_in_hex[_index];
        return value;
    }

    function bytesToAddress(bytes20 input) public returns (address) {
        my_address = address(input);
        return my_address;
    }
}