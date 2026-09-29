// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract MyFirstContract {
    string public developerName;

    function setDeveloper(string memory _name) public {
        developerName = _name;
    }

    function sayHello() public view returns (string memory) {
        return string(abi.encodePacked("Hello World! This contract was built by ", developerName));
    }
}