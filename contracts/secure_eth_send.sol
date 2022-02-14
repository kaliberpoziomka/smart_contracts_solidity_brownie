// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.5 <0.9.0;

contract MyDeposit {
    address public owner;

    constructor() {
        owner = msg.sender; // owner is the address that deployed contract
    }

    receive() external payable {
    }

    function getBalance() public view returns(uint){
        return address(this).balance;
    }

    // transfering ether from the contract to another address (recipient)
    function transferEther(address payable recipient, uint amount) public {
        require(owner == msg.sender, "Transfer failed, you are not the owner of this contract");
        if(amount <= this.getBalance()) {
            recipient.transfer(amount);
        }
    }

}