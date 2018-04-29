pragma solidity 0.4.20


contract SmartToken {
        //Store mapping of address and tokens (like a hashmap)
    mapping(address => uint) public tokens;
    event OnamountChanged(address indexed _fromAddress, uint _amount);

//Transfer an amount from one account to another.
//This will be called from frontend
    function transfer(address fromAddress, address toAddress, uint amount) returns (bool success) {
        //Cannot transfer to same account
        if (fromAddress == toAddress) {
            return false;
        }

//Change Accounts Balance
        if ((tokens[fromAddress] - amount) < 0) {
            //Transfer entire amount
            token[toAddress] += tokens[fromAddress];
            tokens[fromAddress] = 0;
        } else {
            token[toAddress] += amount;
            tokens[fromAddress] -= amount;
        }

        OnamountChanged(fromAddress, tokens[fromAddress]);
        return true;
    }
}
