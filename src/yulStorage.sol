// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;


contract yulStorage {

    // sload(_slot) -> It loads data from the given slot number
    // sstore(_slot,_value) -> It stores the data in the given slot number
    // a.slot -> It returns variable stored slot number

    uint256 public x = 10;
    uint256 public y = 14;
    uint256 public z = 20;

    uint128 public a = 20;
    uint128 public b = 20;

    function setX(uint256 _slot,uint256 _value) external {
        assembly{
            sstore(_slot,_value)
        }
    }

    function getValueBytes(uint256 _slot) external view returns(bytes32 _num) {
        assembly{
            _num := sload(_slot)
        }
    }

    function getValue(uint256 _slot) external view returns(uint256 _num) {
        assembly{
            _num := sload(_slot)
        }
    }

    function getXSlot() external pure returns(uint256 _slot) {
        assembly {
            _slot := x.slot
        }
    }

    function getYSlot() external pure returns(uint256 _slot){
        assembly{
            _slot := y.slot
        }
    }

    function getZSlot() external pure returns(uint256 _slot){
        assembly{
            _slot := z.slot
        }
    }

    function getASlot() external pure returns(uint256 _slot){
        assembly{
            _slot := a.slot
        }
    }

}   