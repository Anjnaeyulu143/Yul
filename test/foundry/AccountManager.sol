// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "forge-std/console.sol";

import "../../src/utils/WETH.sol";
import {Handler} from "./handlerBasedTest.t.sol";

import {CommonBase} from "forge-std/Base.sol";
import {StdCheats} from "forge-std/StdCheats.sol";
import {StdUtils} from "forge-std/StdUtils.sol";


// First we need to create account manager handler contract
// Then we need to create functions to call subContract functions with multiple calls and random data
// Then we use bound function for foundry input value should be between the two values - bound(input, above, below)
contract AccountManger is CommonBase, StdCheats, StdUtils {
    Handler[] public handlers;

    constructor(Handler[] memory _handlers) {
        handlers = _handlers;
    }

    function sendEth(uint256 _handlerIndex,uint256 _amount) external {
        uint256 index = bound(_handlerIndex,0,handlers.length-1);
        handlers[index].sendETH(_amount);
    }

    function deposit(uint256 _handlerIndex,uint256 _amount) external {
        uint256 index = bound(_handlerIndex,0,handlers.length-1);
        handlers[index].deposit(_amount);
    }

    function withdraw(uint256 _handlerIndex,uint256 _amount) external {
        uint256 index = bound(_handlerIndex,0,handlers.length-1);
        handlers[index].withdraw(_amount);
    }

}

// This accountManager invariant test
// 1. First we need setUp
// 2. Then we call the target Address (Target Contract // Target Selectors)
// 3. Then we write invariant test

contract AccountManagerInvariantTest is Test {
    WETH public weth;
    Handler[] public handlers;
    AccountManger public accountManager;

    function setUp() external {
        weth = new WETH();

        for(uint i=0; i < 3; ++i){
            handlers.push(new Handler(weth));
            deal(address(handlers[i]),100*1e18);
        }

        accountManager = new AccountManger(handlers);

        targetContract(address(accountManager));

        bytes4[] memory selectors = new bytes4[](3);
        selectors[0] = AccountManger.sendEth.selector;
        selectors[1] = AccountManger.deposit.selector;
        selectors[2] = AccountManger.withdraw.selector;

        targetSelector(
            FuzzSelector({addr: address(accountManager),selectors:selectors})
        );
    }

    function invariantTest_AccountManager() external {
        uint256 total = 0;

        for(uint i=0; i < handlers.length; ++i){
            total += handlers[i].totalBalance();
        }

        assertGe(address(weth).balance,total); 
    }

    
}