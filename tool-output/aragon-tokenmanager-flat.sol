pragma solidity 0.4.24;

// File: @aragon/os/contracts/common/UnstructuredStorage.sol

/*
 * SPDX-License-Identitifer:    MIT
 */

pragma solidity ^0.4.24;


library UnstructuredStorage {
    function getStorageBool(bytes32 position) internal view returns (bool data) {
        assembly { data := sload(position) }
    }

    function getStorageAddress(bytes32 position) internal view returns (address data) {
        assembly { data := sload(position) }
    }

    function getStorageBytes32(bytes32 position) internal view returns (bytes32 data) {
        assembly { data := sload(position) }
    }

    function getStorageUint256(bytes32 position) internal view returns (uint256 data) {
        assembly { data := sload(position) }
    }

    function setStorageBool(bytes32 position, bool data) internal {
        assembly { sstore(position, data) }
    }

    function setStorageAddress(bytes32 position, address data) internal {
        assembly { sstore(position, data) }
    }

    function setStorageBytes32(bytes32 position, bytes32 data) internal {
        assembly { sstore(position, data) }
    }

    function setStorageUint256(bytes32 position, uint256 data) internal {
        assembly { sstore(position, data) }
    }
}

// File: @aragon/os/contracts/acl/IACL.sol

/*
 * SPDX-License-Identitifer:    MIT
 */

pragma solidity ^0.4.24;


interface IACL {
    function initialize(address permissionsCreator) external;

    // TODO: this should be external
    // See https://github.com/ethereum/solidity/issues/4832
    function hasPermission(address who, address where, bytes32 what, bytes how) public view returns (bool);
}

// File: @aragon/os/contracts/common/IVaultRecoverable.sol

/*
 * SPDX-License-Identitifer:    MIT
 */

pragma solidity ^0.4.24;


interface IVaultRecoverable {
    function transferToVault(address token) external;

    function allowRecoverability(address token) external view returns (bool);
    function getRecoveryVault() external view returns (address);
}

// File: @aragon/os/contracts/kernel/IKernel.sol

/*
 * SPDX-License-Identitifer:    MIT
 */

pragma solidity ^0.4.24;




// This should be an interface, but interfaces can't inherit yet :(
contract IKernel is IVaultRecoverable {
    event SetApp(bytes32 indexed namespace, bytes32 indexed appId, address app);

    function acl() public view returns (IACL);
    function hasPermission(address who, address where, bytes32 what, bytes how) public view returns (bool);

    function setApp(bytes32 namespace, bytes32 appId, address app) public;
    function getApp(bytes32 namespace, bytes32 appId) public view returns (address);
}

// File: @aragon/os/contracts/apps/AppStorage.sol

/*
 * SPDX-License-Identitifer:    MIT
 */

pragma solidity ^0.4.24;




contract AppStorage {
    using UnstructuredStorage for bytes32;

    // keccak256("aragonOS.appStorage.kernel")
    bytes32 internal constant KERNEL_POSITION = 0x4172f0f7d2289153072b0a6ca36959e0cbe2efc3afe50fc81636caa96338137b;
    // keccak256("aragonOS.appStorage.appId")
    bytes32 internal constant APP_ID_POSITION = 0xd625496217aa6a3453eecb9c3489dc5a53e6c67b444329ea2b2cbc9ff547639b;
    // keccak256("aragonOS.appStorage.pinnedCode"), used by Proxy Pinned
    bytes32 internal constant PINNED_CODE_POSITION = 0xdee64df20d65e53d7f51cb6ab6d921a0a6a638a91e942e1d8d02df28e31c038e;

    function kernel() public view returns (IKernel) {
        return IKernel(KERNEL_POSITION.getStorageAddress());
    }

    function appId() public view returns (bytes32) {
        return APP_ID_POSITION.getStorageBytes32();
    }

    function setKernel(IKernel _kernel) internal {
        KERNEL_POSITION.setStorageAddress(address(_kernel));
    }

    function setAppId(bytes32 _appId) internal {
        APP_ID_POSITION.setStorageBytes32(_appId);
    }
}

// File: @aragon/os/contracts/common/Uint256Helpers.sol

library Uint256Helpers {
    uint256 public constant MAX_UINT64 = uint64(-1);

    function toUint64(uint256 a) internal pure returns (uint64) {
        require(a <= MAX_UINT64);
        return uint64(a);
    }
}

// File: @aragon/os/contracts/common/TimeHelpers.sol

/*
 * SPDX-License-Identitifer:    MIT
 */

pragma solidity ^0.4.24;



contract TimeHelpers {
    using Uint256Helpers for uint256;

    /**
    * @dev Returns the current block number.
    *      Using a function rather than `block.number` allows us to easily mock the block number in
    *      tests.
    */
    function getBlockNumber() internal view returns (uint256) {
        return block.number;
    }

    /**
    * @dev Returns the current block number, converted to uint64.
    *      Using a function rather than `block.number` allows us to easily mock the block number in
    *      tests.
    */
    function getBlockNumber64() internal view returns (uint64) {
        return getBlockNumber().toUint64();
    }

    /**
    * @dev Returns the current timestamp.
    *      Using a function rather than `block.timestamp` allows us to easily mock it in
    *      tests.
    */
    function getTimestamp() internal view returns (uint256) {
        return block.timestamp; // solium-disable-line security/no-block-members
    }

    /**
    * @dev Returns the current timestamp, converted to uint64.
    *      Using a function rather than `block.timestamp` allows us to easily mock it in
    *      tests.
    */
    function getTimestamp64() internal view returns (uint64) {
        return getTimestamp().toUint64();
    }
}

// File: @aragon/os/contracts/common/Initializable.sol

/*
 * SPDX-License-Identitifer:    MIT
 */

pragma solidity ^0.4.24;




contract Initializable is TimeHelpers {
    using UnstructuredStorage for bytes32;

    // keccak256("aragonOS.initializable.initializationBlock")
    bytes32 internal constant INITIALIZATION_BLOCK_POSITION = 0xebb05b386a8d34882b8711d156f463690983dc47815980fb82aeeff1aa43579e;

    modifier onlyInit {
        require(getInitializationBlock() == 0);
        _;
    }

    modifier isInitialized {
        require(hasInitialized());
        _;
    }

    /**
    * @return Block number in which the contract was initialized
    */
    function getInitializationBlock() public view returns (uint256) {
        return INITIALIZATION_BLOCK_POSITION.getStorageUint256();
    }

    /**
    * @return Whether the contract has been initialized by the time of the current block
    */
    function hasInitialized() public view returns (bool) {
        uint256 initializationBlock = getInitializationBlock();
        return initializationBlock != 0 && getBlockNumber() >= initializationBlock;
    }

    /**
    * @dev Function to be called by top level contract after initialization has finished.
    */
    function initialized() internal onlyInit {
        INITIALIZATION_BLOCK_POSITION.setStorageUint256(getBlockNumber());
    }

    /**
    * @dev Function to be called by top level contract after initialization to enable the contract
    *      at a future block number rather than immediately.
    */
    function initializedAt(uint256 _blockNumber) internal onlyInit {
        INITIALIZATION_BLOCK_POSITION.setStorageUint256(_blockNumber);
    }
}

// File: @aragon/os/contracts/common/Petrifiable.sol

/*
 * SPDX-License-Identitifer:    MIT
 */

pragma solidity ^0.4.24;



