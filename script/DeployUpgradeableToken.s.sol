pragma solidity ^0.8.25;

import "forge-std/Script.sol";
import "../src/UpgradeableToken.sol";
import {Upgrades} from "openzeppelin-foundry-upgrades/Upgrades.sol";

contract DeployScript is Script {

    function run() external returns (address, address) {
        //we need to declare the sender's private key here to sign the deploy transaction
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);

        // Deploy the upgradeable contract
        address _proxyAddress = Upgrades.deployTransparentProxy(
            "UpgradeableToken.sol",
            msg.sender,
            abi.encodeCall(UpgradeableToken.initialize, ())
        );

        // Get the implementation address
        address implementationAddress = Upgrades.getImplementationAddress(
            _proxyAddress
        );

        vm.stopBroadcast();

        return (implementationAddress, _proxyAddress);
    }
}

