// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "forge-std/console.sol";

contract SignatureTest is Test {


    address add;
    uint256 key;

    function setUp() external{
        (add, key) = makeAddrAndKey("deployer");
        console.log("generated address: ", add);
    }

    function test_signature() external {
        bytes32 digest = keccak256("Hello World");

        (uint8 v, bytes32 r, bytes32 s) = vm.sign(key, digest);
        address getAddress = ecrecover(digest, v, r, s);

        console.log("ecrecover returned address: ", getAddress);


        assertEq(getAddress,add);

    }

    function test_invalidSignature() external {
        bytes32 validDigest = keccak256("valid message");
        bytes32 inValidDigest = keccak256("Invalid message");
        (uint8 v, bytes32 r, bytes32 s) = vm.sign(key,validDigest);

        address returnedAdd = ecrecover(inValidDigest, v, r, s);

        console.log("returned address : ", returnedAdd);
        
        assertTrue(add != returnedAdd);

    }

}
