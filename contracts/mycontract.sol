// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.11;

contract Property {
    int public value;
    function setValue(int _value) public {
        value = _value;
    }
}