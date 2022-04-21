// SPDX-License-Identifier: MIT
pragma solidity >0.6.0;

contract Storage {
  address private owner;
  uint256 number;
  
  constructor() {
    owner = msg.sender;
  }
 
  function store(uint256 num) public {
    number = num;
  }

  function retrieve() public view returns (uint256){
    return number;
  }
 
  function close() public { 
    address payable addr = payable(address(owner));
    selfdestruct(addr);
  }
}