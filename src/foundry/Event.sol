// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// In this contract Iam learned about the how events work
// What is indexTopic

contract Event {

    // This the event when user want access data from offchain through this events user can access data;

    event Transfer(address indexed _from, address indexed _to, uint256 _amount);

    function transer(address from , address to , uint256 amount) external {
        // After successfully transfering the funds the user can access data using the transfer event
        emit Transfer(from, to, amount);
    }

    function transferMany(address from, address[] memory to, uint256[] memory amount) external{
        for(uint i; i < to.length; ++i){
            emit Transfer(from, to[i], amount[i]);
        }
    }
}