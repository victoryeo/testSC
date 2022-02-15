// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract testStore {
  struct Soon { 
    uint128 a; 
    uint128 b; 
  }
  Soon testSoon;
  bytes32 storeValue;
  
  function assemblyStorage() public returns (uint a, uint b, uint c, uint d, uint e, uint f){
    testSoon = Soon(5,10);
    assembly {
      let w := sload(0)
      a := and(w, 0xffffffffffffffffffffffffffffffff)
      b := shr(128, w)
    }
  }

  function encode(uint64 _a, uint64 _b, uint64 _c, uint64 _d) public returns (bytes32 x) {
    assembly {
        mstore(0x20, _d)
        mstore(0x18, _c)
        mstore(0x10, _b)
        mstore(0x8, _a)
        x := mload(0x20)
    }
    storeValue = x;
  }

  function getStoreValue() public view returns (bytes32) {
    return storeValue;
  }

  function decode() public view returns (uint64 a, uint64 b, uint64 c, uint64 d) {
    assembly {
        let x := sload(storeValue.slot)
        mstore(0x18, x)
        d := mload(0)
        mstore(0x10, x)
        c := mload(0)
        mstore(0x8, x)
        b := mload(0)
        mstore(0x0, x)
        a := mload(0)
    }
  }
}