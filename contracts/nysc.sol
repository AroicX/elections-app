// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

contract Conditionals{

    uint[] public arr = [10,20,30,40,50];

    function insert(uint _item) public {
        arr.push(_item);
    }

    function returnArr() public {
         arr.pop();
    }

    function lengthArr() public view returns(uint){
        return arr.length;
    }

    function returnAllElement() public view returns(uint[] memory){
        return arr;
    }
    // address public addr="0x78731D3Ca6b7E34aC0F824c42a7cC18A495cabaB"

    // modifier isTrue{
    //     require(true==false,"true is true");
    //     _;
    // }

    // modifier isEven(uint a){
    //     require(a%2==0,"a is not even");
    //     _;
    // }

    // function isZero(uint a) public pure isEven(a) returns(bool){

    //     return true;
    // }

    // function checking(uint a, uint b) public pure returns (uint){
    //     if(a>b){
    //         return 1;
    //     }
    //     else if(a==b){
    //         return 2;
    //     }else{
    //         return 0;
    //     }
    // }

    // bool public value = true;

    // function checkEven(uint a) public pure returns (bool){
    //     if(a%2 == 0){
    //         return true;
    //     }else{
    //         return false;
    //     }
    // }
}