contract Petrifiable is Initializable {
    // Use block UINT256_MAX (which should be never) as the initializable date
    uint256 internal constant PETRIFIED_BLOCK = uint256(-1);

    function isPetrified() public view returns (bool) {
        return getInitializationBlock() == PETRIFIED_BLOCK;
    }

    /**
    * @dev Function to be called by top level contract to prevent being initialized.
    *      Useful for freezing base contracts when they're used behind proxies.
    */
    function petrify() internal onlyInit {
        initializedAt(PETRIFIED_BLOCK);
    }
}

// File: @aragon/os/contracts/common/Autopetrified.sol

/*
 * SPDX-License-Identitifer:    MIT
 */

pragma solidity ^0.4.24;



contract Autopetrified is Petrifiable {
    constructor() public {
        // Immediately petrify base (non-proxy) instances of inherited contracts on deploy.
        // This renders them uninitializable (and unusable without a proxy).
        petrify();
    }
}

// File: @aragon/os/contracts/lib/token/ERC20.sol

// See https://github.com/OpenZeppelin/openzeppelin-solidity/blob/a9f910d34f0ab33a1ae5e714f69f9596a02b4d91/contracts/token/ERC20/ERC20.sol

pragma solidity ^0.4.24;


/**
 * @title ERC20 interface
 * @dev see https://github.com/ethereum/EIPs/issues/20
 */
contract ERC20 {
    function totalSupply() public view returns (uint256);

    function balanceOf(address _who) public view returns (uint256);

    function allowance(address _owner, address _spender)
        public view returns (uint256);

    function transfer(address _to, uint256 _value) public returns (bool);

    function approve(address _spender, uint256 _value)
        public returns (bool);

    function transferFrom(address _from, address _to, uint256 _value)
        public returns (bool);

    event Transfer(
        address indexed from,
        address indexed to,
        uint256 value
    );

    event Approval(
        address indexed owner,
        address indexed spender,
        uint256 value
    );
}

// File: @aragon/os/contracts/common/EtherTokenConstant.sol

/*
 * SPDX-License-Identitifer:    MIT
 */

pragma solidity ^0.4.24;


// aragonOS and aragon-apps rely on address(0) to denote native ETH, in
// contracts where both tokens and ETH are accepted
contract EtherTokenConstant {
    address public constant ETH = address(0);
}

// File: @aragon/os/contracts/common/IsContract.sol

/*
 * SPDX-License-Identitifer:    MIT
 */

pragma solidity ^0.4.24;


contract IsContract {
    function isContract(address _target) internal view returns (bool) {
        if (_target == address(0)) {
            return false;
        }

        uint256 size;
        assembly { size := extcodesize(_target) }
        return size > 0;
    }
}

// File: @aragon/os/contracts/common/VaultRecoverable.sol

/*
 * SPDX-License-Identitifer:    MIT
 */

pragma solidity ^0.4.24;






contract VaultRecoverable is IVaultRecoverable, EtherTokenConstant, IsContract {
    /**
     * @notice Send funds to recovery Vault. This contract should never receive funds,
     *         but in case it does, this function allows one to recover them.
     * @param _token Token balance to be sent to recovery vault.
     */
    function transferToVault(address _token) external {
        require(allowRecoverability(_token));
        address vault = getRecoveryVault();
        require(isContract(vault));

        if (_token == ETH) {
            vault.transfer(address(this).balance);
        } else {
            uint256 amount = ERC20(_token).balanceOf(this);
            ERC20(_token).transfer(vault, amount);
        }
    }

    /**
    * @dev By default deriving from AragonApp makes it recoverable
    * @param token Token address that would be recovered
    * @return bool whether the app allows the recovery
    */
    function allowRecoverability(address token) public view returns (bool) {
        return true;
    }

    // Cast non-implemented interface to be public so we can use it internally
    function getRecoveryVault() public view returns (address);
}

// File: @aragon/os/contracts/evmscript/IEVMScriptExecutor.sol

/*
 * SPDX-License-Identitifer:    MIT
 */

pragma solidity ^0.4.24;


interface IEVMScriptExecutor {
    function execScript(bytes script, bytes input, address[] blacklist) external returns (bytes);
    function executorType() external pure returns (bytes32);
}

// File: @aragon/os/contracts/evmscript/IEVMScriptRegistry.sol

/*
 * SPDX-License-Identitifer:    MIT
 */

pragma solidity ^0.4.24;



contract EVMScriptRegistryConstants {
    /* Hardcoded constants to save gas
    bytes32 public constant EVMSCRIPT_REGISTRY_APP_ID = apmNamehash("evmreg");
    */
    bytes32 public constant EVMSCRIPT_REGISTRY_APP_ID = 0xddbcfd564f642ab5627cf68b9b7d374fb4f8a36e941a75d89c87998cef03bd61;
}


interface IEVMScriptRegistry {
    function addScriptExecutor(IEVMScriptExecutor executor) external returns (uint id);
    function disableScriptExecutor(uint256 executorId) external;

    // TODO: this should be external
    // See https://github.com/ethereum/solidity/issues/4832
    function getScriptExecutor(bytes script) public view returns (IEVMScriptExecutor);
}

// File: @aragon/os/contracts/kernel/KernelConstants.sol

contract KernelConstants {
    /*
    bytes32 public constant CORE_NAMESPACE = keccak256("core");
    bytes32 public constant APP_BASES_NAMESPACE = keccak256("base");
    bytes32 public constant APP_ADDR_NAMESPACE = keccak256("app");

    bytes32 public constant KERNEL_APP_ID = apmNamehash("kernel");
    bytes32 public constant ACL_APP_ID = apmNamehash("acl");
    */
    bytes32 public constant CORE_NAMESPACE = 0xc681a85306374a5ab27f0bbc385296a54bcd314a1948b6cf61c4ea1bc44bb9f8;
    bytes32 public constant APP_BASES_NAMESPACE = 0xf1f3eb40f5bc1ad1344716ced8b8a0431d840b5783aea1fd01786bc26f35ac0f;
    bytes32 public constant APP_ADDR_NAMESPACE = 0xd6f028ca0e8edb4a8c9757ca4fdccab25fa1e0317da1188108f7d2dee14902fb;

    bytes32 public constant KERNEL_APP_ID = 0x3b4bf6bf3ad5000ecf0f989d5befde585c6860fea3e574a4fab4c49d1c177d9c;
    bytes32 public constant ACL_APP_ID = 0xe3262375f45a6e2026b7e7b18c2b807434f2508fe1a2a3dfb493c7df8f4aad6a;
}

// File: @aragon/os/contracts/evmscript/EVMScriptRunner.sol

/*
 * SPDX-License-Identitifer:    MIT
 */

pragma solidity ^0.4.24;







