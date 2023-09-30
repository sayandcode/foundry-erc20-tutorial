// SPDX-License-Identifier: MIT License
pragma solidity ^0.8.18;

import {Script} from "forge-std/Script.sol";
import {console} from "forge-std/Test.sol";
import {OurToken} from "../src/OurToken.sol";

contract DeployOurToken is Script {
    uint256 public constant INITIAL_SUPPLY = 1100 ether;

    function run() external returns (OurToken) {
        vm.startBroadcast();
        OurToken ourToken = new OurToken(INITIAL_SUPPLY);
        console.log(
            "Sender in deployourtoken",
            msg.sender,
            ourToken.balanceOf(msg.sender)
        );
        console.log(
            "this in deployourtoken",
            address(this),
            ourToken.balanceOf(address(this))
        );
        vm.stopBroadcast();
        console.log(
            "this outside vm in deployourtoken",
            address(this),
            ourToken.balanceOf(address(this))
        );
        console.log(
            "Sender outside vm in deployourtoken",
            address(msg.sender),
            ourToken.balanceOf(address(msg.sender))
        );
        return ourToken;
    }
}
