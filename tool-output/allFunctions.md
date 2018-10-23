| contract | function | completed | visibility | stateMutability | modifiers | hash |
|----------|----------|-----------|------------| --------------- | --------- | -----|
| AragonApp | canPerform(address,bytes32,uint256[]) | | public | false |  | a1658fad |
| DelegateProxy | delegatedFwd(address,bytes) | | internal | true |  | e4fab06f |
| DelegateProxy | delegatedFwd(address,bytes,uint256) | | internal | true |  | b9002e62 |
| DelegateProxy | isContract(address) | | internal | false |  | 16279055 |
| APMRegistry | initialize(address) | | public | true | onlyInit() | c4d66de8 |
| APMRegistry | newRepo(string,address) | | public | true | auth(bytes32) | b0927de7 |
| APMRegistry | newRepoWithVersion(string,address,uint16[3],address,bytes) | | public | true | auth(bytes32) | 32ab6af0 |
| APMRegistry | _newRepo(string,address) | | internal | true |  | c32221cf |
| APMRegistry | newClonedRepo() | | internal | true |  | 02c71d92 |
| APMRegistry | repoAppId() | | internal | false |  | c50ec10a |
| Vault | Vault() | | public | true |  | 2d2c44f2 |
| Vault | initialize(address,address) | | public | true | onlyInit() | 485cc955 |
| Vault | initializeWithBase(address) | | public | true | onlyInit() | a12c0098 |
| Vault | _setConnectors(address,address) | | internal | true |  | d51a0dfc |
| Vault | () | | public | true |  | 861731d5 |
| Vault | registerStandard(uint32,uint32,bytes4,address) | | public | true | authP(bytes32,uint256[] memory) | b0ee7f2a |
| Vault | detectTokenStandard(address) | | public | false |  | 58508e39 |
| Vault | conformsToStandard(address,uint256) | | public | false |  | 7a4d261f |
| Vault | isInterfaceDetectionERCSupported(uint32) | | public | false |  | 57f79185 |
| Vault | _registerStandard(uint32,uint32,bytes4,address) | | internal | true |  | 9b5e8443 |
| ScriptHelpers | abiEncode(bytes,bytes,address[]) | | public | false |  | 137d7026 |
| ScriptHelpers | encode(bytes,bytes,address[]) | | internal | false |  | c0a2673c |
| ScriptHelpers | abiLength(bytes) | | internal | false |  | f5178c95 |
| ScriptHelpers | abiLength(address[]) | | internal | false |  | 91e88106 |
| ScriptHelpers | copy(bytes,uint256,uint256,uint256) | | internal | false |  | e2fecdf3 |
| ScriptHelpers | getPtr(bytes) | | internal | false |  | b71b86a1 |
| ScriptHelpers | getPtr(address[]) | | internal | false |  | 6d248ec3 |
| ScriptHelpers | getSpecId(bytes) | | internal | false |  | 46190e16 |
| ScriptHelpers | uint256At(bytes,uint256) | | internal | false |  | acc0a246 |
| ScriptHelpers | addressAt(bytes,uint256) | | internal | false |  | e9a6fdc3 |
| ScriptHelpers | uint32At(bytes,uint256) | | internal | false |  | ba5cb281 |
| ScriptHelpers | locationOf(bytes,uint256) | | internal | false |  | 43c5d889 |
| ScriptHelpers | toBytes(bytes4) | | internal | false |  | 609ec605 |
| ScriptHelpers | memcpy(uint256,uint256,uint256) | | public | false |  | 11fe773d |
| DevTemplate | DevTemplate(address,address,address) | | public | true |  | c370cc4c |
| DevTemplate | apmInit(address,bytes,address,bytes,address,bytes,address,bytes) | | public | true |  | 16dbd4f6 |
| DevTemplate | createInstance() | | public | true |  | ad501467 |
| DevTemplate | createRepo(string,address,bytes) | | internal | true |  | 7aed110a |
| DevTemplate | financeAppId() | | public | false |  | 6422fe71 |
| DevTemplate | tokenManagerAppId() | | public | false |  | b8db3bbd |
| DevTemplate | vaultAppId() | | public | false |  | 370fea34 |
| DevTemplate | votingAppId() | | public | false |  | c08921f7 |
| DevTemplate | ens() | | internal | false |  | 3f15457f |
| DevTemplate | latestVersionAppBase(bytes32) | | internal | false |  | c6d2c717 |
| Voting | initialize(address,uint256,uint256,uint64) | | external | true | onlyInit() | 3ee31e70 |
| Voting | changeMinAcceptQuorumPct(uint256) | | external | true | authP(bytes32,uint256[] memory) | 036e4220 |
| Voting | newVote(bytes,string) | | external | true | auth(bytes32) | d5db2c80 |
| Voting | vote(uint256,bool,bool) | | external | true |  | df133bca |
| Voting | executeVote(uint256) | | external | true |  | f98a4eca |
| Voting | isForwarder() | | public | false |  | fd64eccb |
| Voting | forward(bytes) | | public | true |  | d948d468 |
| Voting | canForward(address,bytes) | | public | false |  | c0774df3 |
| Voting | canVote(uint256,address) | | public | false |  | cdb2867b |
| Voting | canExecute(uint256) | | public | false |  | cc63604a |
| Voting | getVote(uint256) | | public | false |  | 5a55c1f0 |
| Voting | getVoteMetadata(uint256) | | public | false |  | c05218c6 |
| Voting | getVoterState(uint256,address) | | public | false |  | 4b12311c |
| Voting | _newVote(bytes,string) | | internal | true | isInitialized() | 0ddfaaef |
| Voting | _vote(uint256,bool,address,bool) | | internal | true |  | f74bc8f4 |
| Voting | _executeVote(uint256) | | internal | true |  | b18019bd |
| Voting | _isVoteOpen(struct) | | internal | false |  | 3bba5aa9 |
| Voting | _isValuePct(uint256,uint256,uint256) | | internal | false |  | 3d68cbe3 |
| AppProxyFactory | newAppProxy(address,bytes32) | | public | true |  | e156a8f3 |
| AppProxyFactory | newAppProxy(address,bytes32,bytes) | | public | true |  | ede658b0 |
| AppProxyFactory | newAppProxyPinned(address,bytes32) | | public | true |  | ff289fc5 |
| AppProxyFactory | newAppProxyPinned(address,bytes32,bytes) | | public | true |  | d162f8b0 |
| APMRegistryFactory | APMRegistryFactory(address,address,address,address,address,address) | | public | true |  | 5db9a95a |
| APMRegistryFactory | newAPM(bytes32,bytes32,address) | | public | true |  | aac57b3a |
| APMRegistryFactory | b(string) | | internal | false |  | f79be5ab |
| APMRegistryFactory | configureAPMPermissions(address,address,address) | | internal | true |  | 7fe5825d |
| DelegateScript | execScript(bytes,bytes,address[]) | | external | true |  | 279cea35 |
| DelegateScript | delegate(address,bytes) | | internal | true |  | d6d2b6ba |
| DelegateScript | isContract(address) | | internal | false |  | 16279055 |
| DelegateScript | defaultInput() | | internal | false |  | 7a872547 |
| DelegateScript | returnedData() | | internal | false |  | e4024194 |
| ENSFactory | newENS(address) | | public | true |  | e9358b01 |
| DAOFactory | DAOFactory(address,address,address) | | public | true |  | 81619954 |
| DAOFactory | newDAO(address) | | public | true |  | 21687444 |
| ACL | initialize(address) | | public | true | onlyInit() | c4d66de8 |
| ACL | createPermission(address,address,bytes32,address) | | external | true |  | be038478 |
| ACL | grantPermission(address,address,bytes32) | | external | true |  | 0a8ed3db |
| ACL | grantPermissionP(address,address,bytes32,uint256[]) | | public | true | onlyPermissionManager(address,bytes32) | 6815c992 |
| ACL | revokePermission(address,address,bytes32) | | external | true | onlyPermissionManager(address,bytes32) | 9d0effdb |
| ACL | setPermissionManager(address,address,bytes32) | | external | true | onlyPermissionManager(address,bytes32) | afd925df |
| ACL | removePermissionManager(address,bytes32) | | external | true | onlyPermissionManager(address,bytes32) | a885508a |
| ACL | getPermissionParamsLength(address,address,bytes32) | | external | false |  | 15949ed7 |
| ACL | getPermissionParam(address,address,bytes32,uint256) | | external | false |  | a03c5832 |
| ACL | getPermissionManager(address,bytes32) | | public | false |  | b1905727 |
| ACL | hasPermission(address,address,bytes32,bytes) | | public | false |  | fdef9106 |
| ACL | hasPermission(address,address,bytes32,uint256[]) | | public | false |  | f520b58d |
| ACL | hasPermission(address,address,bytes32) | | public | false |  | 6d6712d8 |
| ACL | evalParams(bytes32,address,address,bytes32,uint256[]) | | public | false |  | 1b5e75be |
| ACL | _createPermission(address,address,bytes32,address) | | internal | true |  | 750a96ac |
| ACL | _setPermission(address,address,bytes32,bytes32) | | internal | true |  | 7a899cdc |
| ACL | _saveParams(uint256[]) | | internal | true |  | 59ce0bb8 |
| ACL | evalParam(bytes32,uint32,address,address,bytes32,uint256[]) | | internal | false |  | f1e2ac12 |
| ACL | evalLogic(struct,bytes32,address,address,bytes32,uint256[]) | | internal | false |  | dd51c6ac |
| ACL | compare(uint256,enum,uint256) | | internal | false |  | a3d202f0 |
| ACL | checkOracle(address,address,address,bytes32,uint256[]) | | internal | false |  | 4900b48c |
| ACL | _setPermissionManager(address,address,bytes32) | | internal | true |  | d63bed4c |
| ACL | roleHash(address,bytes32) | | internal | false |  | 908ab6a5 |
| ACL | permissionHash(address,address,bytes32) | | internal | false |  | d612cff5 |
| ACL | time() | | internal | false |  | 16ada547 |
| ACL | blockN() | | internal | false |  | a52dc2e7 |
| Kernel | initialize(address,address) | | public | true | onlyInit() | 485cc955 |
| Kernel | newAppInstance(bytes32,address) | | public | true | auth(bytes32,uint256[] memory) | 80cd5ac3 |
| Kernel | newPinnedAppInstance(bytes32,address) | | public | true | auth(bytes32,uint256[] memory) | 958fde82 |
| Kernel | setApp(bytes32,bytes32,address) | | public | true | auth(bytes32,uint256[] memory) | ae5b2540 |
| Kernel | getApp(bytes32) | | public | false |  | 42c71f1d |
| Kernel | acl() | | public | false |  | de287359 |
| Kernel | hasPermission(address,address,bytes32,bytes) | | public | false |  | fdef9106 |
| Kernel | _setApp(bytes32,bytes32,address) | | internal | true |  | b899e1b7 |
| Kernel | _setAppIfNew(bytes32,bytes32,address) | | internal | true |  | 242be01a |
| Kernel | isContract(address) | | internal | false |  | 16279055 |
| SafeMath | mul(uint256,uint256) | | internal | false |  | c8a4ac9c |
| SafeMath | div(uint256,uint256) | | internal | false |  | a391c15b |
| SafeMath | sub(uint256,uint256) | | internal | false |  | b67d77c5 |
| SafeMath | add(uint256,uint256) | | internal | false |  | 771602f7 |
| Repo | newVersion(uint16[3],address,bytes) | | public | true | auth(bytes32) | 73053410 |
| Repo | getLatest() | | public | false |  | c36af460 |
| Repo | getLatestForContractAddress(address) | | public | false |  | 9a6fe50c |
| Repo | getBySemanticVersion(uint16[3]) | | public | false |  | 4c3ba268 |
| Repo | getByVersionId(uint256) | | public | false |  | 737e7d4f |
| Repo | getVersionsCount() | | public | false |  | c6d48e0d |
| Repo | isValidBump(uint16[3],uint16[3]) | | public | false |  | a7bdf16e |
| Repo | semanticVersionHash(uint16[3]) | | internal | false |  | fe91d37f |
| Initializable | getInitializationBlock() | | public | false |  | 8b3dd749 |
| Initializable | initialized() | | internal | true | onlyInit() | 158ef93e |
| Initializable | getBlockNumber() | | internal | false |  | 42cbb15c |
| AppProxyPinned | AppProxyPinned(address,bytes32,bytes) | | public | true |  | 1f30adf1 |
| AppProxyPinned | implementation() | | public | false |  | 5c60da1b |
| AppProxyPinned | proxyType() | | public | false |  | 4555d5c9 |
| AppProxyPinned | () | | public | true |  | 861731d5 |
| DeployDelegateScript | execScript(bytes,bytes,address[]) | | external | true |  | 279cea35 |
| DeployDelegateScript | deploy(bytes) | | internal | true |  | 00774360 |
| ACLSyntaxSugar | arr() | | internal | false |  | e81d53cf |
| ACLSyntaxSugar | arr(bytes32) | | internal | false |  | 22b53192 |
| ACLSyntaxSugar | arr(bytes32,bytes32) | | internal | false |  | db9abbd4 |
| ACLSyntaxSugar | arr(address) | | internal | false |  | 77d4c48b |
| ACLSyntaxSugar | arr(address,address) | | internal | false |  | daaadd8e |
| ACLSyntaxSugar | arr(address,uint256,uint256) | | internal | false |  | dc0bd75f |
| ACLSyntaxSugar | arr(address,uint256) | | internal | false |  | 584e492a |
| ACLSyntaxSugar | arr(address,address,uint256,uint256,uint256) | | internal | false |  | 711085b2 |
| ACLSyntaxSugar | arr(address,address,address) | | internal | false |  | b56ccd93 |
| ACLSyntaxSugar | arr(address,address,uint256) | | internal | false |  | 4ba9bb67 |
| ACLSyntaxSugar | arr(uint256) | | internal | false |  | 71e5ee5f |
| ACLSyntaxSugar | arr(uint256,uint256) | | internal | false |  | 45d0695f |
| ACLSyntaxSugar | arr(uint256,uint256,uint256) | | internal | false |  | bb23e3a9 |
| ACLSyntaxSugar | arr(uint256,uint256,uint256,uint256) | | internal | false |  | 02b985d3 |
| ACLSyntaxSugar | arr(uint256,uint256,uint256,uint256,uint256) | | internal | false |  | 1791cf01 |
| ACLHelpers | decodeParamOp(uint256) | | internal | false |  | 4867ec4f |
| ACLHelpers | decodeParamId(uint256) | | internal | false |  | 0206e79d |
| ACLHelpers | decodeParamsList(uint256) | | internal | false |  | 599c8761 |
| ERC165Fake | ERC165Fake() | | public | true |  | abcfc8ef |
| ETHConnector | () | | public | true |  | 861731d5 |
| ETHConnector | deposit(address,address,uint256,bytes) | | external | true |  | e9c670ad |
| ETHConnector | transfer(address,address,uint256,bytes) | | external | true | authP(bytes32,uint256[] memory) | 12a837b4 |
| ETHConnector | balance(address) | | public | false |  | e3d670d7 |
| ETHConnector | exitContextReturningTrue() | | internal | true |  | ea93ec30 |
| EVMScriptRegistryFactory | EVMScriptRegistryFactory() | | public | true |  | ed3fd0d7 |
| EVMScriptRegistryFactory | newEVMScriptRegistry(address,address) | | public | true |  | 869abc24 |
| PublicResolver | PublicResolver(address) | | public | true |  | ebb045fa |
| PublicResolver | supportsInterface(bytes4) | | public | false |  | 01ffc9a7 |
| PublicResolver | addr(bytes32) | | public | false |  | 3b3b57de |
| PublicResolver | setAddr(bytes32,address) | | public | true | only_owner(bytes32) | d5fa2b00 |
| PublicResolver | content(bytes32) | | public | false |  | 2dff6941 |
| PublicResolver | setContent(bytes32,bytes32) | | public | true | only_owner(bytes32) | c3d014d6 |
| PublicResolver | name(bytes32) | | public | false |  | 691f3431 |
| PublicResolver | setName(bytes32,string) | | public | true | only_owner(bytes32) | 77372213 |
| PublicResolver | ABI(bytes32,uint256) | | public | false |  | 2203ab56 |
| PublicResolver | setABI(bytes32,uint256,bytes) | | public | true | only_owner(bytes32) | 623195b0 |
| PublicResolver | pubkey(bytes32) | | public | false |  | c8690233 |
| PublicResolver | setPubkey(bytes32,bytes32,bytes32) | | public | true | only_owner(bytes32) | 29cd62ea |
| PublicResolver | text(bytes32,string) | | public | false |  | 59d1d43c |
| PublicResolver | setText(bytes32,string,string) | | public | true | only_owner(bytes32) | 10f13a8c |
| ERC20Connector | deposit(address,address,uint256,bytes) | | external | true |  | e9c670ad |
| ERC20Connector | transfer(address,address,uint256,bytes) | | external | true | authP(bytes32,uint256[] memory) | 12a837b4 |
| ERC20Connector | balance(address) | | public | false |  | e3d670d7 |
| KernelProxy | KernelProxy(address) | | public | true |  | 11f4a9ce |
| KernelProxy | () | | public | true |  | 861731d5 |
| KernelProxy | proxyType() | | public | false |  | 4555d5c9 |
| KernelProxy | implementation() | | public | false |  | 5c60da1b |
| AppProxyBase | AppProxyBase(address,bytes32,bytes) | | public | true |  | d4ce52df |
| AppProxyBase | getAppBase(bytes32) | | internal | false |  | da5a9366 |
| AppProxyBase | () | | public | true |  | 861731d5 |
| Controlled | Controlled() | | public | true |  | 58e9b208 |
| Controlled | changeController(address) | | public | true | onlyController() | 3cebb823 |
| MiniMeToken | MiniMeToken(address,address,uint256,string,uint8,string,bool) | | public | true |  | a0ed4cff |
| MiniMeToken | transfer(address,uint256) | | public | true |  | a9059cbb |
| MiniMeToken | transferFrom(address,address,uint256) | | public | true |  | 23b872dd |
| MiniMeToken | doTransfer(address,address,uint256) | | internal | true |  | 37751b35 |
| MiniMeToken | balanceOf(address) | | public | false |  | 70a08231 |
| MiniMeToken | approve(address,uint256) | | public | true |  | 095ea7b3 |
| MiniMeToken | allowance(address,address) | | public | false |  | dd62ed3e |
| MiniMeToken | approveAndCall(address,uint256,bytes) | | public | true |  | cae9ca51 |
| MiniMeToken | totalSupply() | | public | false |  | 18160ddd |
| MiniMeToken | balanceOfAt(address,uint256) | | public | false |  | 4ee2cd7e |
| MiniMeToken | totalSupplyAt(uint256) | | public | false |  | 981b24d0 |
| MiniMeToken | createCloneToken(string,uint8,string,uint256,bool) | | public | true |  | 6638c087 |
| MiniMeToken | generateTokens(address,uint256) | | public | true | onlyController() | 827f32c0 |
| MiniMeToken | destroyTokens(address,uint256) | | public | true | onlyController() | d3ce77fe |
| MiniMeToken | enableTransfers(bool) | | public | true | onlyController() | f41e60c5 |
| MiniMeToken | getValueAt(struct,uint256) | | internal | false |  | 585a69e9 |
| MiniMeToken | updateValueAtNow(struct,uint256) | | internal | true |  | c870909e |
| MiniMeToken | isContract(address) | | internal | false |  | 16279055 |
| MiniMeToken | min(uint256,uint256) | | internal | true |  | 7ae2b5c7 |
| MiniMeToken | () | | public | true |  | 861731d5 |
| MiniMeToken | claimTokens(address) | | public | true | onlyController() | df8de3e7 |
| MiniMeTokenFactory | createCloneToken(address,uint256,string,uint8,string,bool) | | public | true |  | 5b7b72c1 |
| APMNamehash | apmNamehash(string) | | internal | false |  | b348b607 |
| SafeMath64 | mul(uint64,uint64) | | internal | false |  | 22c6ae15 |
| SafeMath64 | div(uint64,uint64) | | internal | false |  | f1a0a85c |
| SafeMath64 | sub(uint64,uint64) | | internal | false |  | 911b5f4e |
| SafeMath64 | add(uint64,uint64) | | internal | false |  | 6e2c732d |
| TokenManager | initialize(address,bool,uint256,bool) | | external | true | onlyInit() | e918c62f |
| TokenManager | mint(address,uint256) | | external | true | authP(bytes32,uint256[] memory) | 40c10f19 |
| TokenManager | issue(uint256) | | external | true | authP(bytes32,uint256[] memory) | cc872b66 |
| TokenManager | assign(address,uint256) | | external | true | authP(bytes32,uint256[] memory) | be760488 |
| TokenManager | burn(address,uint256) | | external | true | authP(bytes32,uint256[] memory) | 9dc29fac |
| TokenManager | assignVested(address,uint256,uint64,uint64,uint64,bool) | | external | true | authP(bytes32,uint256[] memory) | 21cb18cd |
| TokenManager | revokeVesting(address,uint256) | | external | true | authP(bytes32,uint256[] memory) | fa6799f2 |
| TokenManager | forward(bytes) | | public | true |  | d948d468 |
| TokenManager | isForwarder() | | public | false |  | fd64eccb |
| TokenManager | canForward(address,bytes) | | public | false |  | c0774df3 |
| TokenManager | allHolders() | | public | false |  | c80a3aa6 |
| TokenManager | onTransfer(address,address,uint256) | | public | true |  | 4a393149 |
| TokenManager | isBalanceIncreaseAllowed(address,uint256) | | internal | false |  | 09422cce |
| TokenManager | tokenGrantsCount(address) | | public | false |  | 02a72a4c |
| TokenManager | spendableBalanceOf(address) | | public | false |  | 0f8f8b83 |
| TokenManager | transferableBalance(address,uint256) | | public | false |  | 72f8393c |
| TokenManager | calculateNonVestedTokens(uint256,uint256,uint256,uint256,uint256) | | private | false |  | 0c9bc2c0 |
| TokenManager | _assign(address,uint256) | | internal | true | isInitialized() | ca792754 |
| TokenManager | _mint(address,uint256) | | internal | true | isInitialized() | 4e6ec247 |
| TokenManager | _logHolderIfNeeded(address) | | internal | true |  | 5a02d28c |
| TokenManager | proxyPayment(address) | | public | true |  | f48c3054 |
| TokenManager | onApprove(address,address,uint256) | | public | true |  | da682aeb |
| ERC165Detector | conformsToERC165(address,bytes4) | | public | false |  | 4b6f89c4 |
| ENS | ENS() | | public | true |  | 1d2e2cc4 |
| ENS | owner(bytes32) | | public | false |  | 02571be3 |
| ENS | resolver(bytes32) | | public | false |  | 0178b8bf |
| ENS | ttl(bytes32) | | public | false |  | 16a25cbd |
| ENS | setOwner(bytes32,address) | | public | true | only_owner(bytes32) | 5b0fc9c3 |
| ENS | setSubnodeOwner(bytes32,bytes32,address) | | public | true | only_owner(bytes32) | 06ab5923 |
| ENS | setResolver(bytes32,address) | | public | true | only_owner(bytes32) | 1896f70a |
| ENS | setTTL(bytes32,uint64) | | public | true | only_owner(bytes32) | 14ab9038 |
| CallsScript | execScript(bytes,bytes,address[]) | | external | true |  | 279cea35 |
| Migrations | Migrations() | | public | true |  | a360b26f |
| Migrations | setCompleted(uint256) | | public | true | restricted() | fdacd576 |
| Migrations | upgrade(address) | | public | true | restricted() | 0900f010 |
| EVMScriptRegistry | initialize() | | public | true | onlyInit() | 8129fc1c |
| EVMScriptRegistry | addScriptExecutor(address) | | external | true | auth(bytes32) | 87a16f12 |
| EVMScriptRegistry | disableScriptExecutor(uint256) | | external | true | auth(bytes32) | 5ca4d4bb |
| EVMScriptRegistry | getScriptExecutor(bytes) | | public | false |  | 04bf2a7f |
| Finance | () | | public | true |  | 861731d5 |
| Finance | initialize(address,uint64) | | external | true | onlyInit() | 1798de81 |
| Finance | deposit(address,uint256,string) | | external | true | isInitialized() | bfe07da6 |
| Finance | newPayment(address,address,uint256,uint64,uint64,uint64,string) | | external | true | authP(bytes32,uint256[] memory) | 6f0558b1 |
| Finance | setPeriodDuration(uint64) | | external | true | authP(bytes32,uint256[] memory) | 671273f4 |
| Finance | setBudget(address,uint256) | | external | true | authP(bytes32,uint256[] memory) | 74bfb426 |
| Finance | removeBudget(address) | | external | true | authP(bytes32,uint256[] memory) | 18f053da |
| Finance | executePayment(uint256) | | external | true | authP(bytes32,uint256[] memory) | 162a0cf8 |
| Finance | receiverExecutePayment(uint256) | | external | true |  | 6436f189 |
| Finance | setPaymentDisabled(uint256,bool) | | external | true | authP(bytes32,uint256[] memory) | cf79af90 |
| Finance | depositToVault(address) | | public | true | isInitialized() | efc7a861 |
| Finance | tryTransitionAccountingPeriod(uint256) | | public | true |  | a19525a3 |
| Finance | getPayment(uint256) | | public | false |  | 3280a836 |
| Finance | getTransaction(uint256) | | public | false |  | 33ea3dc8 |
| Finance | getPeriod(uint256) | | public | false |  | 4b2c0706 |
| Finance | getPeriodTokenStatement(uint256,address) | | public | false |  | 41733dd3 |
| Finance | nextPaymentTime(uint256) | | public | false |  | cb045a96 |
| Finance | getPeriodDuration() | | public | false |  | b36fec57 |
| Finance | getBudget(address) | | public | false | transitionsPeriod() | 19b7d7bd |
| Finance | currentPeriodId() | | public | false |  | 988e6595 |
| Finance | _newPeriod(uint64) | | internal | true |  | 6d1996ba |
| Finance | _executePayment(uint256) | | internal | true | transitionsPeriod() | 88aa7447 |
| Finance | _makePaymentTransaction(address,address,uint256,uint256,string) | | internal | true | isInitialized() | dc3309fb |
| Finance | _recordIncomingTransaction(address,address,uint256,string) | | internal | true |  | 77f38501 |
| Finance | _recordTransaction(bool,address,address,uint256,uint256,string) | | internal | true |  | e3153e61 |
| Finance | _canMakePayment(address,uint256) | | internal | false |  | 2f8bac5d |
| Finance | _getRemainingBudget(address) | | internal | false |  | ae04e17e |
| Finance | getTimestamp() | | internal | false |  | 188ec356 |
| ENSSubdomainRegistrar | initialize(address,bytes32) | | public | true | onlyInit() | be13f47c |
| ENSSubdomainRegistrar | createName(bytes32,address) | | external | true | auth(bytes32) | 6b62cb1b |
| ENSSubdomainRegistrar | createNameAndPoint(bytes32,address) | | external | true | auth(bytes32) | 65b0bc85 |
| ENSSubdomainRegistrar | deleteName(bytes32) | | external | true | auth(bytes32) | dc371e54 |
| ENSSubdomainRegistrar | pointRootNode(address) | | external | true | auth(bytes32) | db606931 |
| ENSSubdomainRegistrar | _createName(bytes32,address) | | internal | true |  | 451e3ec5 |
| ENSSubdomainRegistrar | _pointToResolverAndResolve(bytes32,address) | | internal | true |  | fa5ed321 |
| ENSSubdomainRegistrar | getAddr(bytes32) | | internal | false |  | 4ccee9b6 |
| IVaultFake | IVaultFake() | | public | true |  | 73dd0c0b |
| AppProxyUpgradeable | AppProxyUpgradeable(address,bytes32,bytes) | | public | true |  | b7b90963 |
| AppProxyUpgradeable | implementation() | | public | false |  | 5c60da1b |
| AppProxyUpgradeable | proxyType() | | public | false |  | 4555d5c9 |
| EVMScriptRunner | runScript(bytes,bytes,address[]) | | internal | true | protectState() | 6f09240f |
| EVMScriptRunner | getExecutor(bytes) | | public | false |  | f92a79ff |
| EVMScriptRunner | getExecutorRegistry() | | internal | false |  | 6dbb7bcd |
| EVMScriptRunner | returnedDataDecoded() | | internal | false |  | 64425055 |
| Math | max64(uint64,uint64) | | internal | false |  | 3a4faf7f |
| Math | min64(uint64,uint64) | | internal | false |  | 36b1315c |
| Math | max256(uint256,uint256) | | internal | false |  | 0c255c94 |
| Math | min256(uint256,uint256) | | internal | false |  | b1e9292f |
| BasicToken | totalSupply() | | public | false |  | 18160ddd |
| BasicToken | transfer(address,uint256) | | public | true |  | a9059cbb |
| BasicToken | balanceOf(address) | | public | false |  | 70a08231 |
| StandardToken | transferFrom(address,address,uint256) | | public | true |  | 23b872dd |
| StandardToken | approve(address,uint256) | | public | true |  | 095ea7b3 |
| StandardToken | allowance(address,address) | | public | false |  | dd62ed3e |
| StandardToken | increaseApproval(address,uint256) | | public | true |  | d73dd623 |
| StandardToken | decreaseApproval(address,uint256) | | public | true |  | 66188463 |
