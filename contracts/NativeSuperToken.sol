// SPDX-License-Identifier: AGPLv3
pragma solidity >=0.7.0;

import {
    ISuperToken
}
from "https://github.com/superfluid-finance/protocol-monorepo/blob/dev/packages/ethereum-contracts/contracts/interfaces/superfluid/ISuperToken.sol";
import { IERC20 } from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import { Proxy } from "@openzeppelin/contracts/proxy/Proxy.sol";

/**
 * @title UUPS (Universal Upgradeable Proxy Standard) Shared Library
 */
library UUPSUtils {

    /**
     * @dev Implementation slot constant.
     * Using https://eips.ethereum.org/EIPS/eip-1967 standard
     * Storage slot 0x360894a13ba1a3210667c828492db98dca3e2076cc3735a920a3ca505d382bbc
     * (obtained as bytes32(uint256(keccak256('eip1967.proxy.implementation')) - 1)).
     */
    bytes32 internal constant _IMPLEMENTATION_SLOT = 0x360894a13ba1a3210667c828492db98dca3e2076cc3735a920a3ca505d382bbc;

    /// @dev Get implementation address.
    function implementation() internal view returns (address impl) {
        assembly { // solium-disable-line
            impl := sload(_IMPLEMENTATION_SLOT)
        }
    }

    /// @dev Set new implementation address.
    function setImplementation(address codeAddress) internal {
        assembly {
            // solium-disable-line
            sstore(
                _IMPLEMENTATION_SLOT,
                codeAddress
            )
        }
    }

}

/**
 * @dev UUPS (Universal Upgradeable Proxy Standard) Proxy
 *
 * NOTE:
 * - Compliant with [Universal Upgradeable Proxy Standard](https://eips.ethereum.org/EIPS/eip-1822)
 * - Compiiant with [Standard Proxy Storage Slots](https://eips.ethereum.org/EIPS/eip-1967)
 * - Implements delegation of calls to other contracts, with proper forwarding of
 *   return values and bubbling of failures.
 * - It defines a fallback function that delegates all calls to the implementation.
 */
contract UUPSProxy is Proxy {

    /**
     * @dev Proxy initialization function.
     *      This should only be called once and it is permission-less.
     * @param initialAddress Initial logic contract code address to be used.
     */
    function initializeProxy(address initialAddress) external {
        require(initialAddress != address(0), "UUPSProxy: zero address");
        require(UUPSUtils.implementation() == address(0), "UUPSProxy: already initialized");
        UUPSUtils.setImplementation(initialAddress);
    }

    /// @dev Proxy._implementation implementation
    function _implementation() internal virtual override view returns (address)
    {
        return UUPSUtils.implementation();
    }

}

/**
 * @dev Custom super token proxy base contract
 *
 * NOTE:
 * - Because of how solidity is layouting its storages variables and custom
 *   super token inherits the Super Token standard implementation, so it is
 *   required that the custom token proxy would need to pad its implementation
 *   with reserved storages used by the Super Token implementation.
 * - Refer to SETH.sol for an example how it is used.
 */
abstract contract CustomSuperTokenProxyBase is UUPSProxy {
    // This is the hard-coded number of storage slots used by the super token
    uint256[32] internal _storagePaddings;
}


/**
 * @dev Native SuperToken custom token functions
 *
 * @author Superfluid
 */
interface INativeSuperTokenCustom {
    function initialize(string calldata name, string calldata symbol, uint256 initialSupply, address recipient) external;
}

/**
 * @dev Native SuperToken full interface
 *
 * @author Superfluid
 */
interface INativeSuperToken is INativeSuperTokenCustom, ISuperToken {
    function initialize(string calldata name, string calldata symbol, uint256 initialSupply, address recipient) external override;
}

/**
 * @dev Native SuperToken custom super token implementation
 *
 * NOTE:
 * - This is a simple implementation where the supply is pre-minted.
 *
 * @author Superfluid
 */
contract NativeSuperTokenProxy is INativeSuperTokenCustom, CustomSuperTokenProxyBase {
    function initialize(string calldata name, string calldata symbol, uint256 totalSupply, address recipient) 
        external override
    {
        ISuperToken(address(this)).initialize(
            IERC20(address(0x0)), // no underlying/wrapped token
            18, // shouldn't matter if there's no wrapped token
            name,
            symbol
        );
        ISuperToken(address(this)).selfMint(recipient, totalSupply, new bytes(0));
    }
}
