pragma solidity ^0.4.24;
contract Property{
   
    uint public price;
    string  public location;
    address public owner;
    
    //constructor(uint _price, string _location) public{
    function Property(uint _price, string _location){
        price = _price;
        location = _location;
        owner = msg.sender;
    }
    
    //creates a transaction and costs gas
    function setPrice(uint _price) public {
        price = _price;
    }
    
    function setLocation(string _location) public{
        location = _location;
    }
    
}

