// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract Simple {
    bool public isValid;

    function fun_1() external{}
    function fun_2() external{}
    function fun_3() external{}
    function fun_4() external{}
    function fun_5() external{
        // isValid = true;
    }


}

import "forge-std/Test.sol";

contract SimpleTest is Test {
    Simple simple;

    function setUp() external{
        simple = new Simple();
    }

    function invariant_test_isValid() external {
        assertEq(simple.isValid(),false);
    }

}

import "../../src/utils/WETH.sol";
import "forge-std/console.sol";

contract WETHTest is Test {
    WETH weth ;
    function setUp() external{
        weth = new WETH();
    }

    function invariant_test_totalSupply() external{
        assertEq(weth.totalSupply(),0);
    }
}