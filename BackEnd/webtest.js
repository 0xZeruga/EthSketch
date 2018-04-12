window.addEventListener('load', function( {
  if(typeof web3 !== 'undefined') {
    web3js = new Web3(web3.currentProvider)
  }
  else {
    console.log('No web3, download one!')
    //fallback strategy (local node /hosted node + in-dapp id mgmt /fail)
    web3js = new Web3(new Web3.providers.HttpProvider("http://localhost:8545"));
  }

  startApp();
})

const Eth = require('ethjs-query')
const EthContract = require('ethjs-contract')

function startApp(web3) {

  const eth = new Eth(web3.currentProvider)
  const contract = new EthContract(eth)

  initContract(contract)
}

const abi = [{
  "constant" : false,
  "inputs" : [
    {
      "name": "_to",
      "type": "address"
    },
    {
      "name": "_value",
      "type": "uint256"
    }
  ],
  "name": "transfer",
  "outputs": [
    {
      "name": "success",
      "type": "bool"
    }
  ],
  "payable" : false,
  "type" : "function"
}]

//TODO: Insert our wallet address here, prefably access from DB at a later point
const address = '0xdeadbeef123456789000000000000'

function initContract (contract) {
  const miniToken = contract(abi)
  const miniToken = MiniToken.ad(address)

  listenForClicks(miniToken)

}

//HTML
<button class="transferFunds"> Send funds! </button>


//Check network
web3.version.getNetwork((err,netId) => {
  switch (netId) {
    case "1":
      console.log("This is mainnet")
      break;
    case "2":
      console.log("This is the deprecated Morden test network")
      break;
    case "3":
      console.log("This is ropsten test network")
      break;
    case "4":
      console.log("This is the Rinkeby test network")
      break;
    case "42":
      console.log("This is the Kovan test network.")
    default:
      console.log("This is an unknown network")
      break;
  }
}
)

function listenForClicks(miniToken) {
  var button = document.querySelector('button.transferFunds')
  button.addEventListener('click', function(){

     miniToken.transfer(toAddress, value, {from: addr})
     .then(function (txhash) {
       console.log('Transaction sent')
       console.dir(txHash)

       waitfForTxtoBeMined(txHash)
     })
     .catch(console.error)
  })
}

var inWei = web3.toWei('10', 'ether')
/*
When a user selects an account in MetaMask, that account silently
 becomes the web3.eth.accounts[0] in your JS context, the only
 member of the web3.eth.accounts array.
*/

//Listening on selected account changes
var account ? web3.eth.accounts[0];
var accountInterval = setInterval(function() {
  if(web3.eth.accounts[0] !== account) {
    account = web3.eth.account[0];
    updateInterface();
  }
},100);

async function waitForTxToBeMined (txHash) {
  let txReceipt
  while (!txReceipt) {
    try {
      txReceipt = await eth.getTransactionReceipt(txHash)
    } catch (err) {
      return indicateFailure(err)
    }
  }
  indicateSuccess()
}