contract EVMScriptRunner is AppStorage, Initializable, EVMScriptRegistryConstants, KernelConstants {
    event ScriptResult(address indexed executor, bytes script, bytes input, bytes returnData);

    function getExecutor(bytes _script) public view returns (IEVMScriptExecutor) {
        return IEVMScriptExecutor(getExecutorRegistry().getScriptExecutor(_script));
    }

    function runScript(bytes _script, bytes _input, address[] _blacklist)
        internal
        isInitialized
        protectState
        returns (bytes)
    {
        // TODO: Too much data flying around, maybe extracting spec id here is cheaper
        IEVMScriptExecutor executor = getExecutor(_script);
        require(address(executor) != address(0));

        bytes4 sig = executor.execScript.selector;

        require(address(executor).delegatecall(abi.encodeWithSelector(sig, _script, _input, _blacklist)));

        bytes memory output = returnedDataDecoded();

        emit ScriptResult(address(executor), _script, _input, output);

        return output;
    }

    function getExecutorRegistry() internal view returns (IEVMScriptRegistry) {
        address registryAddr = kernel().getApp(APP_ADDR_NAMESPACE, EVMSCRIPT_REGISTRY_APP_ID);
        return IEVMScriptRegistry(registryAddr);
    }

    /**
    * @dev copies and returns last's call data. Needs to ABI decode first
    */
    function returnedDataDecoded() internal pure returns (bytes ret) {
        assembly {
            let size := returndatasize
            switch size
            case 0 {}
            default {
                ret := mload(0x40) // free mem ptr get
                mstore(0x40, add(ret, add(size, 0x20))) // free mem ptr set
                returndatacopy(ret, 0x20, sub(size, 0x20)) // copy return data
            }
        }
        return ret;
    }

    modifier protectState {
        address preKernel = address(kernel());
        bytes32 preAppId = appId();
        _; // exec
        require(address(kernel()) == preKernel);
        require(appId() == preAppId);
    }
}

// File: @aragon/os/contracts/acl/ACLSyntaxSugar.sol

/*
 * SPDX-License-Identitifer:    MIT
 */

pragma solidity ^0.4.24;


contract ACLSyntaxSugar {
    function arr() internal pure returns (uint256[]) {}

    function arr(bytes32 _a) internal pure returns (uint256[] r) {
        return arr(uint256(_a));
    }

    function arr(bytes32 _a, bytes32 _b) internal pure returns (uint256[] r) {
        return arr(uint256(_a), uint256(_b));
    }

    function arr(address _a) internal pure returns (uint256[] r) {
        return arr(uint256(_a));
    }

    function arr(address _a, address _b) internal pure returns (uint256[] r) {
        return arr(uint256(_a), uint256(_b));
    }

    function arr(address _a, uint256 _b, uint256 _c) internal pure returns (uint256[] r) {
        return arr(uint256(_a), _b, _c);
    }

    function arr(address _a, uint256 _b, uint256 _c, uint256 _d) internal pure returns (uint256[] r) {
        return arr(uint256(_a), _b, _c, _d);
    }

    function arr(address _a, uint256 _b) internal pure returns (uint256[] r) {
        return arr(uint256(_a), uint256(_b));
    }

    function arr(address _a, address _b, uint256 _c, uint256 _d, uint256 _e) internal pure returns (uint256[] r) {
        return arr(uint256(_a), uint256(_b), _c, _d, _e);
    }

    function arr(address _a, address _b, address _c) internal pure returns (uint256[] r) {
        return arr(uint256(_a), uint256(_b), uint256(_c));
    }

    function arr(address _a, address _b, uint256 _c) internal pure returns (uint256[] r) {
        return arr(uint256(_a), uint256(_b), uint256(_c));
    }

    function arr(uint256 _a) internal pure returns (uint256[] r) {
        r = new uint256[](1);
        r[0] = _a;
    }

    function arr(uint256 _a, uint256 _b) internal pure returns (uint256[] r) {
        r = new uint256[](2);
        r[0] = _a;
        r[1] = _b;
    }

    function arr(uint256 _a, uint256 _b, uint256 _c) internal pure returns (uint256[] r) {
        r = new uint256[](3);
        r[0] = _a;
        r[1] = _b;
        r[2] = _c;
    }

    function arr(uint256 _a, uint256 _b, uint256 _c, uint256 _d) internal pure returns (uint256[] r) {
        r = new uint256[](4);
        r[0] = _a;
        r[1] = _b;
        r[2] = _c;
        r[3] = _d;
    }

    function arr(uint256 _a, uint256 _b, uint256 _c, uint256 _d, uint256 _e) internal pure returns (uint256[] r) {
        r = new uint256[](5);
        r[0] = _a;
        r[1] = _b;
        r[2] = _c;
        r[3] = _d;
        r[4] = _e;
    }
}


contract ACLHelpers {
    function decodeParamOp(uint256 _x) internal pure returns (uint8 b) {
        return uint8(_x >> (8 * 30));
    }

    function decodeParamId(uint256 _x) internal pure returns (uint8 b) {
        return uint8(_x >> (8 * 31));
    }

    function decodeParamsList(uint256 _x) internal pure returns (uint32 a, uint32 b, uint32 c) {
        a = uint32(_x);
        b = uint32(_x >> (8 * 4));
        c = uint32(_x >> (8 * 8));
    }
}

// File: @aragon/os/contracts/apps/AragonApp.sol

/*
 * SPDX-License-Identitifer:    MIT
 */

pragma solidity ^0.4.24;







// Contracts inheriting from AragonApp are, by default, immediately petrified upon deployment so
// that they can never be initialized.
// Unless overriden, this behaviour enforces those contracts to be usable only behind an AppProxy.
// ACLSyntaxSugar and EVMScriptRunner are not directly used by this contract, but are included so
// that they are automatically usable by subclassing contracts
contract AragonApp is AppStorage, Autopetrified, VaultRecoverable, EVMScriptRunner, ACLSyntaxSugar {
    modifier auth(bytes32 _role) {
        require(canPerform(msg.sender, _role, new uint256[](0)));
        _;
    }

    modifier authP(bytes32 _role, uint256[] _params) {
        require(canPerform(msg.sender, _role, _params));
        _;
    }

    /**
    * @dev Check whether an action can be performed by a sender for a particular role on this app
    * @param _sender Sender of the call
    * @param _role Role on this app
    * @param _params Permission params for the role
    * @return Boolean indicating whether the sender has the permissions to perform the action.
    *         Always returns false if the app hasn't been initialized yet.
    */
    function canPerform(address _sender, bytes32 _role, uint256[] _params) public view returns (bool) {
        if (!hasInitialized()) {
            return false;
        }

        IKernel linkedKernel = kernel();
        if (address(linkedKernel) == address(0)) {
            return false;
        }

        bytes memory how; // no need to init memory as it is never used
        if (_params.length > 0) {
            uint256 byteLength = _params.length * 32;
            assembly {
                how := _params // forced casting
                mstore(how, byteLength)
            }
        }
        return linkedKernel.hasPermission(_sender, address(this), _role, how);
    }

    /**
    * @dev Get the recovery vault for the app
    * @return Recovery vault address for the app
    */
    function getRecoveryVault() public view returns (address) {
        // Funds recovery via a vault is only available when used with a kernel
        require(address(kernel()) != address(0));
        return kernel().getRecoveryVault();
    }
}

// File: @aragon/os/contracts/common/IForwarder.sol

/*
 * SPDX-License-Identitifer:    MIT
 */

pragma solidity ^0.4.24;


interface IForwarder {
    function isForwarder() external pure returns (bool);

    // TODO: this should be external
    // See https://github.com/ethereum/solidity/issues/4832
    function canForward(address sender, bytes evmCallScript) public view returns (bool);

    // TODO: this should be external
    // See https://github.com/ethereum/solidity/issues/4832
    function forward(bytes evmCallScript) public;
}

// File: @aragon/os/contracts/lib/math/SafeMath.sol

// See https://github.com/OpenZeppelin/openzeppelin-solidity/blob/d51e38758e1d985661534534d5c61e27bece5042/contracts/math/SafeMath.sol
// Adapted to use pragma ^0.4.24 and satisfy our linter rules

pragma solidity ^0.4.24;


