// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "forge-std/console.sol";

import "../../src/foundry/Time.sol";

contract TimeTest is Test {
    Time time;

    address deployer = makeAddr("deployer");
    uint256 private t;

    function setUp() external {
        vm.prank(deployer);
        time = new Time();
        t = block.timestamp;
    }

    function testBidFailBeforeStartAt() external {
        vm.expectRevert(bytes("cannot bid"));
        time.bid();
    }

    function testBidAfterStartAt() external {
        vm.warp(t + 1 days);
        time.bid();
    }

    function testBidAfterEndAt() external {
        vm.warp(t + 2 days);
        vm.expectRevert(bytes("cannot bid"));
        time.bid();
    }

    function testSkipandRewind() external {
        uint256 T = block.timestamp;

        skip(100);
        assertEq(block.timestamp, T+100);
        
        rewind(10);
        assertEq(block.timestamp, T+100 - 10);
    }

    function testEnd() external {
        vm.warp(t + 1 days);
        vm.expectRevert();
        time.end();
    }

}