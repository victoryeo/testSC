// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/proxy/Clones.sol";

contract MyContract {
    string public name;
    address public owner;

    function initialize(string memory _name) public {
        require(bytes(name).length == 0, "Already initialized");
        name = _name;
        owner = msg.sender;
    }

    function updateName(string memory _newName) public {
        require(msg.sender == owner, "Not the owner");
        name = _newName;
    }
}

contract MyContractFactory {
    // Address of the original contract
    address public implementation;

    constructor(address _implementation) {
        implementation = _implementation;
    }

    function createClone(string memory _name) public returns (address) {
        // Create a clone of the MyContract
        address clone = Clones.clone(implementation);
        // Initialize the clone with the constructor parameters
        (bool success, ) = clone.call(abi.encodeWithSignature("initialize(string)", _name));
        require(success, "Clone initialization failed");
        return clone;
    }

    function at(address _addr) public view returns (bytes memory o_code) {
    assembly {
      // retrieve the size of the code, this needs assembly
      let size := extcodesize(_addr)
      // allocate output byte array - this could also be done without assembly
      // by using o_code = new bytes(size)
      o_code := mload(0x40)
      // new "memory end" including padding
      mstore(0x40, add(o_code, and(add(add(size, 0x20), 0x1f), not(0x1f))))
      // store length in memory
      mstore(o_code, size)
      // actually retrieve the code, this needs assembly
      extcodecopy(_addr, add(o_code, 0x20), 0, size)
    }
  }
}