// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract yulStorage2 {
    uint128 public a = 128;
    uint96 public b = 96;
    uint16 public c = 166; 
    uint8 public d = 8;
    bool public e = true;


    function getASlot() external pure returns(uint256 _slot){
        assembly{
            _slot := a.slot
        }
    }

    function getSlotandOffset() external pure returns(uint256 _slot,uint256 _offset){
        assembly{
            _slot := c.slot 
            _offset := c.offset
        }
    }


    function getValue(uint256 _slot) external view returns(bytes32 _value){
        assembly{
            _value := sload(_slot)
        }
    }


    function readC() external view returns(uint16 _value) {

        // VV & 00 = 0
        // VV & FF = V

        assembly{

            // loading data which is stored in slot c
            let slotData := sload(c.slot)
            // 0x0108001000000000000000000000006000000000000000000000000000000080
            // It returns the at what byte from it stores
            let offset := c.offset
            // 28 bytes -> 28*8 bits

            // shr(offset bits,data) -> It shifted right side on givev data
            let _shiftedValue := shr(mul(offset,8),slotData)
            // 0x0108001000000000000000000000006000000000000000000000000000000080
            // 0x0000000000000000000000000000000000000000000000000000000000108001

            _value := and(0xffff,_shiftedValue)
            // 0x000000000000000000000000000000000000000000000000000000000000ffff
            // 0x0000000000000000000000000000000000000000000000000000000000108001

        }
    }


    function writeC(uint16 _newValue) external {
        assembly{
            let slotData := sload(c.slot)
            // 0x00000108000000a6000000000000006000000000000000000000000000000080

            let clearedData := and(0xffff0000ffffffffffffffffffffffffffffffffffffffffffffffffffffffff,slotData)

            // Bit Masking (AND)
            // 0xffff0000ffffffffffffffffffffffffffffffffffffffffffffffffffffffff - bit masking
            // 0x00000108000000a6000000000000006000000000000000000000000000000080 - slotData
            // 0x00000000000000a6000000000000006000000000000000000000000000000080 - result

            let _updatedValue := shl(mul(c.offset,8),_newValue)

            // New value -> 0x0000002100000000000000000000000000000000000000000000000000000000

            let _newData := or(clearedData,_updatedValue)

            // New value -> 0x0000102000000000000000000000000000000000000000000000000000000000
            // clearedData -> 0x00000000000000a6000000000000006000000000000000000000000000000080
            

            sstore(c.slot,_newData)
            
        }
    }



}