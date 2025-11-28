// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

contract GasOptimizedToken {
    // Packing variables: balances and flags into one storage slot
    struct UserData {
        uint128 balance; // smaller type, fits with flags
        uint8 flags; // up to 8 boolean flags
    }

    mapping(address => UserData) private users;

    // Use calldata for input arrays
    function batchTransfer(
        address[] calldata recipients,
        uint128 amount
    ) external {
        UserData storage sender = users[msg.sender];
        require(
            sender.balance >= amount * uint128(recipients.length),
            "Insufficient balance"
        );
        sender.balance -= amount * uint128(recipients.length);
        for (uint256 i = 0; i < recipients.length; ++i) {
            users[recipients[i]].balance += amount;
        }
    }

    // Minimize state changes: only update if necessary
    function setFlag(uint8 flagIndex, bool value) external {
        require(flagIndex < 8, "Invalid flag");
        UserData storage user = users[msg.sender];
        uint8 mask = uint8(1) << flagIndex;
        if (value) {
            user.flags |= mask;
        } else {
            user.flags &= ~mask;
        }
    }

    // Example: deposit function
    function deposit(uint128 amount) external {
        users[msg.sender].balance += amount;
    }

    function getBalance(address account) external view returns (uint128) {
        return users[account].balance;
    }

    function getFlags(address account) external view returns (uint8) {
        return users[account].flags;
    }
}
