// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

contract TCC {
    uint256 amount; // class property

    // sender/owner
    address owner;
    string public ownwer2;

    address[] users;
    // array of balances
    mapping(address => uint256) public balance;

    // event
    event SentToken(uint256 amount, string receiver);

    // constructor
    constructor() {
        owner = msg.sender;
        balance[owner] = 1000;
    }

    modifier onlyOwner() {
        require(
            msg.sender == owner,
            "Only the contract owner can call this function"
        );
        _; // This underscore indicates where the main function's code will be placed
    }

    // method or function
    function sendToken(address recipient, uint256 amount) public {
        balance[recipient] += amount;
        // emit SentToken(recipient, amount);
    }

    function getBalance(address user) public returns (uint256) {
        return balance[user];
    }

    function transferFrom(address recipient, uint256 amount) public onlyOwner {
        require(balance[msg.sender] >= amount, "Insufficient balance!");
        //
        balance[msg.sender] -= amount;
        balance[recipient] += amount;
    }
}
