// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

//Denial of service attack
//preventation : use pull insted of push
contract Storage{
    address public owner;
    uint public balance;
    mapping(address => uint) public ownerInfo;

    function beOwner() external{
        require(msg.value >= balance,"You need to pay more ether be the owner");
        balance += msg.value;
        owner = msg.sender;
    }

    function withdraw() external payable{
        (bool isSent,) = owner.call{value:balance}("");
        require(isSent,"Failed to send ether");
    }
}



contract Attack {
    function attack(Storage addr) public payable {
        addr.beOwner{value:msg.value}();
    }
}
