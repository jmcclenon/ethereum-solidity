pragma solidity ^0.4.24;

contract Auction{
    address public owner;
    uint public startBlock;
    uint public endBlock;
    string public ipfsHash;

    
    enum State {Started, Running, Ended, Canceled}
    State public auctionState;
    
    uint public highestBindingBind;
    address public highestBidder;
    
    mapping(address => uint) public bids;
    
    uint bidIncrement;
    

    constructor() public{
        owner = msg.sender;
        auctionState = State.Running;
        
        startBlock = block.number;
        endBlock = startBlock + 3;
      
        ipfsHash = "";
        bidIncrement = 1000000000000000000;
    }
    
    modifier notOwner(){
        require(msg.sender != owner);
        _;
    }
    
    
    modifier onlyOwner(){
        require(msg.sender == owner);
        _;
    }
    
    modifier afterStart(){
        require(block.number >= startBlock);
        _;
    }
    
    modifier beforeEnd(){
        require(block.number <= endBlock);
        _;
    }
    
    
    
    function min(uint a, uint b) pure internal returns(uint){
        if (a <= b){
            return a;
        }else{
            return b;
        }
    }
    
    function cancelAuction() public onlyOwner{
        auctionState = State.Canceled;
    }
    
    
    function placeBid() public payable notOwner afterStart beforeEnd returns(bool){
        require(auctionState == State.Running);
       //require(msg.value > 0.001 ether);
        
        uint currentBid = bids[msg.sender] + msg.value;
        
        require(currentBid > highestBindingBind);
        
        bids[msg.sender] = currentBid;
        
        if (currentBid <= bids[highestBidder]){
            highestBindingBind = min(currentBid + bidIncrement, bids[highestBidder]);
        }else{
             highestBindingBind = min(currentBid, bids[highestBidder] + bidIncrement);
             highestBidder = msg.sender;
        }
    return true;
    }
    
    
    
    function finalizeAuction() public{
       require(auctionState == State.Canceled || block.number > endBlock); //the auction has been Canceled
       
       require(msg.sender == owner || bids[msg.sender] > 0);
       
       address recipient;
       uint value;
       
       if(auctionState == State.Canceled){
           recipient = msg.sender;
           value = bids[msg.sender];
       }else{//ended not canceled
           if(msg.sender == owner){
               recipient = owner;
               value = highestBindingBind;
           }else{
               if (msg.sender == highestBidder){
                   recipient = highestBidder;
                   value = bids[highestBidder] - highestBindingBind;
               }else{//this is neiher the owner nor the highest bidder
                   recipient = msg.sender;
                   value = bids[msg.sender];
               }
           }
       }
       
       recipient.transfer(value);
        
    }
    
    
}
