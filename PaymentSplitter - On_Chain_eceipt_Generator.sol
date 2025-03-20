// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract TransactionReceipt {
    // Struct to store transaction details
    struct Receipt {
        address sender;
        uint256 amount;
        uint256 timestamp;
    }

    // Mapping to store receipts for each sender
    mapping(uint256 => Receipt) public receipts;

    // Counter for receipt IDs
    uint256 public receiptCounter;

    // Event to log the issuance of a new receipt
    event ReceiptIssued(address indexed sender, uint256 amount, uint256 timestamp, uint256 receiptId);

    // Function to make a payment and issue a receipt
    function makePayment() public payable {
        require(msg.value > 0, "No funds sent");

        // Create a new receipt for the transaction
        receipts[receiptCounter] = Receipt({
            sender: msg.sender,
            amount: msg.value,
            timestamp: block.timestamp
        });

        // Emit an event for the receipt
        emit ReceiptIssued(msg.sender, msg.value, block.timestamp, receiptCounter);

        // Increment the receipt counter for the next receipt
        receiptCounter++;
    }

    // Function to retrieve a receipt by its ID
    function getReceipt(uint256 receiptId) public view returns (address, uint256, uint256) {
        Receipt memory receipt = receipts[receiptId];
        return (receipt.sender, receipt.amount, receipt.timestamp);
    }

    // Function to get the total number of receipts issued
    function getTotalReceipts() public view returns (uint256) {
        return receiptCounter;
    }
}
