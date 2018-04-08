var Transfer = artifacts.require("./Transfer.sol");

contract('Transfer', function(accounts) {
  it("should have 10000", function() {
    return Transfer.deployed().then(function(instance) {
      return instance.getBalanceInEth.call(account[0]);
    }).then(function(balance) {
      assert.equal(balance.valueOf(),10000,"10000 was default value");
    });
  });
});
