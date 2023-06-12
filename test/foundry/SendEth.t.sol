// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "forge-std/console.sol";

import "../../src/foundry/SendEth.sol";

// I learned two things in this contract 
// deal is used to send ether to given address
// hoax is also used to send ether to given address

// deal(address, uint256) -> this function sends given amount to given address

// hoax(address, uint256) -> deal + prank this function sends eth and set that address as prank

contract sendEthTest is Test {
    Wallet wallet;

    address deployer = makeAddr("deployer");

    function setUp() external {
        vm.prank(deployer);
        wallet = new Wallet();
    }

    function _send(uint256 _amount) private {
        (bool success,) = address(wallet).call{value: _amount}("");
        require(success,"transfer failed");
    }

    function testEther() view external{
        console.log("Balance of this contract: ",address(this).balance/1e18);
    }

    function test_sendEthToWallet() external {

        // uint256 balance = address(wallet).balance;

        console.log("Befor balance of this: ", address(this).balance);

        // deal(deployer,100);
        // assertEq(address(deployer).balance,100);

        // console.log("Befor balance of this: ", address(this).balance);

        // _send(100);

        // console.log("After balance of balance: ", address(this).balance);
        // assertGt(address(wallet).balance, balance);

        hoax(deployer,100);
        _send(100);

        console.log("using hoax balance of this: ", address(this).balance);

    }
}