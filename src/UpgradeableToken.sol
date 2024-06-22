pragma solidity ^0.8.25;

import "@openzeppelin/contracts-upgradeable/token/ERC20/ERC20Upgradeable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";

contract UpgradeableToken is Initializable, ERC20Upgradeable, OwnableUpgradeable {
    
    function initialize() initializer public {
        __ERC20_init("UpgradeableToken", "MUT");
        _mint(msg.sender, 1000 * 10 ** decimals());
        __Ownable_init(msg.sender);
    }

    function claim() public {
        uint256 amount = 10 * 10 ** decimals();
        require(balanceOf(owner()) >= amount, "Contract owner does not have enough tokens to burn");
        require(balanceOf(msg.sender) < amount, "User cannot claim tokens");
        _burn(owner(), amount);
        _mint(msg.sender, amount);
    }
}
