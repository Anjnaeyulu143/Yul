// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "forge-std/console.sol";

import {WETH} from "../../src/utils/WETH.sol";

import {CommonBase} from "forge-std/Base.sol";
import {StdCheats} from "forge-std/StdCheats.sol";
import {StdUtils} from "forge-std/StdUtils.sol";

contract Handler is CommonBase,StdCheats,StdUtils {

    WETH public weth;
    uint256 public totalBalance;

    constructor(WETH _weth) {
        weth = _weth;
    }

    receive() external payable{}

    function sendETH(uint256 _amount) public {
        uint256 amount = bound(_amount,0, address(this).balance);
        totalBalance += amount;
        (bool success,) = address(weth).call{value:amount}("");
        require(success, "transction failed");
    }

    function deposit(uint256 _amount) external{
        uint256 amount = bound(_amount, 0, address(this).balance);
        totalBalance += amount;
        weth.deposit{value:amount}();
    }

    function withdraw(uint256 _amount) external{
        uint256 amount = bound(_amount,0,weth.balanceOf(address(this)));
        totalBalance -= amount;
        weth.withdraw(amount);
    }

}

contract HandlerBasedTest is Test {
    WETH public weth;
    Handler public handler;

    function setUp() external {
        weth = new WETH();
        handler = new Handler(weth);

        deal(address(handler),100*1e18);
        targetContract(address(handler));
    }

    function invariant_testHandler() external {
        assertEq(address(weth).balance,handler.totalBalance());
    }


}