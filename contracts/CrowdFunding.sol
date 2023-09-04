// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

contract CrowdFunding {
    struct Request {
        string description;
        uint value;
        address payable recipient;
        bool completed;
        uint noOfVoters;
        mapping(address => bool) voters;
    }

    mapping(uint => Request) public requests;
    mapping(address => uint) public contributors;
    address public manager;
    uint public numRequests;
    uint public minimumContribution;
    uint public deadline;
    uint public target;
    uint public raisedAmount;
    uint public noOfContributors;

    modifier onlyManager(){
        require(msg.sender == manager,"You are not the manager");
        _;
    }

    constructor(uint _target, uint _deadline){
        target = _target;
        deadline = block.timestamp + _deadline; // 500sec + 60sec * 60min * 24hr * 30days
        minimumContribution=100 wei;
        manager = msg.sender;
    }

    function createRequests(string calldata _description, address payable _recipient, uint _value) public onlyManager{
        Request storage newRequest = requests[numRequests];
        numRequests++;
        newRequest.description = _description;
        newRequest.recipient = _recipient;
        newRequest.value = _value;
        newRequest.completed = false;
        newRequest.noOfVoters = 0;
    }

    function contribute() public payable {
        require(block.timestamp < deadline,"Deadline has passed");
        require(msg.value >= minimumContribution,"Minimum contribution not met");
        if(contributors[msg.sender] == 0){
            noOfContributors++;
        }
        contributors[msg.sender] += msg.value;
        raisedAmount += msg.value;
    }

    function getBalance() public view returns(uint){
        return address(this).balance;
    }

    function getRefund() public {
        require(block.timestamp > deadline,"Deadline has not passed");
        require(raisedAmount < target,"Target has been met");
        require(contributors[msg.sender] > 0,"You have not contributed");
        address payable recipient = payable(msg.sender);
        uint value = contributors[msg.sender];
        recipient.transfer(value);
        contributors[msg.sender] = 0;
    }

    function voteRequest(uint _requestNo) public {
        require(contributors[msg.sender] > 0,"You have not contributed");
        Request storage thisRequest = requests[_requestNo];
        require(thisRequest.voters[msg.sender] == false,"You have already voted");
        thisRequest.voters[msg.sender] = true;
        thisRequest.noOfVoters++;
    }

    function makePayment(uint _requestNo) public onlyManager{
        Request storage thisRequest = requests[_requestNo];
        require(thisRequest.completed == false,"Request has already been completed");
        require(thisRequest.noOfVoters > noOfContributors/2,"Not enough votes");
        thisRequest.recipient.transfer(thisRequest.value);
        thisRequest.completed = true;
    }

    function getSummary() public view returns(uint,uint,uint,uint,uint,uint,uint){
        return(
            target,
            deadline,
            minimumContribution,
            raisedAmount,
            noOfContributors,
            numRequests,
            manager
        );
    }

    
}
