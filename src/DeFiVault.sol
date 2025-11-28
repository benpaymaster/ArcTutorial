// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";

/**
 * @title DeFiVault
 * @dev Secure vault for deposits and withdrawals, demonstrating DeFi security best practices.
 */
contract DeFiVault is Ownable, ReentrancyGuard {
    IERC20 public immutable token;
    mapping(address => uint256) public balances;

    event Deposited(address indexed user, uint256 amount);
    event Withdrawn(address indexed user, uint256 amount);

    constructor(address _token) {
        require(_token != address(0), "Invalid token address");
        token = IERC20(_token);
    }

    /**
     * @dev Deposit tokens into the vault.
     */
    function deposit(uint256 amount) external nonReentrant {
        require(amount > 0, "Amount must be > 0");
        balances[msg.sender] += amount;
        require(
            token.transferFrom(msg.sender, address(this), amount),
            "Transfer failed"
        );
        emit Deposited(msg.sender, amount);
    }

    /**
     * @dev Withdraw tokens from the vault.
     */
    function withdraw(uint256 amount) external nonReentrant {
        require(amount > 0, "Amount must be > 0");
        require(balances[msg.sender] >= amount, "Insufficient balance");
        balances[msg.sender] -= amount;
        require(token.transfer(msg.sender, amount), "Transfer failed");
        emit Withdrawn(msg.sender, amount);
    }

    /**
     * @dev View user balance.
     */
    function getBalance(address user) external view returns (uint256) {
        return balances[user];
    }
}