/**
 * @title SafeMath
 * @dev Math operations with safety checks that revert on error
 */
library SafeMath {

    /**
    * @dev Multiplies two numbers, reverts on overflow.
    */
    function mul(uint256 _a, uint256 _b) internal pure returns (uint256) {
        // Gas optimization: this is cheaper than requiring 'a' not being zero, but the
        // benefit is lost if 'b' is also tested.
        // See: https://github.com/OpenZeppelin/openzeppelin-solidity/pull/522
        if (_a == 0) {
            return 0;
        }

        uint256 c = _a * _b;
        require(c / _a == _b);

        return c;
    }

    /**
    * @dev Integer division of two numbers truncating the quotient, reverts on division by zero.
    */
    function div(uint256 _a, uint256 _b) internal pure returns (uint256) {
        require(_b > 0); // Solidity only automatically asserts when dividing by 0
        uint256 c = _a / _b;
        // assert(_a == _b * c + _a % _b); // There is no case in which this doesn't hold

        return c;
    }

    /**
    * @dev Subtracts two numbers, reverts on overflow (i.e. if subtrahend is greater than minuend).
    */
    function sub(uint256 _a, uint256 _b) internal pure returns (uint256) {
        require(_b <= _a);
        uint256 c = _a - _b;

        return c;
    }

    /**
    * @dev Adds two numbers, reverts on overflow.
    */
    function add(uint256 _a, uint256 _b) internal pure returns (uint256) {
        uint256 c = _a + _b;
        require(c >= _a);

        return c;
    }

    /**
    * @dev Divides two numbers and returns the remainder (unsigned integer modulo),
    * reverts when dividing by zero.
    */
    function mod(uint256 a, uint256 b) internal pure returns (uint256) {
        require(b != 0);
        return a % b;
    }
}

// File: @aragon/apps-shared-minime/contracts/ITokenController.sol

/// @dev The token controller contract must implement these functions


interface ITokenController {
    /// @notice Called when `_owner` sends ether to the MiniMe Token contract
    /// @param _owner The address that sent the ether to create tokens
    /// @return True if the ether is accepted, false if it throws
    function proxyPayment(address _owner) external payable returns(bool);

    /// @notice Notifies the controller about a token transfer allowing the
    ///  controller to react if desired
    /// @param _from The origin of the transfer
    /// @param _to The destination of the transfer
    /// @param _amount The amount of the transfer
    /// @return False if the controller does not authorize the transfer
    function onTransfer(address _from, address _to, uint _amount) external returns(bool);

    /// @notice Notifies the controller about an approval allowing the
    ///  controller to react if desired
    /// @param _owner The address that calls `approve()`
    /// @param _spender The spender in the `approve()` call
    /// @param _amount The amount in the `approve()` call
    /// @return False if the controller does not authorize the approval
    function onApprove(address _owner, address _spender, uint _amount) external returns(bool);
}

// File: @aragon/apps-shared-minime/contracts/MiniMeToken.sol

