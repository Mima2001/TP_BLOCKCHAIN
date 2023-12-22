// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "forge-std/Test.sol";
import "src/simpleToken.sol";

contract SimpleTokenTest is Test {

    function test_initial_state() public {
        SimpleToken token = new SimpleToken("MyToken", "MTK", 18, 1000000);

        assertEq(token.name(), "MyToken");
        assertEq(token.symbol(), "MTK");
        assertEq(token.decimals(), 18);
        assertEq(token.totalSupply(), 1000000);
        assertEq(token.balanceOf(msg.sender), 1000000);
    }

    function test_transfer() public {
        SimpleToken token = new SimpleToken("MyToken", "MTK", 18, 1000000);
        address recipient = address(0x1234567890123456789012345678901234567890);

        token.transfer(recipient, 1000);

        assertEq(token.balanceOf(msg.sender), 999000);
        assertEq(token.balanceOf(recipient), 1000);
        assertEq(token.totalSupply(), 1000000);
        assertEq(token.balanceOf(msg.sender), 999000); // Check the balance after transfer
    }

    function test_transfer_fails_with_insufficient_balance() public {
        SimpleToken token = new SimpleToken("MyToken", "MTK", 18, 1000000);
        address recipient = address(0x1234567890123456789012345678901234567890);

        bool transferResult = token.transfer(recipient, 1000001);

        assertEq(transferResult, false); // Check that the transfer fails
        assertEq(token.balanceOf(msg.sender), 1000000); // Check that the balance remains unchanged
    }

    function test_approve_and_transfer_from() public {
        SimpleToken token = new SimpleToken("MyToken", "MTK", 18, 1000000);
        address spender = address(0xAbcDEF01234567890ABCDef0124567890AbcdeF0);

        token.approve(spender, 500);
        token.transferFrom(msg.sender, address(this), 400);

        assertEq(token.balanceOf(msg.sender), 996000);
        assertEq(token.balanceOf(address(this)), 400);
        assertEq(token.allowance(msg.sender, spender), 100);
    }
}
