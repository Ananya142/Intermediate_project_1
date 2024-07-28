// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract ImprovedToken {
    // Mapping to store balances of addresses
    mapping(address => uint256) private balances;

    // Events for logging deposits, withdrawals, and transfers
    event Deposit(address indexed account, uint256 amount);
    event Withdrawal(address indexed account, uint256 amount);
    event Transfer(address indexed from, address indexed to, uint256 amount);

    // Function to deposit Ether into the contract
    function deposit() external payable {
        require(msg.value > 0, "Deposit amount must be greater than zero");

        // Increase the balance of the sender
        balances[msg.sender] += msg.value;

        // Emit a deposit event
        emit Deposit(msg.sender, msg.value);
    }

    // Function to withdraw Ether from the contract
    function withdraw(uint256 amount) external {
        require(amount > 0, "Withdrawal amount must be greater than zero");
        require(balances[msg.sender] >= amount, "Insufficient balance");

        // Decrease the balance of the sender
        balances[msg.sender] -= amount;

        // Transfer the amount to the sender
        (bool success, ) = msg.sender.call{value: amount}("");
        require(success, "Transfer failed");

        // Emit a withdrawal event
        emit Withdrawal(msg.sender, amount);
    }

    // Function to transfer Ether from one address to another
    function transfer(address recipient, uint256 amount) external {
        require(recipient != address(0), "Cannot transfer to the zero address");
        require(amount > 0, "Transfer amount must be greater than zero");
        require(balances[msg.sender] >= amount, "Insufficient balance");

        // Decrease the sender's balance
        balances[msg.sender] -= amount;

        // Increase the recipient's balance
        balances[recipient] += amount;

        // Emit a transfer event
        emit Transfer(msg.sender, recipient, amount);
    }

    // Function to get the balance of a specific address
    function getBalance(address account) external view returns (uint256) {
        return balances[account];
    }
}
