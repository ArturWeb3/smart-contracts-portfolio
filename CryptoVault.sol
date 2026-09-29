// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract CryptoVault {
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    receive() external payable {}

    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }

    function withdrawAll() public {
        require(msg.sender == owner, "You are not the owner!");
        
        (bool success, ) = payable(owner).call{value: address(this).balance}("");
        require(success, "Transfer failed!");
    }
}
