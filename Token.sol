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
    function deposit() public payable {
        require(msg.value > 0, "Deposit amount must be greater than zero");

        // Increase the balance of the sender
        balances[msg.sender] += msg.value;

        // Emit a deposit event
        emit Deposit(msg.sender, msg.value);
    }

    // Function to withdraw Ether from the contract
    function withdraw(uint256 _amount) public {
        require(_amount > 0, "Withdrawal amount must be greater than zero");
        require(balances[msg.sender] >= _amount, "Insufficient balance");

        // Decrease the balance of the sender
        balances[msg.sender] -= _amount;

        // Transfer the amount to the sender
        payable(msg.sender).transfer(_amount);

        // Emit a withdrawal event
        emit Withdrawal(msg.sender, _amount);
    }

    // Function to transfer Ether from one address to another
    function transfer(address _recipient, uint256 _amount) public {
        require(_recipient != address(0), "Cannot transfer to the zero address");
        require(_amount > 0, "Transfer amount must be greater than zero");
        require(balances[msg.sender] >= _amount, "Insufficient balance");

        // Decrease the sender's balance
        balances[msg.sender] -= _amount;

        // Increase the recipient's balance
        balances[_recipient] += _amount;

        // Emit a transfer event
        emit Transfer(msg.sender, _recipient, _amount);
    }

    // Function to get the balance of a specific address
    function getBalance(address _account) public view returns (uint256) {
        return balances[_account];
    }
}
