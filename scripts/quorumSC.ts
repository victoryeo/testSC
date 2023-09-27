import { ethers } from 'ethers';

import * as dotenv from "dotenv";
import { TransactionReceipt } from "web3-core"
import util from 'util'

dotenv.config();

//private key of the account that will deploy the contract
//without 0x prefix
const privateKey = 'b2cc9877079f7d399f34d33cc1e2ba37b544c0c5177e72b0d1740f0e75d10125';

//rpc with bpaas api key
const rpcUrl = 'https://node1-1b40.gke-singapore.settlemint.com/bpaas-12B4AE7e6E6CF6838cd89C32C6DB9c5dBD72acDf';

//abi of the contract
const erc721Contract = require("../abi/ExampleErc721.json");
const genericContract = require("../abi/Generic.json");

// contract address
const testContAddress1 = '0xaef74d4130a199d644A4BF3a13A3D3EF42eBb0a2';
console.log(testContAddress1)
const genericContAddress = '0xd9a57b902a52988a1BB7da7c86Db5c4e65ab5196';
console.log(genericContAddress)

const provider = new ethers.providers.JsonRpcProvider(rpcUrl);
const wallet = new ethers.Wallet(privateKey, provider);
const erc721Instance = new ethers.Contract(
  testContAddress1,
  erc721Contract,
  wallet
);

const genericInstance = new ethers.Contract(
  genericContAddress,
  genericContract,
  wallet
);

async function callSC() {
  console.log("callSC")
  try {

    const gasPrice = 0;
    const gasLimit = '5000000';

    const sendOption = { gasPrice, gasLimit };

    let transactionResult: TransactionReceipt;
    let baseURI = "ipfs://bafybeigdyrzt5sfp7udm7hu76uh7y26nf3efuylqabf3oclgtqy55fbzdi"
    
    transactionResult = await erc721Instance.setBaseURI(baseURI, sendOption)
    console.log(util.inspect(transactionResult));

    transactionResult = await erc721Instance.collectReserves(sendOption)
    console.log(util.inspect(transactionResult));

    const retTokenURI = await erc721Instance.tokenURI(1)
    console.log(retTokenURI)

    transactionResult = await genericInstance.addParams('1','2','3',
    '4','5','6','7','8','9');
    console.log(util.inspect(transactionResult));

  } catch (err) {
    console.log(err)
  }
}

const comArgs = process.argv.slice(2)
console.log('Args: ', comArgs)
console.log('Argv2', process.argv[2])

callSC().then(() => {
  console.log('done')
}).catch(err => {
  console.log(err)
})