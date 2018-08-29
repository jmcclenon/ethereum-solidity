pragma solidity ^0.4.24;
contract Property{
    
    uint public price = 90000;
    string  public location = "Hamburg" ;
    address public owner;
    address public caller;
    uint public last_sent_value;

    
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
       last_sent_value = msg.value;
    }
    
    //creates a transaction and costs gas
    function setPrice(uint _price) public {
        caller = msg.sender;
        price = _price;
    }
    
    function setLocation(string _location) public returns (bool){
        caller = msg.sender;
        location = _location;
        return true;
    }
    
    function f() view public returns(uint){
        uint start = gasleft();
        
        uint j = 5;
        for(uint i=0;i<10;i++){
            j++;
        }
        
        return start - gasleft();
        
    }
    
}

