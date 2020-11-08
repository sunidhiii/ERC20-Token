
const fs = require('fs');
const Web3 = require('web3'); 
// Initialize provider.
const web3 = new Web3(new Web3.providers.HttpProvider("http://localhost:8545")); 

// Get the contract ABI from compiled smart contract json.
const contractABI = fs.readFileSync('ERC20_abi.json', 'utf-8');

//get address of compiled contract.
var contractAddress = 0x2BeC673Bd4c973e409BF056e7A16Bc7d0Eae0333;

const contract = new web3.eth.Contract(JSON.parse(contractABI), contractAddress, { from: '0x90...', gas: 100000});


//var contract = web3.eth.contract(contractABI).at(contractAddress);

//calling all accounts in accounts variable.
 const accounts = web3.eth.getAccounts();
 
 var admin = accounts[0];
 var sender = accounts[1];
//var receiver = accounts[2];

//interacting with banaceOf function to get balance of admin account.
const bal = contract.methods.balanceOf(admin).call();
console.log(bal);

//interacting with transfer function to transfer 100 tokens from admin to sender.
contract.methods.transfer(sender, 100, {from: admin}).send()
		.then(console.log)
		.catch(console.error);

//interacting with approve function to approve sender account to send 10 tokens from admin account.
contract.methods.approve(sender, 10, {from: admin}).send()
		.then(console.log)
		.catch(console.error);
