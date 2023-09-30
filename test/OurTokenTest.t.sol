// SPDX-License-Identifier: MIT License
pragma solidity ^0.8.18;

import {Test, console} from "forge-std/Test.sol";
import {DeployOurToken} from "../script/DeployOurToken.s.sol";
import {OurToken} from "../src/OurToken.sol";

contract OurTokenTest is Test {
    OurToken public ourToken;
    DeployOurToken public deployer;

    address bob = makeAddr("bob");
    address alice = makeAddr("alice");

    uint256 public constant STARTING_BALANCE = 200 ether;

    function setUp() public {
        deployer = new DeployOurToken();
        ourToken = deployer.run();

        console.log(
            "Sender",
            address(msg.sender),
            ourToken.balanceOf(msg.sender)
        );
        console.log(
            "deployer",
            (address(deployer)),
            ourToken.balanceOf(address(deployer))
        );
        console.log("bob", (bob), ourToken.balanceOf(bob));
        console.log("this", address(this), ourToken.balanceOf(address(this)));

        // vm.startBroadcast makes sure that any commands within it's bounds are being sent by the address of the root user calling the script
        // and not the address of the contract acting as the script. In our case that is the random account assigned by foundry during forge test
        // This is the same account running the test contract (msg.sender in test)
        vm.prank(msg.sender);
        ourToken.transfer(bob, STARTING_BALANCE);
    }

    function testBobbalance() public {
        assertEq(STARTING_BALANCE, ourToken.balanceOf(bob));
    }

    function testAllowances() public {
        uint256 initialAllowance = 1000;

        // bob approves alice to spend tokens on her behalf
        vm.prank(bob);
        ourToken.approve(alice, initialAllowance);

        uint256 transferAmount = 500;
        vm.prank(alice);
        ourToken.transferFrom(bob, alice, transferAmount);

        assertEq(ourToken.balanceOf(alice), transferAmount);
        assertEq(ourToken.balanceOf(bob), STARTING_BALANCE - transferAmount);
    }
}
