// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0;

import {
    ISuperfluid,
    ISuperToken,
    ISuperApp,
    ISuperAgreement,
    SuperAppDefinitions
} from "https://github.com/superfluid-finance/protocol-monorepo/blob/dev/packages/ethereum-contracts/contracts/interfaces/superfluid/ISuperfluid.sol";
import {
    ISuperTokenFactory
}
from "https://github.com/superfluid-finance/protocol-monorepo/blob/dev/packages/ethereum-contracts/contracts/interfaces/superfluid/ISuperTokenFactory.sol";
import {
    IConstantFlowAgreementV1
} from "https://github.com/superfluid-finance/protocol-monorepo/blob/dev/packages/ethereum-contracts/contracts/interfaces/agreements/IConstantFlowAgreementV1.sol";

import { INativeSuperToken, NativeSuperTokenProxy } from "./NativeSuperToken.sol";
import { AsteroidStream } from "./AsteroidStream.sol"; 

contract FluidMinersFactory {
    
    event NewAsteroid(address indexed asteroid, address indexed token, int96 maxFlow, uint256 supply);
    
    ISuperfluid private _host; // host
    ISuperToken private _daiToken; // accepted token
    ISuperTokenFactory private _superTokenFactory;
    
    constructor(     
        ISuperfluid host,
        ISuperToken daiToken,
        ISuperTokenFactory superTokenFactory
    ) {
        _host = host;
        _daiToken = daiToken;
        _superTokenFactory = superTokenFactory;
    }
    
    function deployAsteroid(
        uint256 _supply,
        int96 _maxFlow,
        string calldata _nameast,
        string calldata _name,
        string calldata _symbol
    ) external {
        // Deploy the Custom Super Token proxy
        INativeSuperToken newToken = INativeSuperToken(address(new NativeSuperTokenProxy()));
        // Deploy the machine using the new token address
        AsteroidStream stream = new AsteroidStream(_host, _daiToken, ISuperToken(address(newToken)), _maxFlow, _nameast);
        // Set the proxy to use the Super Token logic managed by Superfluid Protocol Governance
        _superTokenFactory.initializeCustomSuperToken(address(newToken));
        // Set up the token and mint tokens
        newToken.initialize(
            _name,
            _symbol,
            _supply,
            address(stream)
        );
        emit NewAsteroid(address(stream), address(newToken), _maxFlow, _supply);
    }
}