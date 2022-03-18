// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract TestSend {
  function send(address payable _receiver) external payable {
    // no longer recommended to use
     _receiver.transfer(msg.value);
  }

  function callSend(address payable _receiver) external payable {
    // current recommended method to send ether
    (bool success, ) = payable(_receiver).call{
        value: msg.value,
        gas: 5000
    }("");
    require(success, "Failed to send ether");
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