# ERC-20 Token

This repository contains a **generic ERC-20 token** smart contract with minting and burning capabilities. Built using [Foundry](https://book.getfoundry.sh/).

## Features

- ERC-20 standard compliance
- Minting and burning functions
- Built with Foundry (Rust-based Ethereum toolkit)

## Documentation

- [Foundry Book](https://book.getfoundry.sh/)
- [OpenZeppelin ERC-20 Reference](https://docs.openzeppelin.com/contracts/erc20)

## Usage

### Build

```shell
forge build
```

### Test

```shell
forge test
```

### Format

```shell
forge fmt
```

### Local Node

```shell
anvil
```

## Deployment & Verification

### 1. Import Wallet

```shell
cast wallet import -k keystores mywallet --interactive
```

### 2. Deploy Contract

Replace parameters:

- `<your_rpc_url>`: RPC URL provider - e.g. `https://avalanche-fuji-c-chain-rpc.publicnode.com`
- `<keystores/my_wallet>`: with the wallet you imported. alternatively, use --private-key `<your_private_key>`
- `<owner_address>`: with the address of the owner (`0x...`)
- `<token_name>`: name of your token - e.g. `My USDC` 
- `<token_symbol>`: symbol of the token - e.g. `USDC`
- `<token_decimals>`: number of decimals - e.g. 6
- `<etherscan_api_key>`: etherscan api key, or delete the param

```shell
forge create src/Token.sol:Token --rpc-url <your_rpc_url> --broadcast --optimize --verify --keystore <keystores/my_wallet> --constructor-args <owner_address> "<token_name>" "<token_symbol>" <token_decimals> --etherscan-api-key "<etherscan_api_key>"
```

### Manually Verify Contract

params: see above

```shell
forge verify-contract <contract_address> src/Token.sol:Token --chain-id <chain_id> --num-of-optimizations 200 --watch --etherscan-api-key <etherscan_api_key>

# blockscout
forge verify-contract <contract_address> src/Token.sol:Token --chain-id <chain_id> --num-of-optimizations 200 --watch --verifier blockscout
```
