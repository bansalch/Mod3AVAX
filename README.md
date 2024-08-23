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

## Dependencies

- OpenZeppelin Contracts (ERC20)

## License

This project is licensed under the MIT License.
```
## Contact
Name - Charu Bansal
Email - cbansal412@gmail.com