/*
    Copyright 2016, Jordi Baylina
    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.
    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.
    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

/// @title MiniMeToken Contract
/// @author Jordi Baylina
/// @dev This token contract's goal is to make it easy for anyone to clone this
///  token using the token distribution at a given block, this will allow DAO's
///  and DApps to upgrade their features in a decentralized manner without
///  affecting the original token
/// @dev It is ERC20 compliant, but still needs to under go further testing.


contract Controlled {
    /// @notice The address of the controller is the only address that can call
    ///  a function with this modifier
    modifier onlyController {
        require(msg.sender == controller);
        _;
    }

    address public controller;

    function Controlled()  public { controller = msg.sender;}

    /// @notice Changes the controller of the contract
    /// @param _newController The new controller of the contract
    function changeController(address _newController) onlyController  public {
        controller = _newController;
    }
}

contract ApproveAndCallFallBack {
    function receiveApproval(
        address from,
        uint256 _amount,
        address _token,
        bytes _data
    ) public;
}

/// @dev The actual token contract, the default controller is the msg.sender
///  that deploys the contract, so usually this token will be deployed by a
///  token controller contract, which Giveth will call a "Campaign"
contract MiniMeToken is Controlled {

    string public name;                //The Token's name: e.g. DigixDAO Tokens
    uint8 public decimals;             //Number of decimals of the smallest unit
    string public symbol;              //An identifier: e.g. REP
    string public version = "MMT_0.1"; //An arbitrary versioning scheme


    /// @dev `Checkpoint` is the structure that attaches a block number to a
    ///  given value, the block number attached is the one that last changed the
    ///  value
    struct Checkpoint {

        // `fromBlock` is the block number that the value was generated from
        uint128 fromBlock;

        // `value` is the amount of tokens at a specific block number
        uint128 value;
    }

    // `parentToken` is the Token address that was cloned to produce this token;
    //  it will be 0x0 for a token that was not cloned
    MiniMeToken public parentToken;

    // `parentSnapShotBlock` is the block number from the Parent Token that was
    //  used to determine the initial distribution of the Clone Token
    uint public parentSnapShotBlock;

    // `creationBlock` is the block number that the Clone Token was created
    uint public creationBlock;

    // `balances` is the map that tracks the balance of each address, in this
    //  contract when the balance changes the block number that the change
    //  occurred is also included in the map
    mapping (address => Checkpoint[]) balances;

    // `allowed` tracks any extra transfer rights as in all ERC20 tokens
    mapping (address => mapping (address => uint256)) allowed;

    // Tracks the history of the `totalSupply` of the token
    Checkpoint[] totalSupplyHistory;

    // Flag that determines if the token is transferable or not.
    bool public transfersEnabled;

    // The factory used to create new clone tokens
    MiniMeTokenFactory public tokenFactory;

////////////////
// Constructor
////////////////

    /// @notice Constructor to create a MiniMeToken
    /// @param _tokenFactory The address of the MiniMeTokenFactory contract that
    ///  will create the Clone token contracts, the token factory needs to be
    ///  deployed first
    /// @param _parentToken Address of the parent token, set to 0x0 if it is a
    ///  new token
    /// @param _parentSnapShotBlock Block of the parent token that will
    ///  determine the initial distribution of the clone token, set to 0 if it
    ///  is a new token
    /// @param _tokenName Name of the new token
    /// @param _decimalUnits Number of decimals of the new token
    /// @param _tokenSymbol Token Symbol for the new token
    /// @param _transfersEnabled If true, tokens will be able to be transferred
    function MiniMeToken(
        MiniMeTokenFactory _tokenFactory,
        MiniMeToken _parentToken,
        uint _parentSnapShotBlock,
        string _tokenName,
        uint8 _decimalUnits,
        string _tokenSymbol,
        bool _transfersEnabled
    )  public
    {
        tokenFactory = _tokenFactory;
        name = _tokenName;                                 // Set the name
        decimals = _decimalUnits;                          // Set the decimals
        symbol = _tokenSymbol;                             // Set the symbol
        parentToken = _parentToken;
        parentSnapShotBlock = _parentSnapShotBlock;
        transfersEnabled = _transfersEnabled;
        creationBlock = block.number;
    }


///////////////////
// ERC20 Methods
///////////////////

    /// @notice Send `_amount` tokens to `_to` from `msg.sender`
    /// @param _to The address of the recipient
    /// @param _amount The amount of tokens to be transferred
    /// @return Whether the transfer was successful or not
    function transfer(address _to, uint256 _amount) public returns (bool success) {
        require(transfersEnabled);
        return doTransfer(msg.sender, _to, _amount);
    }

    /// @notice Send `_amount` tokens to `_to` from `_from` on the condition it
    ///  is approved by `_from`
    /// @param _from The address holding the tokens being transferred
    /// @param _to The address of the recipient
    /// @param _amount The amount of tokens to be transferred
    /// @return True if the transfer was successful
    function transferFrom(address _from, address _to, uint256 _amount) public returns (bool success) {

        // The controller of this contract can move tokens around at will,
        //  this is important to recognize! Confirm that you trust the
        //  controller of this contract, which in most situations should be
        //  another open source smart contract or 0x0
        if (msg.sender != controller) {
            require(transfersEnabled);

            // The standard ERC 20 transferFrom functionality
            if (allowed[_from][msg.sender] < _amount)
                return false;
            allowed[_from][msg.sender] -= _amount;
        }
        return doTransfer(_from, _to, _amount);
    }

    /// @dev This is the actual transfer function in the token contract, it can
    ///  only be called by other functions in this contract.
    /// @param _from The address holding the tokens being transferred
    /// @param _to The address of the recipient
    /// @param _amount The amount of tokens to be transferred
    /// @return True if the transfer was successful
    function doTransfer(address _from, address _to, uint _amount) internal returns(bool) {
        if (_amount == 0) {
            return true;
        }
        require(parentSnapShotBlock < block.number);
        // Do not allow transfer to 0x0 or the token contract itself
        require((_to != 0) && (_to != address(this)));
        // If the amount being transfered is more than the balance of the
        //  account the transfer returns false
        var previousBalanceFrom = balanceOfAt(_from, block.number);
        if (previousBalanceFrom < _amount) {
            return false;
        }
        // Alerts the token controller of the transfer
        if (isContract(controller)) {
            // Adding the ` == true` makes the linter shut up so...
            require(ITokenController(controller).onTransfer(_from, _to, _amount) == true);
        }
        // First update the balance array with the new value for the address
        //  sending the tokens
        updateValueAtNow(balances[_from], previousBalanceFrom - _amount);
        // Then update the balance array with the new value for the address
        //  receiving the tokens
        var previousBalanceTo = balanceOfAt(_to, block.number);
        require(previousBalanceTo + _amount >= previousBalanceTo); // Check for overflow
        updateValueAtNow(balances[_to], previousBalanceTo + _amount);
        // An event to make the transfer easy to find on the blockchain
        Transfer(_from, _to, _amount);
        return true;
    }

    /// @param _owner The address that's balance is being requested
    /// @return The balance of `_owner` at the current block
    function balanceOf(address _owner) public constant returns (uint256 balance) {
        return balanceOfAt(_owner, block.number);
    }

    /// @notice `msg.sender` approves `_spender` to spend `_amount` tokens on
    ///  its behalf. This is a modified version of the ERC20 approve function
    ///  to be a little bit safer
    /// @param _spender The address of the account able to transfer the tokens
    /// @param _amount The amount of tokens to be approved for transfer
    /// @return True if the approval was successful
    function approve(address _spender, uint256 _amount) public returns (bool success) {
        require(transfersEnabled);

        // To change the approve amount you first have to reduce the addresses`
        //  allowance to zero by calling `approve(_spender,0)` if it is not
        //  already 0 to mitigate the race condition described here:
        //  https://github.com/ethereum/EIPs/issues/20#issuecomment-263524729
        require((_amount == 0) || (allowed[msg.sender][_spender] == 0));

        // Alerts the token controller of the approve function call
        if (isContract(controller)) {
            // Adding the ` == true` makes the linter shut up so...
            require(ITokenController(controller).onApprove(msg.sender, _spender, _amount) == true);
        }

        allowed[msg.sender][_spender] = _amount;
        Approval(msg.sender, _spender, _amount);
        return true;
    }

    /// @dev This function makes it easy to read the `allowed[]` map
    /// @param _owner The address of the account that owns the token
    /// @param _spender The address of the account able to transfer the tokens
    /// @return Amount of remaining tokens of _owner that _spender is allowed
    ///  to spend
    function allowance(address _owner, address _spender) public constant returns (uint256 remaining) {
        return allowed[_owner][_spender];
    }

    /// @notice `msg.sender` approves `_spender` to send `_amount` tokens on
    ///  its behalf, and then a function is triggered in the contract that is
    ///  being approved, `_spender`. This allows users to use their tokens to
    ///  interact with contracts in one function call instead of two
    /// @param _spender The address of the contract able to transfer the tokens
    /// @param _amount The amount of tokens to be approved for transfer
    /// @return True if the function call was successful
    function approveAndCall(ApproveAndCallFallBack _spender, uint256 _amount, bytes _extraData) public returns (bool success) {
        require(approve(_spender, _amount));

        _spender.receiveApproval(
            msg.sender,
            _amount,
            this,
            _extraData
        );

        return true;
    }

    /// @dev This function makes it easy to get the total number of tokens
    /// @return The total number of tokens
    function totalSupply() public constant returns (uint) {
        return totalSupplyAt(block.number);
    }


////////////////
// Query balance and totalSupply in History
////////////////

    /// @dev Queries the balance of `_owner` at a specific `_blockNumber`
    /// @param _owner The address from which the balance will be retrieved
    /// @param _blockNumber The block number when the balance is queried
    /// @return The balance at `_blockNumber`
    function balanceOfAt(address _owner, uint _blockNumber) public constant returns (uint) {

        // These next few lines are used when the balance of the token is
        //  requested before a check point was ever created for this token, it
        //  requires that the `parentToken.balanceOfAt` be queried at the
        //  genesis block for that token as this contains initial balance of
        //  this token
        if ((balances[_owner].length == 0) || (balances[_owner][0].fromBlock > _blockNumber)) {
            if (address(parentToken) != 0) {
                return parentToken.balanceOfAt(_owner, min(_blockNumber, parentSnapShotBlock));
            } else {
                // Has no parent
                return 0;
            }

        // This will return the expected balance during normal situations
        } else {
            return getValueAt(balances[_owner], _blockNumber);
        }
    }

    /// @notice Total amount of tokens at a specific `_blockNumber`.
    /// @param _blockNumber The block number when the totalSupply is queried
    /// @return The total amount of tokens at `_blockNumber`
    function totalSupplyAt(uint _blockNumber) public constant returns(uint) {

        // These next few lines are used when the totalSupply of the token is
        //  requested before a check point was ever created for this token, it
        //  requires that the `parentToken.totalSupplyAt` be queried at the
        //  genesis block for this token as that contains totalSupply of this
        //  token at this block number.
        if ((totalSupplyHistory.length == 0) || (totalSupplyHistory[0].fromBlock > _blockNumber)) {
            if (address(parentToken) != 0) {
                return parentToken.totalSupplyAt(min(_blockNumber, parentSnapShotBlock));
            } else {
                return 0;
            }

        // This will return the expected totalSupply during normal situations
        } else {
            return getValueAt(totalSupplyHistory, _blockNumber);
        }
    }

////////////////
// Clone Token Method
////////////////

    /// @notice Creates a new clone token with the initial distribution being
    ///  this token at `_snapshotBlock`
    /// @param _cloneTokenName Name of the clone token
    /// @param _cloneDecimalUnits Number of decimals of the smallest unit
    /// @param _cloneTokenSymbol Symbol of the clone token
    /// @param _snapshotBlock Block when the distribution of the parent token is
    ///  copied to set the initial distribution of the new clone token;
    ///  if the block is zero than the actual block, the current block is used
    /// @param _transfersEnabled True if transfers are allowed in the clone
    /// @return The address of the new MiniMeToken Contract
    function createCloneToken(
        string _cloneTokenName,
        uint8 _cloneDecimalUnits,
        string _cloneTokenSymbol,
        uint _snapshotBlock,
        bool _transfersEnabled
    ) public returns(MiniMeToken)
    {
        uint256 snapshot = _snapshotBlock == 0 ? block.number - 1 : _snapshotBlock;

        MiniMeToken cloneToken = tokenFactory.createCloneToken(
            this,
            snapshot,
            _cloneTokenName,
            _cloneDecimalUnits,
            _cloneTokenSymbol,
            _transfersEnabled
        );

        cloneToken.changeController(msg.sender);

        // An event to make the token easy to find on the blockchain
        NewCloneToken(address(cloneToken), snapshot);
        return cloneToken;
    }

////////////////
// Generate and destroy tokens
////////////////

    /// @notice Generates `_amount` tokens that are assigned to `_owner`
    /// @param _owner The address that will be assigned the new tokens
    /// @param _amount The quantity of tokens generated
    /// @return True if the tokens are generated correctly
    function generateTokens(address _owner, uint _amount) onlyController public returns (bool) {
        uint curTotalSupply = totalSupply();
        require(curTotalSupply + _amount >= curTotalSupply); // Check for overflow
        uint previousBalanceTo = balanceOf(_owner);
        require(previousBalanceTo + _amount >= previousBalanceTo); // Check for overflow
        updateValueAtNow(totalSupplyHistory, curTotalSupply + _amount);
        updateValueAtNow(balances[_owner], previousBalanceTo + _amount);
        Transfer(0, _owner, _amount);
        return true;
    }


    /// @notice Burns `_amount` tokens from `_owner`
    /// @param _owner The address that will lose the tokens
    /// @param _amount The quantity of tokens to burn
    /// @return True if the tokens are burned correctly
    function destroyTokens(address _owner, uint _amount) onlyController public returns (bool) {
        uint curTotalSupply = totalSupply();
        require(curTotalSupply >= _amount);
        uint previousBalanceFrom = balanceOf(_owner);
        require(previousBalanceFrom >= _amount);
        updateValueAtNow(totalSupplyHistory, curTotalSupply - _amount);
        updateValueAtNow(balances[_owner], previousBalanceFrom - _amount);
        Transfer(_owner, 0, _amount);
        return true;
    }

////////////////
// Enable tokens transfers
////////////////


    /// @notice Enables token holders to transfer their tokens freely if true
    /// @param _transfersEnabled True if transfers are allowed in the clone
    function enableTransfers(bool _transfersEnabled) onlyController public {
        transfersEnabled = _transfersEnabled;
    }

////////////////
// Internal helper functions to query and set a value in a snapshot array
////////////////

    /// @dev `getValueAt` retrieves the number of tokens at a given block number
    /// @param checkpoints The history of values being queried
    /// @param _block The block number to retrieve the value at
    /// @return The number of tokens being queried
    function getValueAt(Checkpoint[] storage checkpoints, uint _block) constant internal returns (uint) {
        if (checkpoints.length == 0)
            return 0;

        // Shortcut for the actual value
        if (_block >= checkpoints[checkpoints.length-1].fromBlock)
            return checkpoints[checkpoints.length-1].value;
        if (_block < checkpoints[0].fromBlock)
            return 0;

        // Binary search of the value in the array
        uint min = 0;
        uint max = checkpoints.length-1;
        while (max > min) {
            uint mid = (max + min + 1) / 2;
            if (checkpoints[mid].fromBlock<=_block) {
                min = mid;
            } else {
                max = mid-1;
            }
        }
        return checkpoints[min].value;
    }

    /// @dev `updateValueAtNow` used to update the `balances` map and the
    ///  `totalSupplyHistory`
    /// @param checkpoints The history of data being updated
    /// @param _value The new number of tokens
    function updateValueAtNow(Checkpoint[] storage checkpoints, uint _value) internal {
        if ((checkpoints.length == 0) || (checkpoints[checkpoints.length - 1].fromBlock < block.number)) {
            Checkpoint storage newCheckPoint = checkpoints[checkpoints.length++];
            newCheckPoint.fromBlock = uint128(block.number);
            newCheckPoint.value = uint128(_value);
        } else {
            Checkpoint storage oldCheckPoint = checkpoints[checkpoints.length - 1];
            oldCheckPoint.value = uint128(_value);
        }
    }

    /// @dev Internal function to determine if an address is a contract
    /// @param _addr The address being queried
    /// @return True if `_addr` is a contract
    function isContract(address _addr) constant internal returns(bool) {
        uint size;
        if (_addr == 0)
            return false;

        assembly {
            size := extcodesize(_addr)
        }

        return size>0;
    }

    /// @dev Helper function to return a min betwen the two uints
    function min(uint a, uint b) pure internal returns (uint) {
        return a < b ? a : b;
    }

    /// @notice The fallback function: If the contract's controller has not been
    ///  set to 0, then the `proxyPayment` method is called which relays the
    ///  ether and creates tokens as described in the token controller contract
    function () external payable {
        require(isContract(controller));
        // Adding the ` == true` makes the linter shut up so...
        require(ITokenController(controller).proxyPayment.value(msg.value)(msg.sender) == true);
    }

//////////
// Safety Methods
//////////

    /// @notice This method can be used by the controller to extract mistakenly
    ///  sent tokens to this contract.
    /// @param _token The address of the token contract that you want to recover
    ///  set to 0 in case you want to extract ether.
    function claimTokens(address _token) onlyController public {
        if (_token == 0x0) {
            controller.transfer(this.balance);
            return;
        }

        MiniMeToken token = MiniMeToken(_token);
        uint balance = token.balanceOf(this);
        token.transfer(controller, balance);
        ClaimedTokens(_token, controller, balance);
    }

////////////////
// Events
////////////////
    event ClaimedTokens(address indexed _token, address indexed _controller, uint _amount);
    event Transfer(address indexed _from, address indexed _to, uint256 _amount);
    event NewCloneToken(address indexed _cloneToken, uint _snapshotBlock);
    event Approval(
        address indexed _owner,
        address indexed _spender,
        uint256 _amount
        );

}


////////////////
// MiniMeTokenFactory
////////////////

/// @dev This contract is used to generate clone contracts from a contract.
///  In solidity this is the way to create a contract from a contract of the
///  same class
contract MiniMeTokenFactory {

    /// @notice Update the DApp by creating a new token with new functionalities
    ///  the msg.sender becomes the controller of this clone token
    /// @param _parentToken Address of the token being cloned
    /// @param _snapshotBlock Block of the parent token that will
    ///  determine the initial distribution of the clone token
    /// @param _tokenName Name of the new token
    /// @param _decimalUnits Number of decimals of the new token
    /// @param _tokenSymbol Token Symbol for the new token
    /// @param _transfersEnabled If true, tokens will be able to be transferred
    /// @return The address of the new token contract
    function createCloneToken(
        MiniMeToken _parentToken,
        uint _snapshotBlock,
        string _tokenName,
        uint8 _decimalUnits,
        string _tokenSymbol,
        bool _transfersEnabled
    ) public returns (MiniMeToken)
    {
        MiniMeToken newToken = new MiniMeToken(
            this,
            _parentToken,
            _snapshotBlock,
            _tokenName,
            _decimalUnits,
            _tokenSymbol,
            _transfersEnabled
        );

        newToken.changeController(msg.sender);
        return newToken;
    }
}

// File: contracts/TokenManager.sol

/*
 * SPDX-License-Identitifer:    GPL-3.0-or-later
 */

