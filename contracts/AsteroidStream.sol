
// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0;

// STEP 1: Import the right interfaces
import {
    ISuperfluid,
    ISuperToken,
    ISuperApp,
    ISuperAgreement,
    SuperAppDefinitions
} from "https://github.com/superfluid-finance/protocol-monorepo/blob/dev/packages/ethereum-contracts/contracts/interfaces/superfluid/ISuperfluid.sol";

import {
    IConstantFlowAgreementV1
} from "https://github.com/superfluid-finance/protocol-monorepo/blob/dev/packages/ethereum-contracts/contracts/interfaces/agreements/IConstantFlowAgreementV1.sol";

import {
    SuperAppBase
} from "https://github.com/superfluid-finance/protocol-monorepo/blob/dev/packages/ethereum-contracts/contracts/apps/SuperAppBase.sol";

// STEP 2: Create a Super App contract base using SuperAppBase (constants, properties and constructor)

/**
 * @dev A simple stream swap demo exchange your token1 for token2 and vice versa
 */
contract AsteroidStream is SuperAppBase {

    bytes32 private constant _AGREEMENT_TYPE_CFAv1 = keccak256("org.superfluid-finance.agreements.ConstantFlowAgreement.v1");

    ISuperfluid private host;
    IConstantFlowAgreementV1 private cfa;
    ISuperToken private superToken1;
    ISuperToken private superToken2;
    address private creator;
    int96 public maxFlow;
    string public name;

    event ExchangeHappened(ISuperToken inputToken, ISuperToken outputToken, int96 flowRate);

    constructor(
        ISuperfluid _host,
        ISuperToken _superToken1,
        ISuperToken _superToken2,
        address _creator,
        int96 _maxFlow,
        string memory _name
    ) {
        require(address(_host) != address(0), "host is nil");
        require(address(_superToken1) != address(0), "superToken1 is nil");
        require(address(_superToken2) != address(0), "superToken2 is nil");

        host = _host;
        cfa = IConstantFlowAgreementV1(address(host.getAgreementClass(_AGREEMENT_TYPE_CFAv1)));
        superToken1 = _superToken1;
        superToken2 = _superToken2;
        creator = _creator;
        name = _name;
        maxFlow = _maxFlow;
        
        uint256 configWord =
            SuperAppDefinitions.APP_LEVEL_FINAL |
            SuperAppDefinitions.BEFORE_AGREEMENT_CREATED_NOOP |
            SuperAppDefinitions.BEFORE_AGREEMENT_UPDATED_NOOP |
            SuperAppDefinitions.BEFORE_AGREEMENT_TERMINATED_NOOP;

        host.registerApp(configWord);
    }

    // STEP 3: The stream callbacks

    /**************************************************************************
    * SuperApp callbacks
    *************************************************************************/

    function afterAgreementCreated(
        ISuperToken superToken,
        address agreementClass,
        bytes32 agreementId,
        bytes calldata agreementData,
        bytes calldata /*cbdata*/,
        bytes calldata ctx
    )
        external override
        onlyExpected(superToken, agreementClass)
        onlyHost
        returns (bytes memory)
    {
        return _doExchange(ctx, superToken, agreementData, agreementId);
    }

    function afterAgreementTerminated(
        ISuperToken superToken,
        address agreementClass,
        bytes32 agreementId,
        bytes calldata agreementData,
        bytes calldata /*cbdata*/,
        bytes calldata ctx
    )
        external override
        onlyHost
        returns (bytes memory)
    {
        // According to the app basic law, we should never revert in a termination callback
        if (!_isAccepted(superToken) || !_isCFAv1(agreementClass)) return ctx;
        return _stopExchange(ctx, superToken, agreementData, agreementId);
    }

    function _doExchange(
        bytes calldata _ctx,
        ISuperToken inputToken,
        bytes memory agreementData,
        bytes32 agreementId
    )
        private
        returns (bytes memory newCtx)
    {
      // get info about the stream
      (address user, ) = abi.decode(agreementData, (address, address));
      (,int96 flowRate,,) = cfa.getFlowByID(inputToken, agreementId);

      // create flow
      (newCtx, ) = host.callAgreementWithContext(
          cfa,
          abi.encodeWithSelector(
              cfa.createFlow.selector,
              superToken2,
              user,
              flowRate,
              new bytes(0) // placeholder
          ),
          new bytes(0), // user data
          _ctx
      );

      emit ExchangeHappened(inputToken, superToken2, flowRate);
    }

    function _stopExchange(
        bytes calldata _ctx,
        ISuperToken inputToken,
        bytes memory agreementData,
        bytes32 /* agreementId */
    )
        private
        returns (bytes memory newCtx)
    {
      // select the other token
      ISuperToken outputToken;
      if(address(inputToken) == address(superToken1)) outputToken = superToken2;
      if(address(inputToken) == address(superToken2)) outputToken = superToken1;

      // get infor about the flow
      (address user, ) = abi.decode(agreementData, (address, address));
      (,int96 flowRate,,) = cfa.getFlow(outputToken, address(this), user);

      // delete flow
      (newCtx,) = host.callAgreementWithContext(
          cfa,
          abi.encodeWithSelector(
              cfa.deleteFlow.selector,
              outputToken,
              address(this),
              user,
              new bytes(0)
          ),
          new bytes(0), // user data
          _ctx
      );
    }
    
    function withdrawDAI() onlyCreator public {
        ISuperToken(superToken1).transfer(msg.sender, ISuperToken(superToken1).balanceOf(address(this)));
    }

    // utilities
    function _isAccepted(ISuperToken _superToken) private view returns (bool) {
        return address(_superToken) == address(superToken1);
    }

    function _isCFAv1(address _agreementClass) private view returns (bool) {
        return ISuperAgreement(_agreementClass).agreementType() == _AGREEMENT_TYPE_CFAv1;
    }

    modifier onlyHost() {
        require(msg.sender == address(host), "RedirectAll: support only one host");
        _;
    }
    
    modifier onlyCreator() {
        require(msg.sender == creator, "Creator: Only creator could call.");
        _;
    }

    modifier onlyExpected(ISuperToken _superToken, address _agreementClass) {
        require(_isAccepted(_superToken) , "Exchange: not accepted tokens");
        require(_isCFAv1(_agreementClass), "Exchange: only CFAv1 supported");
        _;
    }
}