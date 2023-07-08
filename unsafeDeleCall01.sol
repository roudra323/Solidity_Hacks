
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract A {
    address public immutable owner; //use immutable to avoid delegate call attacks
    B public b;

    constructor(B _b) {
        owner = msg.sender;
        b = _b;
    }

    fallback() external payable {
        address(b).delegatecall(msg.data);
    }
}

contract B {
    address public owner;

    function setOwner() public {
        owner = msg.sender;
    }
}

contract C {
    address public contractAddr;

    constructor(address _contractAddr){
        contractAddr = _contractAddr;
    }

    function attack() public{
        contractAddr.call(abi.encodeWithSignature("setOwner()"));
    }
}
