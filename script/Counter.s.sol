// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script} from "forge-std/Script.sol";
import {Counter} from "../src/Counter.sol";

contract CounterScript is Script {
    Counter public counter;

    function setUp() public {}

    function run() public {
        vm.startBroadcast();

        address _owner = msg.sender;
        address _safeAddress = address(0x123); // Replace with the desired address

        counter = new Counter(_owner, _safeAddress);

        vm.stopBroadcast();
    }
}
