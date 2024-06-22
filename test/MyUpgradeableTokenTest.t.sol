pragma solidity ^0.8.25;

import {Test, console} from "forge-std/Test.sol";
import {Upgrades} from "openzeppelin-foundry-upgrades/Upgrades.sol";
import "../src/MyUpgradeableToken.sol"; // Adjust the path according to your project structure

contract MyUpgradeableTokenTest is Test {
    MyUpgradeableToken public proxy;
    address implementationAddress;
    address proxyAddress;
    address owner = address(1);

    function setUp() public {
        vm.prank(owner);
        address _proxyAddress = Upgrades.deployTransparentProxy(
            "MyUpgradeableToken.sol",
            owner,
            abi.encodeCall(MyUpgradeableToken.initialize)
        );

        implementationAddress = Upgrades.getImplementationAddress(
            _proxyAddress
        );
        proxyAddress = _proxyAddress;
        proxy = MyUpgradeableToken(proxyAddress);
    }

    function testClaim() public {
        uint256 expectedBalance = 10 * 10 ** proxy.decimals();
        uint256 initBalance = 1000000000 * 10 ** proxy.decimals();
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
            "Owner did not loose tokens during the claim"
        );
    }
}

