// SPDX-License-Identifier: MIT
pragma solidity >0.6.0;

contract Storage {
  address private owner;
  uint256 number;
  event LogOwner(address owner);

  constructor() {
    owner = msg.sender;
    emit LogOwner(owner);
  }
 
  function store(uint256 num) public {
    number = num;
  }

  function retrieve() public view returns (uint256){
    return number;
  }
 
  function close() public {
    //call selfdestruct(target) and force ether to be sent to a target.
    address payable addr = payable(address(owner));
    selfdestruct(addr);
  }
}