// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "forge-std/console.sol";

import "../../src/foundry/Error.sol";

// I leared 4 new things in this file

// vm.expectRevert() - If we expect revert in next call we user this function

// vm.expectRevert(bytes("message")) - If we expect revert in next call but we need to check the error message we use this function 

// vm.expectRevert(Error.errorName.selector) - If we expecting custom Error then we use this function

// vm.label - ?

contract ErrorTest is Test{
    Error error;

    address deployer = makeAddr("deployer");

    function setUp() external {
        vm.prank(deployer);
        error = new Error();
    }

    function testFail() view external {
        error.throwError();
    }

    function testRevert() external {
        vm.expectRevert();
        error.throwError();
    }

    function testRequire() external {
        vm.expectRevert(bytes("error"));
        error.throwError();
    }

    function testCustomErr() external {
        vm.expectRevert(Error.notAuthorized.selector);
        error.throwCustomError();
    }

    function testLabel() external {
        assertEq(uint256(1),uint256(1),"test-1");
        assertEq(uint256(2),uint256(2),"test-2");
        assertEq(uint256(3),uint256(3),"test-3");
        assertEq(uint256(4),uint256(1),"test-4");
    }
}
