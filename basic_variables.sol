pragma solidity ^0.4.24;

contract Property{
  string public location = "Paris";
  int public price;
   
 // location = "London"; //this is not permitted in solidity
 
 function setProperty(string _location) public{ //_location is local and saved in 
                                                //memory
     location = _location;
  
     int a; //local variable, saved on the stack
     
     int[] x; //this is saved in storage
     
 }
}