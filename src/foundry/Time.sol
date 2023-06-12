// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Time {
    uint256 public startAt = block.timestamp + 1 days;
    uint256 public endAt = block.timestamp + 2 days;

    function bid() view external {
        require(block.timestamp >= startAt && block.timestamp < endAt,"cannot bid");
    }

    function end() view external {
        require(block.timestamp >= endAt, "bid still active");
    }

}