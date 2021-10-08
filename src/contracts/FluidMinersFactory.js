const Contract = {
    addresses: {
		goerli: '0x6478398BC205192866bDAF93D71966322cb78292',
		maticmum: '0xA0100c8FFD21e129A9469F8585b1cCa767650DAB',
		ropsten: '0xE84ceC51952b5a6C882B898d541ecFe13c611d34'
	},
	abi: [
	{
		"inputs": [
			{
				"internalType": "contract ISuperfluid",
				"name": "host",
				"type": "address"
			},
			{
				"internalType": "contract ISuperToken",
				"name": "daiToken",
				"type": "address"
			},
			{
				"internalType": "contract ISuperTokenFactory",
				"name": "superTokenFactory",
				"type": "address"
			}
		],
		"stateMutability": "nonpayable",
		"type": "constructor"
	},
	{
		"anonymous": false,
		"inputs": [
			{
				"indexed": true,
				"internalType": "address",
				"name": "asteroid",
				"type": "address"
			},
			{
				"indexed": true,
				"internalType": "address",
				"name": "token",
				"type": "address"
			},
			{
				"indexed": false,
				"internalType": "int96",
				"name": "maxFlow",
				"type": "int96"
			},
			{
				"indexed": false,
				"internalType": "uint256",
				"name": "supply",
				"type": "uint256"
			}
		],
		"name": "NewAsteroid",
		"type": "event"
	},
	{
		"inputs": [
			{
				"internalType": "uint256",
				"name": "_supply",
				"type": "uint256"
			},
			{
				"internalType": "int96",
				"name": "_maxFlow",
				"type": "int96"
			},
			{
				"internalType": "string",
				"name": "_nameast",
				"type": "string"
			},
			{
				"internalType": "string",
				"name": "_name",
				"type": "string"
			},
			{
				"internalType": "string",
				"name": "_symbol",
				"type": "string"
			}
		],
		"name": "deployAsteroid",
		"outputs": [],
		"stateMutability": "nonpayable",
		"type": "function"
	}
    ]
}

module.exports = Contract;