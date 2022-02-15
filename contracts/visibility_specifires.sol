// SPDX-License-Identifier: UNLICENSED

pragma solidity >=0.5.0 <0.9.0;

contract A {
    int public x = 10;
    int y = 20;

    function get_y() public view returns(int) {
        return y;
    }

    function f1() private view returns(int) {
        return x;
    }

    function f2() public view returns (int) {
        int a;
        a = f1();
        return a;
    }

    function f3() internal view returns (int) {
        return x;
    }

    // external func can only be called from outside
    // they are more efficient in gas consuption
    function f4() external view returns(int) {
        return x;
    }

    function f5() public pure returns(int) {
        int b = 1;
        return b;
    }

}

contract B is A {
    int public xx = f3();
    //int public yy = f1(); -> this is private so cannot be seen from external contract
   // int public yy = f4(); <- this cannot be called
}

contract C {
    A contract_a = new A(); // contract C deploys contract A
    int public xx = contract_a.f4(); // <- you can call external function from another contract
}