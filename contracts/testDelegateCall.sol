// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// NOTE: Deploy this contract first
contract B {
  // NOTE: storage layout must be the same as contract A
  uint public num;
  address public sender;
  uint public value;
  event DELEGATE_BLOG(uint, uint);

  function setVars(uint _num) public payable {
    num = _num;
    sender = msg.sender;
    value = msg.value;
    emit DELEGATE_BLOG(_num, num);
  }
}

// NOTE: Deploy this contract next
contract A {
  uint public num;
  address public sender;
  uint public value;
  event DELEGATE_ALOG(bool, bytes, uint);

  // Note: Pass in B's address to this function
  function setVars(address _contract, uint _num) public payable {
    // A's storage is set, B is not modified.
    (bool success, bytes memory data) = _contract.delegatecall(
      abi.encodeWithSignature("setVars(uint256)", _num)
    );
    emit DELEGATE_ALOG(success, data, num);
  }
}