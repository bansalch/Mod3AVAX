# ScholarshipToken Smart Contract

This smart contract implements a scholarship token system on the Ethereum blockchain using the ERC20 standard.

## Overview

ScholarshipToken is an ERC20 token that allows a supervisor to manage student enrollments and token distribution. 
It provides functionality for creating new tokens, enrolling students, and managing token transfers.

## Features

- ERC20 compliant token
- Student enrollment system
- Supervisor-controlled token minting
- Token transfer and redemption

## Contract Details

- Token Name: SCHOLARSHIP COIN
- Token Symbol: SCH
- Solidity Version: ^0.8.10
- License: MIT

## Key Functions

### Supervisor Functions

- `createNewCoins(uint quantity)`: Mint new tokens (supervisor only)
- `enrollStudent(address walletAddress, uint score)`: Enroll a new student (supervisor only)

### Public Functions

- `getEnrolledStudents()`: Retrieve the list of enrolled students
- `sendCoins(address recipient, uint quantity)`: Transfer tokens to another address
- `redeemCoins(uint quantity)`: Burn (redeem) tokens

## Student Structure

Each student is represented by:
- Student ID
- Wallet address
- Score (0-100)
- Coin balance

## Usage

1. Deploy the contract (deployer becomes the supervisor)
2. Use `createNewCoins` to mint additional tokens if needed
3. Enroll students using `enrollStudent`
4. Students can transfer tokens using `sendCoins`
5. Students can redeem tokens using `redeemCoins`

## Complete Program
~~~
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract ScholarshipToken is ERC20 {

    struct Student {
        uint studentId;
        address walletAddress;
        uint score;
        uint coinBalance;
    }

    uint private _studentCount;
    mapping(address => uint) private _studentRegistry;
    address private _supervisor;

    modifier onlySupervisor() {
        require(msg.sender == _supervisor, "Access denied: Supervisor only");
        _;
    }

    Student[] private _studentBody;

    constructor() ERC20("SCHOLARSHIP COIN", "SCH") {
        _supervisor = msg.sender;
        _mint(_supervisor, 10000000000 * 10 ** decimals()); // Initial supply with decimals
    }

    function createNewCoins(uint quantity) external onlySupervisor {
        _mint(_supervisor, quantity);
    }

    function enrollStudent(address walletAddress, uint score) external onlySupervisor {
        require(score <= 100, "Score must not exceed 100");
        require(_studentRegistry[walletAddress] == 0, "Student already enrolled");

        Student memory newStudent = Student({
            studentId: _studentCount,
            walletAddress: walletAddress,
            score: score,
            coinBalance: balanceOf(walletAddress)
        });

        _studentBody.push(newStudent);
        _studentRegistry[walletAddress] = _studentCount;
        _studentCount++;
    }

    function getEnrolledStudents() external view returns (Student[] memory) {
        return _studentBody;
    }

    function sendCoins(address recipient, uint quantity) external {
        require(balanceOf(msg.sender) >= quantity, "Insufficient coins");
        _transfer(msg.sender, recipient, quantity);
    }

    function redeemCoins(uint quantity) external {
        _burn(msg.sender, quantity);
    }
}
~~~

## Dependencies

- OpenZeppelin Contracts (ERC20)

## License

This project is licensed under the MIT License.
```
## Contact
Name - Charu Bansal
Email - cbansal412@gmail.com
