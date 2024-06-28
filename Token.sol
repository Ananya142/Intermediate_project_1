// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract RequireAssertRevert {
    address private owner;
    mapping(address => uint) private balances;

    constructor() {
        owner = msg.sender;
    }

    function deposit(uint _amount) public {
        // Require that the sender is the owner
        require(msg.sender == owner, "Only the owner can deposit funds");

        // Increase the balance
        balances[msg.sender] += _amount;
    }

    function withdraw(uint _amount) public {
        // Assert that the balance is sufficient
        assert(balances[msg.sender] >= _amount);

        // Decrease the balance
        balances[msg.sender] -= _amount;
    }

    function transfer(address _recipient, uint _amount) public {
        // Revert if the recipient is the zero address
        if (_recipient == address(0)) {
            revert("Cannot transfer to the zero address");
        }

        // Ensure sender has sufficient balance
        require(balances[msg.sender] >= _amount, "Insufficient balance");

        // Decrease the sender's balance
        balances[msg.sender] -= _amount;

        // Increase the recipient's balance
        balances[_recipient] += _amount;
    }

    function getBalance(address _account) public view returns (uint) {
        return balances[_account];
    }
}
