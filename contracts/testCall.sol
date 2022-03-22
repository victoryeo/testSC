// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Receiver {
  uint public num;
  event Received(address caller, uint amount, string message, uint arg);

  fallback() external payable {
    num = 1;
    emit Received(msg.sender, msg.value, "Fallback was called", 1);
  }

  receive() external payable {
    emit Received(msg.sender, msg.value, "receive was called", 1);
  }

  function foo(string memory _message, uint _x) public payable returns (uint) {
    // this statement below causes low level call to fail
    num = _x;

    emit Received(msg.sender, msg.value, _message, _x);
    return _x+1;
  }
}

contract Caller {
  uint public num;
  event Response(bool success, bytes data);

  // Let's imagine that contract B does not have the source code for
  // contract A, but we do know the address of A and the function to call.
  function testCallFoo(address payable _addr) public payable {
    // You can send ether and specify a custom gas amount
    (bool success, bytes memory data) = _addr.call{value: msg.value, gas: 5000}(
      abi.encodeWithSignature("foo(string,uint256)", "call foo", 123)
    );

    emit Response(success, data);
  }

  // Calling a function that does not exist triggers the fallback function.
  function testCallDoesNotExist(address _addr) public {
    (bool success, bytes memory data) = _addr.call(
      abi.encodeWithSignature("doesNotExist()")
    );

    emit Response(success, data);
  }
}