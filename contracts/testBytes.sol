// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract StorageBytes {
    bytes  valBytes;
    address public my_address;
    bytes public goon = new bytes(10);
    bytes[] public hklid;

    function fill_hklid(bytes memory _arg) public {
      hklid.push(_arg);
      goon = _arg;
    }

    function getBytes() public view returns(bytes memory) {
        return valBytes;
    }

    //0x98
    function setBytes(bytes1 _val) public returns(bytes memory) {
        valBytes.push(bytes1(_val));
        return valBytes;
    }

    //0x666f6f0000000000000000000000000000000000000000000000000000000000, 10
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

    //0x666f6f0000000000000000000000000000000000000000000000000000000000, 1
    function accessByte(
        bytes32 _number_in_hex, 
        uint8 _index
    ) public pure returns (bytes1) {
        bytes1 value = _number_in_hex[_index];
        return value;
    }

    //0x666f6f0000000000000000000000000000000000
    function bytesToAddress(bytes20 input) public returns (address) {
        my_address = address(input);
        return my_address;
    }
}