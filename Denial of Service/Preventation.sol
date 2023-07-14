// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

//Denial of service attack
//preventation : use pull insted of push
contract Storage{
    address public owner;
    uint public balance;
    mapping(address => uint) public ownerInfo;

    function beOwner() external payable{
        require(msg.value >= balance,"You need to pay more ether be the owner");
        ownerInfo[msg.sender] += balance;
        balance = msg.value;
        owner = msg.sender;
    }

    function withdraw() external payable{
        require(owner == msg.sender,"You aren't the current winner!!");
        uint amount = ownerInfo[msg.sender];
        ownerInfo[msg.sender] = 0;
        (bool isSent,) = owner.call{value:amount}("");
        require(isSent,"Failed to send ether");
    }
}
