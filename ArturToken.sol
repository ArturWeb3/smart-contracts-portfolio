// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract ArturToken {
    string public name = "Artur Coin";   // Название твоей монеты
    string public symbol = "ART";        // Короткий тикер
    uint8 public decimals = 18;          // Стандартное деление монет
    uint256 public totalSupply;          // Общее количество монет в сети

    // База данных балансов пользователей
    mapping(address => uint256) public balanceOf;

    // Событие для фиксации переводов в блокчейне
    event Transfer(address indexed from, address indexed to, uint256 value);

    // При запуске контракта выпускаем 1 000 000 монет на твой кошелек
    constructor() {
        totalSupply = 1000000 * (10 ** uint256(decimals));
        balanceOf[msg.sender] = totalSupply;
    }

    // Функция перевода монет другому человеку
    function transfer(address _to, uint256 _value) public returns (bool success) {
        require(balanceOf[msg.sender] >= _value, "Not enough tokens!");
        
        balanceOf[msg.sender] -= _value;
        balanceOf[_to] += _value;
        
        emit Transfer(msg.sender, _to, _value);
        return true;
    }
}