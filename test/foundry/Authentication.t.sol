// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;


import "forge-std/Test.sol";
import "forge-std/console.sol";

import "../../src/foundry/Authentication.sol";

// Three things i learned in this file 
// - vm.prank(msg.sender) owner of the next call;
// - vm.startPrank(msg.sender) owner of the subsequent calls;
// - vm.startPrank(msg.sender,msg.sender) it refers the transaction is from tx.origin;
// - vm.stopPrank() it stops the prank address to call next call

contract AuthenticationTest is Test {
    SimpleOwner simpleOwner;

    address deployer = makeAddr("deployer");
    address user = makeAddr("user");



    function setUp() external {
        // for every test function it creates simple owner contract;
        // deployer address is deploying this contract;
        
        vm.prank(deployer);
        simpleOwner = new SimpleOwner();
        console.log("Owner of this contract: ", simpleOwner.owner());
    }

    function testOwner() external {
        assertEq(simpleOwner.owner(),deployer);
        console.log("Owner of this contract: ", simpleOwner.owner());
    }

    function testFail_updateOwner() external{
        // msg.sender is AuthenticationTest; 
        // so the test going to fail; 
        // msg.sender is deployer;

        simpleOwner.updateOwner(user);
    }

    function test_updateOwner() external {
        vm.prank(deployer);
        // now msg.sender is deployer to the next call;
        // so, now owner is deployer; 
        
        simpleOwner.updateOwner(user);
        // owner is updated to the user address by calling updateOwner function;
        assertEq(simpleOwner.owner(),user);
        console.log("now owner is user: ", simpleOwner.owner());
    }

    function test_userUpdatingOwner() external {
        vm.startPrank(user);
        // msg.sender is user to the subsequent calls;
        // owner is deplyer but the function calling by user;

        vm.expectRevert();
        // we are expecting to revert the function;

        simpleOwner.updateOwner(user);
        vm.stopPrank();
        // We are stopping user as msg.sender to the next call;
    }
}