// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.4;

contract Token {
    string public name = "XZZ Token";
    string public symbol = "XZZ";

    uint256 public totalSupply = 1000000;

    address public owner;

    mapping(address => uint256) balances;

    constructor() {
        balances[msg.sender] = totalSupply;
        owner = msg.sender;
    }

    function mint(address receiver, uint256 amount) public {
        require(msg.sender == owner, "Minter not authorized");
        balances[receiver] += amount;
    }

    error InsufficientBalance(uint256 requested, uint256 available);

    event Sent(address from, address to, uint256 amount);

    function transfer(address to, uint256 amount) external {
        if (amount > balances[msg.sender])
            revert InsufficientBalance({
                requested: amount,
                available: balances[msg.sender]
            });

        balances[msg.sender] -= amount;
        balances[to] += amount;
        emit Sent(msg.sender, to, amount);
    }

    function balanceOf(address account) external view returns (uint256) {
        return balances[account];
    }
}
