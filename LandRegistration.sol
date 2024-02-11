// SPDX-License-Identifier: MIT

pragma solidity ^0.8.17;

contract LandReg{

    address public owner;

    struct Land{
        string name;
        string location;
        address landOwner;
        uint price;
    }

    mapping(uint => Land) public land;
    mapping(address => uint) public balance;
    mapping(uint => bool) public check;

    constructor(){
        owner = msg.sender;
    }

    modifier isOwner(){
        require(msg.sender == owner, "You are not the owner");
        _;
    }

    modifier isSeller(uint _surveyNum){
        require(check[_surveyNum] == true, "Survey Number doesn't exist");
        require(land[_surveyNum].landOwner == msg.sender, "Not the owner");
        _;
    }


    function addLand(uint _surveyNum,string memory _location,string memory _name,  address _landOwner, uint _price) public isOwner(){
        land[_surveyNum].name = _name;
        land[_surveyNum].location = _location;
        land[_surveyNum].landOwner = _landOwner;
        land[_surveyNum].price = _price;
        check[_surveyNum] = true;
    }

    function transferLand(uint _surveyNum, address _sellerAdd, string memory buyer, address _buyerAdd) public isSeller(_surveyNum){
        require(balance[_buyerAdd] >= land[_surveyNum].price, "Not enough balance to buy the land");
        balance[_buyerAdd] -= land[_surveyNum].price;
        balance[_sellerAdd] += land[_surveyNum].price;
        land[_surveyNum].landOwner = _buyerAdd;
        land[_surveyNum].name = buyer;
        
    }

    function add50k(address add) public payable returns(uint){
        balance[add] = 50000;
        return balance[add];
    }
}
