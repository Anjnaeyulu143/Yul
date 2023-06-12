// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Wallet {
    address public owner;

    event received(address _sender, uint256 _amount);
    constructor() {
        owner = payable(msg.sender);
    }

    receive() payable external {
        emit received(msg.sender, msg.value);
    }

    function withdraw() external{
        require(msg.sender == owner);
        (bool success,)= payable(owner).call{value : address(this).balance}("");

        require(success,"transfer failed");
    }

    function updateOwner(address _newOwner) external {
        owner = _newOwner;
    } 

}