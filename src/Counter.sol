// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// Import OpenZeppelin contracts from node_modules (installed via npm)
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

// This contract lets the owner (your MetaMask wallet) drain ERC20 tokens to a safe address
contract Counter is Ownable {
    // The address where tokens will be sent (your backup wallet, e.g., a hardware wallet)
    address public safeAddress;

    // Constructor: Sets the owner (for Ownable) and safe address
    // _owner: Your MetaMask address (who can call emergencyDrain)
    // _safeAddress: Your backup wallet address (where tokens go)
    constructor(address _owner, address _safeAddress) Ownable(_owner) {
        require(_safeAddress != address(0), "Invalid safe address"); // Prevent zero address
        safeAddress = _safeAddress;
    }

    // Drains all approved ERC20 tokens to safeAddress in one transaction
    // tokenAddresses: List of ERC20 token contract addresses (e.g., USDT, DAI)
    // Only the owner can call this
    function emergencyDrain(address[] calldata tokenAddresses) external onlyOwner {
        // Loop through each token address
        for (uint256 i = 0; i < tokenAddresses.length; i++) {
            IERC20 token = IERC20(tokenAddresses[i]); // Get token contract
            uint256 balance = token.balanceOf(msg.sender); // Your wallet's balance
            uint256 allowance = token.allowance(msg.sender, address(this)); // Approved amount
            
            // Use smaller of balance or allowance to avoid errors
            uint256 drainAmount = balance < allowance ? balance : allowance;
            if (drainAmount > 0) {
                // Transfer tokens to safeAddress
                bool success = token.transferFrom(msg.sender, safeAddress, drainAmount);
                require(success, "Transfer failed");
            }
        }
    }

    // Update safeAddress if you change wallets
    // Only owner can call
    function updateSafeAddress(address _newSafeAddress) external onlyOwner {
        require(_newSafeAddress != address(0), "Invalid address");
        safeAddress = _newSafeAddress;
    }
}