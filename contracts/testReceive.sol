// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract TestSend {
 function send(address payable _receiver) external payable {
     _receiver.transfer(msg.value);
 }
}

contract TestReceive {
    event Deployed(address addr);
    event Received(address, uint);
    uint y;

    constructor() {
    }

    receive() external payable {
        emit Received(msg.sender, msg.value);
    }

    fallback() external payable { 
        y = msg.value; 
    }
}