//SPDX-License-Identifier: MIT
pragma solidity 0.8.4;

contract FunctionFallback {

    uint256 public globalsize;
    struct DiamondStorage {
        uint256 param1;
        //address[] facetAddresses;
        //mapping(bytes4 => bool) supportedInterfaces;
    }
    event LogSelector(bytes4, uint256);

	fallback() external {
        DiamondStorage storage ds;
        // Assuming the first 4 bytes of calldata are the function selector
        uint256 sourceLocation = 0x4;
        uint256 size = 32;
        uint256 tmpstr = 0;

        assembly {
            ds.slot := 1
            calldatacopy(0, sourceLocation, size)
            tmpstr := mload(0)
        }
        // it will emit msg.sig of 0 because
        // fallback function signature is 0
		emit LogSelector(msg.sig, tmpstr);
	}

	function foo(uint256 _value, uint256 _myaddr) external returns (uint256) {
        uint256 datasize;

        assembly {
            //calldatasize includes the function selector (the first 4 bytes)
            datasize := calldatasize()
        }
        globalsize = datasize + _value + _myaddr;
        return datasize;
    }
	
	function point(uint256 x, uint256 y) external {}
	
	function setName(string memory name) external {}
	
	function testSignatures() external pure returns (bool) {
        // NOTE: Casting to bytes4 takes the first 4 bytes
        // and removes the rest
        assert(bytes4(keccak256("foo()")) == this.foo.selector);
        assert(bytes4(keccak256("point(uint256,uint256)")) == this.point.selector);
        assert(bytes4(keccak256("setName(string)")) == this.setName.selector);
        
        return true;
	}
}

contract SendToFallback {
    function transferToFallback(address payable _to) public payable {
        _to.transfer(msg.value);
    }

    bytes4 private constant FUNC_SELECTOR = bytes4(keccak256("ops(address,uint256)"));

    function callFallback(address payable _to, uint256 _param1) public payable {
        (bool success,) = _to.call{value: msg.value}(abi.encodeWithSelector(FUNC_SELECTOR, _param1));
        if (!success) {
            revert("Failed to send Ether");
        }
    }
}

