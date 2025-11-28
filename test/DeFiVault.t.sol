// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

import "forge-std/Test.sol" as ForgeTest;
import "../src/DeFiVault.sol" as VaultContract;
import "../src/GameToken.sol" as TokenContract;

contract DeFiVaultTest is ForgeTest.Test {
    VaultContract.DeFiVault vault;
    TokenContract.GameToken token;
    address user = address(0x1);

    function setUp() public {
        token = new TokenContract.GameToken();
        vault = new VaultContract.DeFiVault(address(token));
        token.transfer(user, 1000 ether);
        vm.startPrank(user);
        token.approve(address(vault), 1000 ether);
        vm.stopPrank();
    }

    function testDeposit() public {
        vm.startPrank(user);
        vault.deposit(100 ether);
        assertEq(vault.getBalance(user), 100 ether);
        vm.stopPrank();
    }

    function testWithdraw() public {
        vm.startPrank(user);
        vault.deposit(200 ether);
        vault.withdraw(50 ether);
        assertEq(vault.getBalance(user), 150 ether);
        vm.stopPrank();
    }

    function testWithdrawFailIfInsufficient() public {
        vm.startPrank(user);
        vault.deposit(10 ether);
        vm.expectRevert("Insufficient balance");
        vault.withdraw(20 ether);
        vm.stopPrank();
    }
}
