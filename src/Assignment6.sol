// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract Assignment6 {
   event FundsDeposited (address indexed sender, uint256 amount);  // 1. Declare an event called `FundsDeposited` with parameters: `sender` and `amount`

   event FundsWithdrawn (address indexed receiver, uint256 amount); // 2. Declare an event called `FundsWithdrawn` with parameters: `receiver` and `amount`

   mapping(address => uint256) public balances; // 3. Create a public mapping called `balances` to tracker users balances

    // Modifier to check if sender has enough balance
    modifier hasEnoughBalance(uint amount) {
        require(balances[msg.sender] >= amount, "Insufficient balance"); // Fill in the logic using require
        _;
    }

    // Function to deposit Ether
    // This function should:
    // - Be external and payable
    // - Emit the `FundsDeposited` event
    function deposit() external payable {
       balances[msg.sender] = balances[msg.sender] + msg.value; // increment user balance in balances mapping 

       emit FundsDeposited(msg.sender, msg.value); // emit suitable event
    }

    // Function to withdraw Ether
    // This function should:
    // - Be external
    // - Take one parameter: `amount`
    // - Use the `hasEnoughBalance` modifier
    // - Emit the `FundsWithdrawn` event
    function withdraw(uint256 amount) external hasEnoughBalance(amount){
        balances[msg.sender] = balances[msg.sender] - amount;    // decrement user balance from balances mapping 

        payable(msg.sender).transfer(amount); // send tokens to the caller

        emit FundsWithdrawn(msg.sender, amount);// emit suitable event

    }

    // Function to check the contract balance
    // This function should:
    // - Be public and view
    // - Return the contract's balance
    function getContractBalance() public view returns (uint256){
       return address(this).balance; // return the balance of the contract

    }
}
