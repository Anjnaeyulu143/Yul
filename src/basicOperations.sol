// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract basicOperations {

    function checkAdd(uint256 x,uint256 y) external pure returns(uint256 c){
        assembly{
            c := add(x,y)
        }
    }

    function checkSub(uint256 x, uint256 y) external pure returns(uint256 c){
        assembly{
            c:= sub(x,y)
        }
    }

    function checkMul(uint256 x, uint256 y) external pure returns(uint256 c){
        assembly{
            c := mul(x,y)
        }
    }

    function checkDiv(uint256 x, uint256 y) external pure returns(uint256 c) {
        assembly{
            c := div(x,y)
        }
    }

    function checkMod(uint256 x, uint256 y) external pure returns(uint256 c) {
        assembly{
            c := mod(x,y)
        }
    }

    // If it returns 1 than it is true => x is less than y
    // If it returns 0 than it is false => y is less than x

    function checkLt(uint256 x, uint256 y) external pure returns(uint256 c){
        assembly{
            c := lt(x,y)
        }
    }

    // If it returns 1 than it is true => x is more than y
    // If it returns 0 than it is false => y is more than x

    function checkGt(uint256 x, uint256 y) external pure returns(uint256 c){
        assembly{
            c := gt(x,y)
        }
    }

    // If it returns 0 than it is a (non-zero)value which means it is false
    // If it returns 1 than it is a (zero) value which means it is true

    function checkIszero(uint256 x) external pure returns(uint256 c){
        assembly{
            c := iszero(x)
        }
    }

    // In the function returned value the last index value is non-zere it is true
    // In the function returned value the last index value is zero it is false 

    function checkZeroBytes32(uint256 x) external pure returns(bytes32 c){
        assembly{
            c := iszero(x)
        }
    }

    function isTruthy() external pure returns(uint256 result) {
        result = 2;

        assembly{
            if 10 { // where all of the bits inside the bytes32 is non-zero == true
                result := 1
            }
        }

    }

    function isFalsy() external pure returns(uint256 result){
        result = 1;
        assembly {
            if 0 { // where all the bits inside the bytes32 is zero == zero
                result := 2
            }
        }
    }


    function maxNum(uint256 x, uint256 y) external pure returns(uint256 max) {
        assembly {

            // If x is lesser than the y then it returns the 1 means true

            if lt(x,y){
                max := y
            }

            // If x is not lesser than/more than the y then it returns the 0 means false

            if iszero(lt(x,y)){
                max := x
            }
        }
    }

    function checkSwitch(uint256 x, uint256 y) external pure returns(uint256 lesser) {
        
        uint256 sum;

        assembly{
            sum := add(x,y)


            // This is swtich case used for condition checks
            switch lt(x,y)

            case true {
                lesser := x
            }

            case false {
                lesser := y
            }

            default {
                lesser := sum
            }
        }
    }

    function sumOfNums(uint256 x) external pure returns(uint256 result){

        assembly{
            // init        conditon post-increment
            for{let i:= 1} lt(i,x) {i:= add(i,1)} 
            {
                result := add(result,i)
            }
        }
    }   

    function evenOrodd(uint256 x) external pure returns(string memory){
        bytes32 evenOrOdd;

        assembly{
            
            if iszero(mod(x,2)){
                evenOrOdd := "even"
            }

            if mod(x,2){
                evenOrOdd := "odd"
            }

        }

        return string(abi.encode(evenOrOdd));

    }

    function isPrime(uint256 x) external pure returns(bool){
        bool p = true;

        assembly{
            let halfNum := div(x,2)

            for {let i:= 2} lt(i,halfNum) {i := add(i,1)}
            {
                if iszero(mod(x,i)){
                    p := false 
                    break
                }
            }

        }

        return p;

    }

}