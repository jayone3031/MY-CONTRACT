// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script} from "forge-std/Script.sol";
import {Counter} from "../src/Counter.sol";
import "forge-std/console.sol";

contract DeployCounter is Script {
    Counter public counter;

    function setUp() public {}

    function run() public {
        uint256 privateKey = vm.envUint("PRIVATE_KEY");
        address owner = vm.addr(privateKey);
        address safeAddress = 0x629526dD9C989c5ae548892e674BAd661c813E1A; // Replace

        vm.startBroadcast(privateKey);
        counter = new Counter(owner, safeAddress);
        vm.stopBroadcast();
        console.log("Counter deployed to:", address(counter));
        }
    }