/* solium-disable function-order */

pragma solidity 0.4.24;









contract TokenManager is ITokenController, IForwarder, AragonApp {
    using SafeMath for uint256;
    using Uint256Helpers for uint256;

    bytes32 public constant MINT_ROLE = keccak256("MINT_ROLE");
    bytes32 public constant ISSUE_ROLE = keccak256("ISSUE_ROLE");
    bytes32 public constant ASSIGN_ROLE = keccak256("ASSIGN_ROLE");
    bytes32 public constant REVOKE_VESTINGS_ROLE = keccak256("REVOKE_VESTINGS_ROLE");
    bytes32 public constant BURN_ROLE = keccak256("BURN_ROLE");

    uint256 public constant MAX_VESTINGS_PER_ADDRESS = 50;

    string private constant ERROR_NO_VESTING = "TM_NO_VESTING";
    string private constant ERROR_TOKEN_CONTROLLER = "TM_TOKEN_CONTROLLER";
    string private constant ERROR_MINT_BALANCE_INCREASE_NOT_ALLOWED = "TM_MINT_BAL_INC_NOT_ALLOWED";
    string private constant ERROR_ASSIGN_BALANCE_INCREASE_NOT_ALLOWED = "TM_ASSIGN_BAL_INC_NOT_ALLOWED";
    string private constant ERROR_TOO_MANY_VESTINGS = "TM_TOO_MANY_VESTINGS";
    string private constant ERROR_WRONG_CLIFF_DATE = "TM_WRONG_CLIFF_DATE";
    string private constant ERROR_VESTING_NOT_REVOKABLE = "TM_VESTING_NOT_REVOKABLE";
    string private constant ERROR_REVOKE_TRANSFER_FROM_REVERTED = "TM_REVOKE_TRANSFER_FROM_REVERTED";
    string private constant ERROR_ASSIGN_TRANSFER_FROM_REVERTED = "TM_ASSIGN_TRANSFER_FROM_REVERTED";
    string private constant ERROR_CAN_NOT_FORWARD = "TM_CAN_NOT_FORWARD";
    string private constant ERROR_ON_TRANSFER_WRONG_SENDER = "TM_TRANSFER_WRONG_SENDER";
    string private constant ERROR_PROXY_PAYMENT_WRONG_SENDER = "TM_PROXY_PAYMENT_WRONG_SENDER";

    struct TokenVesting {
        uint256 amount;
        uint64 start;
        uint64 cliff;
        uint64 vesting;
        bool revokable;
    }

    MiniMeToken public token;
    uint256 public maxAccountTokens;

    // We are mimicing an array in the inner mapping, we use a mapping instead to make app upgrade more graceful
    mapping (address => mapping (uint256 => TokenVesting)) internal vestings;
    mapping (address => uint256) public vestingsLengths;
    mapping (address => bool) public everHeld;

    // Other token specific events can be watched on the token address directly (avoids duplication)
    event NewVesting(address indexed receiver, uint256 vestingId, uint256 amount);
    event RevokeVesting(address indexed receiver, uint256 vestingId, uint256 nonVestedAmount);

    modifier vestingExists(address _holder, uint256 _vestingId) {
        // TODO: it's not checking for gaps that may appear because of deletes in revokeVesting function
        require(_vestingId < vestingsLengths[_holder], ERROR_NO_VESTING);
        _;
    }

    /**
    * @notice Initializes Token Manager for `_token.symbol(): string`, `transerable ? 'T' : 'Not t'`ransferable`_maxAccountTokens > 0 ? ', with a maximum of ' _maxAccountTokens ' per account' : ''`.
    * @param _token MiniMeToken address for the managed token (Token Manager instance must be already set as the token controller)
    * @param _transferable whether the token can be transferred by holders
    * @param _maxAccountTokens Maximum amount of tokens an account can have (0 for infinite tokens)
    */
    function initialize(
        MiniMeToken _token,
        bool _transferable,
        uint256 _maxAccountTokens
    )
        external
        onlyInit
    {
        initialized();

        require(_token.controller() == address(this), ERROR_TOKEN_CONTROLLER);

        token = _token;
        maxAccountTokens = _maxAccountTokens == 0 ? uint256(-1) : _maxAccountTokens;

        if (token.transfersEnabled() != _transferable) {
            token.enableTransfers(_transferable);
        }
    }

    /**
    * @notice Mint `_amount / 10^18` tokens for `_receiver`
    * @param _receiver The address receiving the tokens
    * @param _amount Number of tokens minted
    */
    function mint(address _receiver, uint256 _amount) external authP(MINT_ROLE, arr(_receiver, _amount)) {
        require(_isBalanceIncreaseAllowed(_receiver, _amount), ERROR_MINT_BALANCE_INCREASE_NOT_ALLOWED);
        _mint(_receiver, _amount);
    }

    /**
    * @notice Mint `_amount / 10^18` tokens for the Token Manager
    * @param _amount Number of tokens minted
    */
    function issue(uint256 _amount) external authP(ISSUE_ROLE, arr(_amount)) {
        _mint(address(this), _amount);
    }

    /**
    * @notice Assign `_amount / 10^18` tokens to `_receiver` from Token Manager's holdings
    * @param _receiver The address receiving the tokens
    * @param _amount Number of tokens transferred
    */
    function assign(address _receiver, uint256 _amount) external authP(ASSIGN_ROLE, arr(_receiver, _amount)) {
        _assign(_receiver, _amount);
    }

    /**
    * @notice Burn `_amount / 10^18` tokens from `_holder`
    * @param _holder Holder being removed tokens
    * @param _amount Number of tokens being burned
    */
    function burn(address _holder, uint256 _amount) external authP(BURN_ROLE, arr(_holder, _amount)) {
        // minime.destroyTokens() never returns false, only reverts on failure
        token.destroyTokens(_holder, _amount);
    }

    /**
    * @notice Assign `_amount / 10^18` tokens to `_receiver` from the Token Manager's holdings with a `_revokable : 'revokable' : ''` vesting starting at `_start`, cliff at `_cliff` (first portion of tokens transferable), and completed vesting at `_vesting` (all tokens transferable)
    * @param _receiver The address receiving the tokens
    * @param _amount Number of tokens vested
    * @param _start Date the vesting calculations start
    * @param _cliff Date when the initial portion of tokens are transferable
    * @param _vested Date when all tokens are transferable
    * @param _revokable Whether the vesting can be revoked by the Token Manager
    */
    function assignVested(
        address _receiver,
        uint256 _amount,
        uint64 _start,
        uint64 _cliff,
        uint64 _vested,
        bool _revokable
    )
        external
        authP(ASSIGN_ROLE, arr(_receiver, _amount))
        returns (uint256)
    {
        require(vestingsLengths[_receiver] < MAX_VESTINGS_PER_ADDRESS, ERROR_TOO_MANY_VESTINGS);

        require(_start <= _cliff && _cliff <= _vested, ERROR_WRONG_CLIFF_DATE);

        uint256 vestingId = vestingsLengths[_receiver]++;
        vestings[_receiver][vestingId] = TokenVesting(
            _amount,
            _start,
            _cliff,
            _vested,
            _revokable
        );

        _assign(_receiver, _amount);

        emit NewVesting(_receiver, vestingId, _amount);

        return vestingId;
    }

    /**
    * @notice Revoke vesting `_vestingId` from `_holder`, returning unvested tokens to Token Manager
    * @param _holder Address getting vesting revoked
    * @param _vestingId Numeric id of the vesting
    */
    function revokeVesting(address _holder, uint256 _vestingId)
        external
        authP(REVOKE_VESTINGS_ROLE, arr(_holder))
        vestingExists(_holder, _vestingId)
    {
        TokenVesting storage v = vestings[_holder][_vestingId];
        require(v.revokable, ERROR_VESTING_NOT_REVOKABLE);

        uint256 nonVested = _calculateNonVestedTokens(
            v.amount,
            getTimestamp64(),
            v.start,
            v.cliff,
            v.vesting
        );

        // To make vestingIds immutable over time, we just zero out the revoked vesting
        delete vestings[_holder][_vestingId];

        // transferFrom always works as controller
        // onTransfer hook always allows if transfering to token controller
        require(token.transferFrom(_holder, address(this), nonVested), ERROR_REVOKE_TRANSFER_FROM_REVERTED);

        emit RevokeVesting(_holder, _vestingId, nonVested);
    }

    /**
    * @notice Execute desired action as a token holder
    * @dev IForwarder interface conformance. Forwards any token holder action.
    * @param _evmScript Script being executed
    */
    function forward(bytes _evmScript) public {
        require(canForward(msg.sender, _evmScript), ERROR_CAN_NOT_FORWARD);
        bytes memory input = new bytes(0); // TODO: Consider input for this

        // Add the managed token to the blacklist to disallow a token holder from executing actions
        // on the token controller's (this contract) behalf
        address[] memory blacklist = new address[](1);
        blacklist[0] = address(token);

        runScript(_evmScript, input, blacklist);
    }

    function isForwarder() public pure returns (bool) {
        return true;
    }

    function canForward(address _sender, bytes) public view returns (bool) {
        return hasInitialized() && token.balanceOf(_sender) > 0;
    }

    function getVesting(
        address _recipient,
        uint256 _vestingId
    )
        public
        view
        vestingExists(_recipient, _vestingId)
        returns (
            uint256 amount,
            uint64 start,
            uint64 cliff,
            uint64 vesting,
            bool revokable
        )
    {
        TokenVesting storage tokenVesting = vestings[_recipient][_vestingId];
        amount = tokenVesting.amount;
        start = tokenVesting.start;
        cliff = tokenVesting.cliff;
        vesting = tokenVesting.vesting;
        revokable = tokenVesting.revokable;
    }

    /*
    * @dev Notifies the controller about a token transfer allowing the controller to decide whether to allow it or react if desired (only callable from the token)
    * @param _from The origin of the transfer
    * @param _to The destination of the transfer
    * @param _amount The amount of the transfer
    * @return False if the controller does not authorize the transfer
    */
    function onTransfer(address _from, address _to, uint _amount) public isInitialized returns (bool) {
        require(msg.sender == address(token), ERROR_ON_TRANSFER_WRONG_SENDER);

        bool includesTokenManager = _from == address(this) || _to == address(this);

        if (!includesTokenManager) {
            bool toCanReceive = _isBalanceIncreaseAllowed(_to, _amount);
            if (!toCanReceive || transferableBalance(_from, now) < _amount) {
                return false;
            }
        }

        return true;
    }

    /**
    * @notice Called when ether is sent to the MiniMe Token contract
    * @return True if the ether is accepted, false for it to throw
    */
    function proxyPayment(address) public payable returns (bool) {
        // Sender check is required to avoid anyone sending ETH to the Token Manager through this method
        // Even though it is tested, solidity-coverage doesnt get it because
        // MiniMeToken is not instrumented and entire tx is reverted
        require(msg.sender == address(token), ERROR_PROXY_PAYMENT_WRONG_SENDER);
        return false;
    }

    /**
    * @dev Notifies the controller about an approval allowing the controller to react if desired
    * @return False if the controller does not authorize the approval
    */
    function onApprove(address, address, uint) public returns (bool) {
        return true;
    }

    function _isBalanceIncreaseAllowed(address _receiver, uint _inc) internal view returns (bool) {
        return token.balanceOf(_receiver).add(_inc) <= maxAccountTokens;
    }

    function spendableBalanceOf(address _holder) public view returns (uint256) {
        return transferableBalance(_holder, now);
    }

    function transferableBalance(address _holder, uint256 _time) public view returns (uint256) {
        uint256 vestingsCount = vestingsLengths[_holder];
        uint256 totalNonTransferable = 0;

        for (uint256 i = 0; i < vestingsCount; i++) {
            TokenVesting storage v = vestings[_holder][i];
            uint nonTransferable = _calculateNonVestedTokens(
                v.amount,
                _time.toUint64(),
                v.start,
                v.cliff,
                v.vesting
            );
            totalNonTransferable = totalNonTransferable.add(nonTransferable);
        }

        return token.balanceOf(_holder).sub(totalNonTransferable);
    }

    /**
    * @dev Disable recovery escape hatch for own token,
    *      as the it has the concept of issuing tokens without assigning them
    */
    function allowRecoverability(address _token) public view returns (bool) {
        return _token != address(token);
    }

    /**
    * @dev Calculate amount of non-vested tokens at a specifc time
    * @param tokens The total amount of tokens vested
    * @param time The time at which to check
    * @param start The date vesting started
    * @param cliff The cliff period
    * @param vested The fully vested date
    * @return The amount of non-vested tokens of a specific grant
    *  transferableTokens
    *   |                         _/--------   vestedTokens rect
    *   |                       _/
    *   |                     _/
    *   |                   _/
    *   |                 _/
    *   |                /
    *   |              .|
    *   |            .  |
    *   |          .    |
    *   |        .      |
    *   |      .        |
    *   |    .          |
    *   +===+===========+---------+----------> time
    *      Start       Cliff    Vested
    */
    function _calculateNonVestedTokens(
        uint256 tokens,
        uint256 time,
        uint256 start,
        uint256 cliff,
        uint256 vested
    )
        private
        pure
        returns (uint256)
    {
        // Shortcuts for before cliff and after vested cases.
        if (time >= vested) {
            return 0;
        }
        if (time < cliff) {
            return tokens;
        }

        // Interpolate all vested tokens.
        // As before cliff the shortcut returns 0, we can just calculate a value
        // in the vesting rect (as shown in above's figure)

        // vestedTokens = tokens * (time - start) / (vested - start)
        // In assignVesting we enforce start <= cliff <= vested
        // Here we shortcut time >= vested and time < cliff,
        // so no division by 0 is possible
        uint256 vestedTokens = tokens.mul(time.sub(start)) / vested.sub(start);

        // tokens - vestedTokens
        return tokens.sub(vestedTokens);
    }

    function _assign(address _receiver, uint256 _amount) internal {
        require(_isBalanceIncreaseAllowed(_receiver, _amount), ERROR_ASSIGN_BALANCE_INCREASE_NOT_ALLOWED);
        // Must use transferFrom() as transfer() does not give the token controller full control
        require(token.transferFrom(this, _receiver, _amount), ERROR_ASSIGN_TRANSFER_FROM_REVERTED);
    }

    function _mint(address _receiver, uint256 _amount) internal {
        token.generateTokens(_receiver, _amount); // minime.generateTokens() never returns false
    }
}
