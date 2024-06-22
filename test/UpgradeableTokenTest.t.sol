pragma solidity ^0.8.25;

import {Test, console} from "forge-std/Test.sol";
import {Upgrades} from "openzeppelin-foundry-upgrades/Upgrades.sol";
import "../src/UpgradeableToken.sol"; 

contract UpgradeableTokenTest is Test {
    UpgradeableToken public proxy;
    address implementationAddress;
    address proxyAddress;
    address owner = address(1);

    function setUp() public {
        vm.prank(owner);
        address _proxyAddress = Upgrades.deployTransparentProxy(
            "UpgradeableToken.sol",
            owner,
            abi.encodeCall(UpgradeableToken.initialize, ())
        );

        implementationAddress = Upgrades.getImplementationAddress(
            _proxyAddress
        );
        proxyAddress = _proxyAddress;
        proxy = UpgradeableToken(proxyAddress);
    }

    function testClaim() public {
        uint256 expectedBalance = 10 * 10 ** proxy.decimals();
        uint256 initBalance = 1000 * 10 ** proxy.decimals(); 
        address claimer = address(2);
        vm.prank(claimer);
        proxy.claim();
        assertEq(
            proxy.balanceOf(claimer),
            expectedBalance,
            "Claimer does not have the expected balance of tokens"
        );
        assertLt(
            proxy.balanceOf(owner),
            initBalance,
            "Owner did not lose tokens during the claim"
        );
    }
}

