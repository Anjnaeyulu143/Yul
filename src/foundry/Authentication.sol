// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;


contract SimpleOwner {
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    function updateOwner(address _newOwner) external {
        require(msg.sender == owner, "!owner");
        owner = _newOwner;
    }
}