// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract testAssembly {
    struct S { 
        uint128 e; 
        uint128 f; 
    }
    S test1;

    string public a;
    string public b;
    string public c;
    address owner;
    event OWNER_LOG(address owner);

    constructor() {
      owner = msg.sender;
      emit OWNER_LOG(owner);
    }

    function sloadAssembly() public returns (uint aret, uint bret) {
        // load from storage slot 0
        test1 = S(5,10);
        assembly {
            let w:= sload(0)
            aret := and(w, 0xffffffffffffffffffffffffffffffff)
            bret := shr(128, w)
        }
    }

    function addAssembly(uint x, uint y) public pure returns (uint) {
        assembly {
            // Create a new variable `result`
            //     -> calculate the sum of `x + y` with the `add` opcode
            //     -> assign the value to `result`
            let result := add(x, y)
            // Use the `mstore` opcode, to:
            //     -> store `result` in memory
            //     -> at memory address 0x0
            mstore(0x0, result)
            // return 32 bytes from memory address 0x0
            return(0x0, 32)
        }
    }
    
    function addSolidity(uint x, uint y) public pure returns (uint) {
        return x + y;
    }

    function subKeccak() public pure returns (uint) {
        assembly {
            let x:=7
            let y:= add(x,3)
            let z := sub(keccak256(0x0, 0x10), div(1, 32))
            let result:= add(y , z)
            mstore(0x0, result)
            return (0x0, 32)
        }
    }

    function allocate() public pure returns (uint) {
        assembly {
            function allocate(length) -> pos {
                // load from position 0x40
                // 0x40 position contains the free memory pointer address
                pos := mload(0x40)
                // update 0x40 with new value of free memory pointer
                mstore(0x40, add(pos, length))
            }
            let free_memory_ptr := allocate(128)
            mstore(0x0, free_memory_ptr)
            return (0x0, 32)
        }
    }
}