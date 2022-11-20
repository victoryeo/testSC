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

  // this function will call fallback()
  //         is msg.data empty?
  //            /        \
  //           yes        no
  //          /             \
  //  receive() exists?    is the function selector there?
  //      /  \             /      \
  //    yes   no          no      yes
  //    /       \        /          \
  // receive()  fallback()        function_to_call()
  function callFallback(address payable _receiver) external payable {
    (bool success, ) = payable(_receiver).call{
        value: msg.value,
        gas: 5000
    }(abi.encodeWithSignature('myfunction(uint)', 400));  //pass in msg.data
    require(success, "Failed to send ether");
  }
}

contract TestReceive {
    event Deployed(address addr);
    event Received(address, uint);
    event Fallbacked(address, uint);
    uint y;

    constructor() {
    }

    receive() external payable {
        emit Received(msg.sender, msg.value);
    }

    fallback() external payable { 
        emit Fallbacked(msg.sender, msg.value);
        y = msg.value; 
    }
}