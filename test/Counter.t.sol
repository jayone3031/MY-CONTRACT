// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test} from "forge-std/Test.sol";
import {Counter} from "../src/Counter.sol";

contract CounterTest is Test {
    Counter public counter;

    address _owner = msg.sender;
    address _safeAddress = address(0x123); // Replace with the desired address
    function setUp() public {
        counter = new Counter(_owner, _safeAddress);
    }

}
