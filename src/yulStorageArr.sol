// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;


contract yulStorageArray {

    uint256[3] public numsArray;
    uint256[] public dynamicArr;
    uint16[] public smallArr;

    mapping(uint256 => uint256) private myMapping;
    mapping(uint256 => mapping(uint256 => uint256)) private nestedMapping;
    mapping(address => uint256[]) private tokens;


    // In fixed array -> we need to get slot number of the variable stored in storage;
    // After adding index number to slot -> it returns value at the given index;

    // In dynamic array -> we need to get slot number of the variable stored in storage;
    // After we need to convert that slot number into the bytes32;
    // After we added the index number to the slot number to get the value present in the index number;

    // In Mapping -> First it gets the varibale slot nubmer and keccak256 hash it with key (key,slot);
    // In Nested Mapping -> First it gets the variable slot number and keccak256 it with 1 key and again hash it with 2 key

    constructor() {
        numsArray = [100,20,10];
        dynamicArr = [1,2,3];
        smallArr = [8,9,10];

        myMapping[1] = 10000;
        myMapping[2] = 20000;
        nestedMapping[1][2] = 500;

        tokens[0x5B38Da6a701c568545dCfcB03FcB875f56beddC4] = [100,200];

    }

    function getSlotFixed() external view returns(uint256 _ret){
        assembly{
            _ret := sload(numsArray.slot)
        }
    }

    function getSlotDynamic() external view returns(uint256 _ret){
        assembly{
            _ret := sload(dynamicArr.slot)
        }
    }



    function getNum(uint256 _index) external view returns(uint256 _num){
        assembly{
            let slotNum := numsArray.slot

            _num := sload(add(slotNum,_index))
        }
    }

    function updateNum(uint256 _index, uint256 _value) external {
        assembly{
            let slotNum := numsArray.slot 

            sstore(add(_index,slotNum),_value)
        }
    }

    function getNumDynamic(uint256 _index) external view returns(uint256 _value){
        uint256 slotNum;

        assembly{
            slotNum := dynamicArr.slot
        }

        bytes32 location = keccak256(abi.encode(slotNum));

        assembly{
            _value := sload(add(location,_index))
        }

    }

    function updateDynamicArr(uint256 _index, uint256 _val) external {
        uint256 slotNum;
        assembly{
            slotNum := dynamicArr.slot 
        }

        bytes32 location = keccak256(abi.encode(slotNum));

        assembly{
            sstore(add(location,_index),_val)
        }
    } 

    function getNumSmallArr(uint256 _index) external view returns(bytes32 _newVal) {
        uint256 slot;
        assembly{
            slot := smallArr.slot
        }

        bytes32 location = keccak256(abi.encode(slot));

        assembly{
            _newVal := sload(add(location,_index))

            // let newData := shr(mul(_index,8),_newVal)

            // returnedData := add(0xff,newData)

        }


    }

    function getNumMymapping(uint256 key) external view returns(uint256 _value){
        uint256 _slot;
        assembly{
            _slot := myMapping.slot
        }

        bytes32 location = keccak256(abi.encode(key,_slot));

        assembly{
            _value := sload(location)
        }

    }

    function getNumNestedMapping(uint256 _key1,uint256 _key2) external view returns(uint256 _val){
        uint256 _slot;
        assembly{
            _slot := nestedMapping.slot
        }

        bytes32 location = keccak256(abi.encode(
            _key2,
            keccak256(abi.encode(
                _key1,_slot
            ))
        ));

        assembly{
            _val := sload(location)
        }
    }

    function updateNestedMapping(uint256 _key1,uint256 _key2) external {
        uint256 _slot;
        assembly{
            _slot := nestedMapping.slot
        }

        bytes32 location = keccak256(abi.encode(
            _key2,keccak256(abi.encode(
                _key1,_slot
            ))
        ));

        assembly{
            sstore(location,3000)
        }

    }

    function getArrToken(address _key) external view returns(uint256 _val){
        uint256 _slot;

        assembly{
            _slot := tokens.slot
        }

        bytes32 location = keccak256(abi.encode(
            _key,
            _slot
        ));

        assembly{
            _val := sload(location)
        }

    }

    function getArrNum(address _key, uint256 _index) external view returns(uint256 _val){
        uint256 _slot;
        assembly{
            _slot := tokens.slot 
        }

        bytes32 location = keccak256(abi.encode(keccak256(abi.encode(
            _key,_slot
        ))));

        assembly{
            _val := sload(add(location,_index))
        }
    }

    
}