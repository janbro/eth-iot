import RpiLeds from 'rpi-leds';
import Web3 from 'web3';
import gpio from 'gpio';

let LOCAL_HTTP_PROVIDER = 'http://localhost:8545';
let web3 = new Web3();

export default (app) => {
	web3 = new Web3(new Web3.providers.HttpProvider(LOCAL_HTTP_PROVIDER));

	var contractAddress = '';

	var ABI = JSON.parse();

	const memberContract = web3.eth.contract(ABI).at(contractAddress);

	memberContract.newMember({}, (member, level) => {
		console.log(member + " joined");
		console.log(level);
	});

	return app;
}
