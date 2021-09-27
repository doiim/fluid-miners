const Contract = {
    addresses: {
		goerli: '0xC0AD2133B5feC9d3a3B6655e659955d45f749c22'
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