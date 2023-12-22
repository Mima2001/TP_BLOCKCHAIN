// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract SimpleToken {
    // Token details
    string public name;
    string public symbol;
    uint8 public decimals;
    uint256 public totalSupply;

    // Balances and allowances
    mapping(address => uint256) public balanceOf;
    mapping(address => mapping(address => uint256)) public allowance;

    // Events for tracking transfers and approvals
    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);

    // Constructor to set up the initial token state
    constructor(string memory _name, string memory _symbol, uint8 _decimals, uint256 _initialSupply)  {
        name = _name;
        symbol = _symbol;
        decimals = _decimals;
        totalSupply = _initialSupply * (10 ** uint256(decimals));
        
        // Assign the initial supply to the creator
        balanceOf[msg.sender] = totalSupply;

        // Emit an event to log the initial transfer
        emit Transfer(address(0), msg.sender, totalSupply);
    }

    // Transfer tokens from the sender to another address
    function transfer(address to, uint256 value) public returns (bool success) {
        require(balanceOf[msg.sender] >= value, "Not enough balance");
        
        // Update balances
        balanceOf[msg.sender] -= value;
        balanceOf[to] += value;

        // Emit a Transfer event to log the transfer
        emit Transfer(msg.sender, to, value);

        return true;
    }

    // Approve a spender to spend a certain amount of tokens on behalf of the owner
    function approve(address spender, uint256 value) public returns (bool success) {
        // Set the spender's allowance
        allowance[msg.sender][spender] = value;

        // Emit an Approval event to log the approval
        emit Approval(msg.sender, spender, value);

        return true;
    }

    // Transfer tokens from one address to another on behalf of the owner
    function transferFrom(address from, address to, uint256 value) public returns (bool success) {
        require(balanceOf[from] >= value, "Not enough balance");
        require(allowance[from][msg.sender] >= value, "Not enough allowance");
        
        // Update balances and allowances
        balanceOf[from] -= value;
        balanceOf[to] += value;
        allowance[from][msg.sender] -= value;

        // Emit a Transfer event to log the transfer
        emit Transfer(from, to, value);

        return true;
    }
}
