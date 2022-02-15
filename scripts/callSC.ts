import Web3 from 'web3';

import HDWalletProvider from '@truffle/hdwallet-provider'
import * as dotenv from "dotenv";
import {resolve} from 'path'
import { TransactionReceipt } from "web3-core"
import util from 'util'

dotenv.config();

const { mnemonic, api_key } = require('../.secret.json');

const RPC = `https://rpc-mumbai.maticvigil.com/v1/${api_key}`;

const provider = new HDWalletProvider(mnemonic, RPC);
  
const web3 = new Web3(provider);

const testContract1 = require("../artifacts/contracts/testStore.sol/testStore.json");
const testContract2 = require("../artifacts/contracts/testConcat.sol/testConcat.json");

// contract address
const testContAddress1 = process.env.CONTRACT_ADDRESS1;
console.log(testContAddress1)
const testContAddress2 = process.env.CONTRACT_ADDRESS2;
console.log(testContAddress2)

let contInst1 = new web3.eth.Contract(
  testContract1.abi, testContAddress1
)

let contInst2 = new web3.eth.Contract(
  testContract2.abi, testContAddress2
)

async function callSC(baseURI:string) {
  let accounts: string[] = await web3.eth.getAccounts()
  console.log(accounts[0])
  
  //get latest nonce
  const nonce: number = await web3.eth.getTransactionCount(accounts[0], "latest")
  console.log(`nonce ${nonce}`)

  try {

    const sendOption = {
      from: accounts[0],
    };

    {
      let transactionResult: TransactionReceipt;  
      
      transactionResult = await contInst1.methods.assemblyStorage().call()
      console.log(util.inspect(transactionResult));

      transactionResult = await contInst1.methods.encode(1,2,3,4).send(sendOption)
      console.log(util.inspect(transactionResult));

      transactionResult = await contInst1.methods.getStoreValue().call()
      console.log(util.inspect(transactionResult));

      transactionResult = await contInst1.methods.decode().call()
      console.log(util.inspect(transactionResult));

      transactionResult = await contInst2.methods.exFunction1().call()
      console.log(util.inspect(transactionResult));

      transactionResult = await contInst2.methods.getValue().call()
      console.log(util.inspect(transactionResult));

      transactionResult = await contInst2.methods.exFunction2().call()
      console.log(util.inspect(transactionResult));

      transactionResult = await contInst2.methods.getValue().call()
      console.log(util.inspect(transactionResult));
    }
  
  } catch (err) {
    console.log(err)
  }
}

const comArgs = process.argv.slice(2)
console.log('Args: ', comArgs)
console.log(process.argv[2])

callSC(process.argv[2])