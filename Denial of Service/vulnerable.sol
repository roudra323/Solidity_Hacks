// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

//Denial of service attack
//preventation : use pull insted of push
contract Storage{
    address public owner;
    uint public balance;

    function beOwner() external payable {
        require(msg.value >= balance,"You need to pay more ether be the owner");
        // (bool isSent,) = owner.call{value:balance}("");
        // require(isSent,"Failed to send ether");
        balance = msg.value;
        owner = msg.sender;
    }
}



contract Attack {
    function attack(Storage addr) public payable {
        addr.beOwner{value:msg.value}();
    }
}
