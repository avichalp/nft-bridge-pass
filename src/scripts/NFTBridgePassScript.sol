// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {console} from "forge-std/console.sol";

import {NFTBridgePass} from "../NFTBridgePass.sol";

// vm with cheatcodes
import {Vm} from "forge-std/Vm.sol";

contract NFTBridgePassScript {
    /// @notice hevm
    Vm constant vm =
        Vm(address(bytes20(uint160(uint256(keccak256("hevm cheat code"))))));

    function run() external {
        vm.deal(address(this), 1 ether);

        // Optimism's Kovan Bridge address
        address l2BridgeToken = address(
            0x22F24361D548e5FaAfb36d1437839f080363982B
        );

        NFTBridgePass nftBridgePass = new NFTBridgePass(l2BridgeToken);

        uint32 l2Gas = 1300000;

        uint256 tokenId = nftBridgePass.mint{value: 1 ether}(
            address(this),
            l2Gas
        );

        console.logString("tokenId:");
        console.logUint(tokenId);

        console.logString("name:");
        console.logString(nftBridgePass.name());
        console.logString("symbol:");
        console.logString(nftBridgePass.symbol());

        console.log("Balance Before:");
        console.log(
            nftBridgePass.balanceOf(address(this))
        );

        // If user transfers this NFT it get burned 😈
        address user = address(123456789);
        console.log("Balance Before (user):");
        console.log(nftBridgePass.balanceOf(user));
        nftBridgePass.transferFrom(address(this), user, tokenId);

        console.log("Balance After:");
        console.log(nftBridgePass.balanceOf(address(this)));
        console.log("Balance After (user):");
        console.log(nftBridgePass.balanceOf(user));
    }
}
