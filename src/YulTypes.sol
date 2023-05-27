// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract yulTypes {


    function getUint256() pure external returns(uint256) {
        uint value;

        assembly {
            value := 100
        }

        return value;

    }

    function getHex() pure external returns(uint256) {
        uint value;

        assembly {
            value :=  0x64
        }

        return value;

    }


     function getAddress() pure external returns(address) {
        address addr;

        assembly {
            addr := 100
        }

        return addr;

    }

    function getRepresentation() pure external returns(bool) {
        bool _rep;
        

        assembly {
            _rep := 1
        }

        return _rep;

    }

    function getRepresentationBytes() pure external returns(bool) {
        bool _repBytes;
        // If the value is zero "0x000000000000000000000000000000000000000"
        // it returns false or returns true
        bytes32 zero = bytes32("2");

        assembly {
            _repBytes := zero
        }

        return _repBytes;

    }

    function getString() pure external returns(string memory) {
        bytes32 demo;

        // If string length is greater than 32 bytes it returns error;

        assembly {
            demo := "Hello World"
        }

        return string(abi.encode(demo));

    }

}
