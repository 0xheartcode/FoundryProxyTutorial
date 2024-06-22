# UpgradeableToken Project

This project contains the `UpgradeableToken` smart contract, its deployment script, and test cases. Below are the instructions on how to verify, deploy, and test the contract.

## Prerequisites

- Node.js (v12.x or later)
- Foundry
- OpenZeppelin Contracts Upgradeable
- OpenZeppelin Upgrades

## Installation

1. Install Foundry:
    ```bash
    curl -L https://foundry.paradigm.xyz | bash
    foundryup
    ```

2. Clone the repository and install dependencies:
    ```bash
    git clone <repository_url>
    cd <repository_name>
    forge install
    ```
    Or install the following dependencies directly:
    ```bash
    forge install OpenZeppelin/openzeppelin-foundry-upgrades
    forge install OpenZeppelin/openzeppelin-contracts-upgradeable
    ```

3. Ensure you have the following dependencies in your `foundry.toml`:
    ```toml
[profile.default]
src = "src"
out = "out"
libs = ["lib"]
ffi = true
ast = true
build_info = true
extra_output = ["storageLayout"]
# See more config options https://github.com/foundry-rs/foundry/blob/master/crates/config/README.md#all-options
```

## Environment Variables

Set the environment variables for your private key and RPC URL:
Copy the `.env.local` file to `.env` and fill out the necessary details.

## Compilation

To compile the project, run:
```bash
forge build
```

## Testing

To test the project, run:
```bash
forge test
```

## Deployment

To deploy the contract, follow these steps:

1. Clean and rebuild the project (⚠️  use this in case of any issues. Clean && rebuild):
    ```bash
    forge clean
    forge build
    ```
2. Deploying with Forge Script

To deploy the contract using the Forge script, run:
```bash
forge script script/DeployUpgradeableToken.s.sol --rpc-url $RPC_URL --broadcast -vvvv
```

## Verification
To verify the contract on Etherscan, use the following command:
```bash
forge verify-contract --rpc-url $RPC_URL --etherscan-api-key $ETHERSCAN_API_KEY $DEPLOYED_CONTRACT_ADDRESS src/UpgradeableToken.sol:UpgradeableToken
```


### Documentation and Credits

This project was inspired by and adapted from the following blog post:
[Deploy Upgradeable Contract with Foundry and OpenZeppelin](https://www.proof2work.com/blog/deploy-upgradeable-contract-with-foundry-and-openzeppelin)
