// SPDX-License-Identifier: MIT License
pragma solidity ^0.8.18;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import {console} from "forge-std/Test.sol";

contract OurToken is ERC20 {
    constructor(uint256 initialSupply) ERC20("OurToken", "OT") {
        _mint(msg.sender, initialSupply);
        console.log("Sender in ourtoken", msg.sender);
        console.log("this in ourtoken", address(this));
    }
}
