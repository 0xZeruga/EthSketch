pragma solidity ^0.4.20;

import "./AccessRestriction.sol";

/*This contract will handle the Ether recieved from
  transactions and send it to the vault which is private.
*/
contract Vault {

  address private owner = msg.sender;

  modifier ownerFunc {
      require(owner == msg.sender);
      _;
  }
  //Initial Balance for testing
  function Vault {
    address(this).balance = 10000;
  }

  //This is called automatically when contract recieves Ether.
  function () public payable {
  }

  //Ensures only owner can see value at address
  function getBalance() constant private returns (uint) {
    require(ownerFunc);
    return address(this).balance;
  }
}

/*This contract will be hidden for other user
  Ether recieved will be stored ethereum
*/
contract Bank {
  Vault private vault;

  function Bank() public {
    vault = new Vault();
  }

  function getBalance() public returns (uint) {
    return address(this).balance;
  }

  function getBalanceFromVault() public returns (uint) {
    return vault.getBalance();
  }
  //Ether sent to this address will be sent to Vault instantly
  function () public payable {
    address(vault).send(msg.value);
  }
}
