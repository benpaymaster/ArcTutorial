// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

import "forge-std/Test.sol" as ForgeTest;
import "../src/GasOptimizedToken.sol" as GasTokenContract;

contract GasOptimizedTokenTest is ForgeTest.Test {
    GasTokenContract.GasOptimizedToken token;

    function setUp() public {
        token = new GasTokenContract.GasOptimizedToken();
    }

    function testDepositAndBalance() public {
        token.deposit(100);
        assertEq(token.getBalance(address(this)), 100);
    }

    function testBatchTransfer() public {
        token.deposit(300);
        address recipient1 = address(0x1);
        address recipient2 = address(0x2);
        address[] memory recipients = new address[](2);
        recipients[0] = recipient1;
        recipients[1] = recipient2;
        token.batchTransfer(recipients, 100);
        assertEq(token.getBalance(recipient1), 100);
        assertEq(token.getBalance(recipient2), 100);
        assertEq(token.getBalance(address(this)), 100);
    }

    function testSetFlag() public {
        token.setFlag(2, true);
        assertEq(token.getFlags(address(this)), 4); // 2^2 = 4
        token.setFlag(2, false);
        assertEq(token.getFlags(address(this)), 0);
    }
}
