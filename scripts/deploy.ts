import { ethers } from 'hardhat';

async function main() {
	const testFactory1 = await ethers.getContractFactory('testStore');
	const testInstance1 = await testFactory1.deploy();
	console.log('First Contract deployed to address:', testInstance1.address);
  console.log((testInstance1.deployTransaction.gasLimit))

  const testFactory2 = await ethers.getContractFactory('testConcat');
	const testInstance2 = await testFactory2.deploy();
	console.log('2nd Contract deployed to address:', testInstance2.address);
  console.log((testInstance2.deployTransaction.gasLimit))
}

main()
	.then(() => process.exit(0))
	.catch((error) => {
		console.error(error);
		process.exit(1);
	});
