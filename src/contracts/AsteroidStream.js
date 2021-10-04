const Contract = {
	abi: [
        {
            "inputs": [
                {
                    "internalType": "contract ISuperfluid",
                    "name": "_host",
                    "type": "address"
                },
                {
                    "internalType": "contract ISuperToken",
                    "name": "_superToken1",
                    "type": "address"
                },
                {
                    "internalType": "contract ISuperToken",
                    "name": "_superToken2",
                    "type": "address"
                },
                {
                    "internalType": "address",
                    "name": "_creator",
                    "type": "address"
                },
                {
                    "internalType": "int96",
                    "name": "_maxFlow",
                    "type": "int96"
                },
                {
                    "internalType": "string",
                    "name": "_name",
                    "type": "string"
                }
            ],
            "stateMutability": "nonpayable",
            "type": "constructor"
        },
        {
            "anonymous": false,
            "inputs": [
                {
                    "indexed": false,
                    "internalType": "contract ISuperToken",
                    "name": "inputToken",
                    "type": "address"
                },
                {
                    "indexed": false,
                    "internalType": "contract ISuperToken",
                    "name": "outputToken",
                    "type": "address"
                },
                {
                    "indexed": false,
                    "internalType": "int96",
                    "name": "flowRate",
                    "type": "int96"
                }
            ],
            "name": "ExchangeHappened",
            "type": "event"
        },
        {
            "inputs": [
                {
                    "internalType": "contract ISuperToken",
                    "name": "superToken",
                    "type": "address"
                },
                {
                    "internalType": "address",
                    "name": "agreementClass",
                    "type": "address"
                },
                {
                    "internalType": "bytes32",
                    "name": "agreementId",
                    "type": "bytes32"
                },
                {
                    "internalType": "bytes",
                    "name": "agreementData",
                    "type": "bytes"
                },
                {
                    "internalType": "bytes",
                    "name": "",
                    "type": "bytes"
                },
                {
                    "internalType": "bytes",
                    "name": "ctx",
                    "type": "bytes"
                }
            ],
            "name": "afterAgreementCreated",
            "outputs": [
                {
                    "internalType": "bytes",
                    "name": "",
                    "type": "bytes"
                }
            ],
            "stateMutability": "nonpayable",
            "type": "function"
        },
        {
            "inputs": [
                {
                    "internalType": "contract ISuperToken",
                    "name": "superToken",
                    "type": "address"
                },
                {
                    "internalType": "address",
                    "name": "agreementClass",
                    "type": "address"
                },
                {
                    "internalType": "bytes32",
                    "name": "agreementId",
                    "type": "bytes32"
                },
                {
                    "internalType": "bytes",
                    "name": "agreementData",
                    "type": "bytes"
                },
                {
                    "internalType": "bytes",
                    "name": "",
                    "type": "bytes"
                },
                {
                    "internalType": "bytes",
                    "name": "ctx",
                    "type": "bytes"
                }
            ],
            "name": "afterAgreementTerminated",
            "outputs": [
                {
                    "internalType": "bytes",
                    "name": "",
                    "type": "bytes"
                }
            ],
            "stateMutability": "nonpayable",
            "type": "function"
        },
        {
            "inputs": [
                {
                    "internalType": "contract ISuperToken",
                    "name": "",
                    "type": "address"
                },
                {
                    "internalType": "address",
                    "name": "",
                    "type": "address"
                },
                {
                    "internalType": "bytes32",
                    "name": "",
                    "type": "bytes32"
                },
                {
                    "internalType": "bytes",
                    "name": "",
                    "type": "bytes"
                },
                {
                    "internalType": "bytes",
                    "name": "",
                    "type": "bytes"
                },
                {
                    "internalType": "bytes",
                    "name": "",
                    "type": "bytes"
                }
            ],
            "name": "afterAgreementUpdated",
            "outputs": [
                {
                    "internalType": "bytes",
                    "name": "",
                    "type": "bytes"
                }
            ],
            "stateMutability": "nonpayable",
            "type": "function"
        },
        {
            "inputs": [
                {
                    "internalType": "contract ISuperToken",
                    "name": "",
                    "type": "address"
                },
                {
                    "internalType": "address",
                    "name": "",
                    "type": "address"
                },
                {
                    "internalType": "bytes32",
                    "name": "",
                    "type": "bytes32"
                },
                {
                    "internalType": "bytes",
                    "name": "",
                    "type": "bytes"
                },
                {
                    "internalType": "bytes",
                    "name": "",
                    "type": "bytes"
                }
            ],
            "name": "beforeAgreementCreated",
            "outputs": [
                {
                    "internalType": "bytes",
                    "name": "",
                    "type": "bytes"
                }
            ],
            "stateMutability": "view",
            "type": "function"
        },
        {
            "inputs": [
                {
                    "internalType": "contract ISuperToken",
                    "name": "",
                    "type": "address"
                },
                {
                    "internalType": "address",
                    "name": "",
                    "type": "address"
                },
                {
                    "internalType": "bytes32",
                    "name": "",
                    "type": "bytes32"
                },
                {
                    "internalType": "bytes",
                    "name": "",
                    "type": "bytes"
                },
                {
                    "internalType": "bytes",
                    "name": "",
                    "type": "bytes"
                }
            ],
            "name": "beforeAgreementTerminated",
            "outputs": [
                {
                    "internalType": "bytes",
                    "name": "",
                    "type": "bytes"
                }
            ],
            "stateMutability": "view",
            "type": "function"
        },
        {
            "inputs": [
                {
                    "internalType": "contract ISuperToken",
                    "name": "",
                    "type": "address"
                },
                {
                    "internalType": "address",
                    "name": "",
                    "type": "address"
                },
                {
                    "internalType": "bytes32",
                    "name": "",
                    "type": "bytes32"
                },
                {
                    "internalType": "bytes",
                    "name": "",
                    "type": "bytes"
                },
                {
                    "internalType": "bytes",
                    "name": "",
                    "type": "bytes"
                }
            ],
            "name": "beforeAgreementUpdated",
            "outputs": [
                {
                    "internalType": "bytes",
                    "name": "",
                    "type": "bytes"
                }
            ],
            "stateMutability": "view",
            "type": "function"
        },
        {
            "inputs": [],
            "name": "creator",
            "outputs": [
                {
                    "internalType": "address",
                    "name": "",
                    "type": "address"
                }
            ],
            "stateMutability": "view",
            "type": "function"
        },
        {
            "inputs": [],
            "name": "maxFlow",
            "outputs": [
                {
                    "internalType": "int96",
                    "name": "",
                    "type": "int96"
                }
            ],
            "stateMutability": "view",
            "type": "function"
        },
        {
            "inputs": [],
            "name": "name",
            "outputs": [
                {
                    "internalType": "string",
                    "name": "",
                    "type": "string"
                }
            ],
            "stateMutability": "view",
            "type": "function"
        },
        {
            "inputs": [],
            "name": "superToken2",
            "outputs": [
                {
                    "internalType": "contract ISuperToken",
                    "name": "",
                    "type": "address"
                }
            ],
            "stateMutability": "view",
            "type": "function"
        },
        {
            "inputs": [],
            "name": "withdrawDAI",
            "outputs": [],
            "stateMutability": "nonpayable",
            "type": "function"
        }
    ]
}

module.exports = Contract;