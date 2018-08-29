pragma solidity ^0.4.24;


contract Property{
    //state variables
    uint price;
    string public location = "London";
    
    
    //creates a transaction and costs gas
    function setPrice(uint _price) public{
        price = _price;
    }
    
    //this function creates a call and it's free
    function getPrice() public view returns(uint){
        return price;
    }
            
    
}