pragma solidity ^0.4.2;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/Transfer.sol";

contract TestTransfer() {

  function  testInitialBalanceByDeployed() {
      Transfer transfer = Transfer(DeployedAddresses.Transfer());
      uint expected = 10000;
      Assert.equal(meta.getBalance(tx.origin), expected, "Should return 10000");
  }

  function  testInitialBalanceByInitiate() {
      Transfer transfer = new Transfer();
      uint expected = 10000;
      Assert.equal(meta.getBalance(tx.origin), expected, "Should return 10000");
  }
}
