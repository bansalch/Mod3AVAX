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
