// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract Crowdfunding {
    address public creator;     // Автор сбора (ты)
    uint256 public targetGoal;  // Финансовая цель (в wei)
    uint256 public raisedAmount;// Сколько уже собрали

    // База данных: связываем адрес инвестора с его суммой
    mapping(address => uint256) public contributions;

    // При создании контракта указываем цель сбора (например, на мощный ПК)
    constructor(uint256 _goal) {
        creator = msg.sender;
        targetGoal = _goal;
    }

    // Функция инвестирования (инвестор шлет крипту)
    function fund() public payable {
        require(msg.value > 0, "You need to send some ETH!");
        
        contributions[msg.sender] += msg.value; // Записываем в базу данных
        raisedAmount += msg.value;              // Увеличиваем общий сбор
    }

    // Автор сбора забирает деньги, если цель достигнута
    function withdrawFunds() public {
        require(msg.sender == creator, "You are not the creator!");
        require(raisedAmount >= targetGoal, "Goal not reached yet!");

        (bool success, ) = payable(creator).call{value: address(this).balance}("");
        require(success, "Transfer failed!");
    }
}