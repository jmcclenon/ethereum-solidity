pragma solidity ^0.4.24;
contract Property{
    
    uint public price = 90000;
    string  public location = "Hamburg" ;
    address public owner;
    
    
    //contract constructor
    constructor() public{
       owner = msg.sender;
    }
    
    function get_balance() view public returns (uint){
        return address(this).balance;
    }
    
    //fallback payable function
    function () payable public{
        location = "London";
    }
    
    function transfer_balance(address recipient_address, uint amount) public returns(bool) {
        if(msg.sender == owner){
             if (amount <= get_balance()){
                 recipient_address.transfer(amount);
                 return true;
             }else{
                return false;
            }
        }else{
            return false;
        }
    }

    
    function sendEther() payable public{
        price = 600;
    }
    
    //creates a transaction and costs gas
    function setPrice(uint _price) public {
        price = _price;
    }
    
    function setLocation(string _location) public{
        location = _location;
    }
    
}

