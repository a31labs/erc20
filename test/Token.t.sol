// SPDX-License-Identifier: MIT
pragma solidity ^0.8.27;

import "../src/Token.sol";
import {Test} from "../lib/forge-std/src/Test.sol";

contract TokenTest is Test {
    Token token;
    address owner = address(0xABCD);
    address user1 = address(0x1234);
    address user2 = address(0x5678);
    string constant NAME = "TestToken";
    string constant SYMBOL = "TTK";
    uint8 constant DECIMALS = 18;

    function setUp() public {
        vm.prank(owner);
        token = new Token(owner, NAME, SYMBOL, DECIMALS);
    }

    function testInitialValues() public view {
        assertEq(token.name(), NAME);
        assertEq(token.symbol(), SYMBOL);
        assertEq(token.decimals(), DECIMALS);
        assertEq(token.totalSupply(), 0);
    }

    function testMintByOwner() public {
        uint256 amount = 1000 * 10 ** DECIMALS;
        vm.prank(owner);
        token.mint(user1, amount);
        assertEq(token.balanceOf(user1), amount);
        assertEq(token.totalSupply(), amount);
    }

    function testMintByNonOwnerReverts() public {
        uint256 amount = 1000 * 10 ** DECIMALS;
        vm.prank(user1);
        vm.expectRevert();
        token.mint(user1, amount);
    }

    function testTransfer() public {
        uint256 amount = 1000 * 10 ** DECIMALS;
        vm.prank(owner);
        token.mint(owner, amount);
        vm.prank(owner);
        token.transfer(user1, 500 * 10 ** DECIMALS);
        assertEq(token.balanceOf(user1), 500 * 10 ** DECIMALS);
        assertEq(token.balanceOf(owner), 500 * 10 ** DECIMALS);
    }

    function testBurn() public {
        uint256 amount = 1000 * 10 ** DECIMALS;
        vm.prank(owner);
        token.mint(user1, amount);
        vm.prank(user1);
        token.burn(400 * 10 ** DECIMALS);
        assertEq(token.balanceOf(user1), 600 * 10 ** DECIMALS);
        assertEq(token.totalSupply(), 600 * 10 ** DECIMALS);
    }

    function testBurnFrom() public {
        uint256 amount = 1000 * 10 ** DECIMALS;
        vm.prank(owner);
        token.mint(user1, amount);
        vm.prank(user1);
        token.approve(owner, 500 * 10 ** DECIMALS);
        vm.prank(owner);
        token.burnFrom(user1, 500 * 10 ** DECIMALS);
        assertEq(token.balanceOf(user1), 500 * 10 ** DECIMALS);
        assertEq(token.totalSupply(), 500 * 10 ** DECIMALS);
    }
}
