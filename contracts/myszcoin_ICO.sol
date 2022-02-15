// SPDX-License-Identifier: UNLICENSED

pragma solidity >=0.5.0 <0.9.0;

// myszcoins ICO

contract myszcoin_ICO { // our contract in for myszcoin

    // Introducing the maximum number of myszcoins available for sale
    uint public max_myszcoins = 1000000;

    // Introducing the USD to myszcoin conversion rate
    uint public usd_to_myszcoins = 1000;

    // Introducing the total number of myszcoins that have been bought by the investors
    uint public total_myszcoins_bought = 0;

    // Mapping from the investor address to its equity in myszcoins and USD
    mapping(address => uint) equity_myszcoins;
    mapping(address => uint) equity_usd;

    // Checking if an investor can buy myszcoins
    modifier can_buy_myszcoins(uint usd_invested) {
        require (usd_invested * usd_to_myszcoins + total_myszcoins_bought <= max_myszcoins);
        _;
    }

    // Checking if enough myszcoins on wallet to send
    modifier enough_myszcoins_to_send(address investor, uint myszcoins_to_use) {
        require (myszcoins_to_use <= equity_myszcoins[investor]);
        _;
    }

    // Getting the equty in myszcoins of an investor
    function equity_in_myszcoins(address investor)public view returns(uint) {
        return equity_myszcoins[investor];
    }

    // Getting the equty in usd of an investor
    function equity_in_usd(address investor) public view returns (uint) {
        return equity_usd[investor];
    }

    // Buying myszcoins
    function buying_myszcoins(address investor, uint usd_invested) external
    can_buy_myszcoins(usd_invested) { // modifier - it checks if the buyer can buy myszcoins with the amount they want
        uint myszcoins_bought = usd_invested * usd_to_myszcoins;
        equity_myszcoins[investor] += myszcoins_bought;
        equity_usd[investor] += equity_myszcoins[investor] / usd_to_myszcoins;
        total_myszcoins_bought += myszcoins_bought;
    }


    // Selling myszcoins
    function selling_myszcoins(address investor, uint myszcoins_sold) external
    {
        equity_myszcoins[investor] -= myszcoins_sold;
        equity_usd[investor] = equity_myszcoins[investor] / usd_to_myszcoins;
        total_myszcoins_bought -= myszcoins_sold;
    }

    // Transfer of myszcoins
    function transfer_myszcoins(address investor1, address investor2, uint myszcoins_amount) external
    enough_myszcoins_to_send(investor1, myszcoins_amount) {
        equity_myszcoins[investor1] -= myszcoins_amount;
        equity_usd[investor1] = equity_myszcoins[investor1] / usd_to_myszcoins;
        equity_myszcoins[investor2] += myszcoins_amount;
        equity_usd[investor2] = equity_myszcoins[investor2] / usd_to_myszcoins;
    }


}