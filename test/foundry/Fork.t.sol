// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;


import "forge-std/Test.sol";
import "forge-std/console.sol";

interface IWETH {
    function balanceOf(address _owner) external returns(uint256);
    function deposit() payable external;
}

contract ForkTest is Test {
    IWETH public weth;
    function setUp() external {
       weth = IWETH(0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2);
    }

    function testWETH() external {
        uint256 beforeBal = weth.balanceOf(address(this));
        console.log("Before fork test balance: ", beforeBal);

        weth.deposit{value:100}();

        uint256 afterBal = weth.balanceOf(address(this));
        console.log("After fork test balance: ", afterBal);
    }
}