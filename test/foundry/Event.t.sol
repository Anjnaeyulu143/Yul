// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "forge-std/console.sol";
import "../../src/foundry/Event.sol";

contract EventTest is Test {
    Event e;
    address deployer = makeAddr("deployer");
    address user1 = makeAddr("user1");
    address user2 = makeAddr("user2");

    event Transfer(address indexed from, address indexed to, uint256 amount);

    function setUp() external {
        vm.prank(deployer);
        e = new Event();
    }

    function testTransfer() external {

        // 1.Tell the foundry which data we need to check;
        // 2.Emit the expected the event;
        // 3.Call the function that should emit the event;

        vm.expectEmit(true,true,false,true);

        // function expectEmit(
        // bool check Topic 1;
        // bool check Topic 2;
        // bool check Topic 3;
        // bool check data;
        //)

        emit Transfer(address(this), deployer, 500);
        e.transer(address(this), deployer, 500);
    }

    function testTransfer2() external {

        // 1.Tell the foundry which data we need to check;
        // 2.Emit the expected the event;
        // 3.Call the function that should emit the event;

        vm.expectEmit(true,false,false,false);

        // function expectEmit(
        // bool check Topic 1;
        // bool check Topic 2;
        // bool check Topic 3;
        // bool check data;
        //)

        emit Transfer(address(this), deployer, 500);
        e.transer(address(this), address(143), 1000);
    }

    function testManyTransfers() external {
        address[] memory to = new address[](2);
        to[0] = user1;
        to[1] = user2;

        uint256[] memory amounts = new uint256[](2);
        amounts[0] = 200;
        amounts[1] = 400;

        // Tell the foundry which data we need to check;
        vm.expectEmit(true, false, false, true);

        // Emit the expected data to check;
        for(uint i; i < to.length; ++i){
            emit Transfer(address(this),to[i],amounts[i]);
        }


        // Call the function that should emit event;
        e.transferMany(address(this),to, amounts);

         
    }




}