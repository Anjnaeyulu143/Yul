// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "forge-std/console.sol";

import "../../src/interfaces/IERC20.sol";

contract DaiMintTest is Test {
    IERC20 dai;
    address user = makeAddr("user");

    function setUp() external {
        dai = IERC20(0x6B175474E89094C44Da98b954EedeAC495271d0F);
    }

    function testMintDai() external {
        uint256 balBefore = dai.balanceOf(user)/1e18;
        uint256 daiBeforeBal = dai.totalSupply()/1e18;

        console.log("Balance before(USER): ", balBefore);
        console.log("Before dai totalSupply: ", daiBeforeBal);

        deal(address(dai),user,1e6*1e18,true);

        uint256 balAfter = dai.balanceOf(user)/1e18;
        uint256 daiAfterBal = dai.totalSupply()/1e18;

        console.log("Balance After(USER): ", balAfter);
        console.log("Aftef dai totalSupply: ", daiAfterBal);
    }
}