# ERC20-Token-Sale

CoffeeToken and TokenSale

This repository contains two Solidity smart contracts for a coffee token system using the ERC20 standard and a token sale mechanism.

## Contracts

### CoffeeToken

The `CoffeeToken` contract represents an ERC20 token named "CoffeeToken" (symbol: "CFE"). It includes the following features:
- Minting: Tokens can be minted by accounts with the `MINTER_ROLE`.
- Coffee Purchase: Users can buy coffee with their tokens, which gets burned in the process.
- Allowance-based Coffee Purchase: Users can buy coffee from another account if allowed.

### TokenSale

The `TokenSale` contract allows users to purchase `CoffeeToken` with Ether. Key features include:
- Token Pricing: Each token is priced at 1 Ether.
- Refund: If users send more Ether than required, the excess is refunded.

## Deployment Instructions

1. Install Dependencies
   Ensure you have Node.js and npm installed. Then, install the required dependencies:
   ```bash
   npm install @openzeppelin/contracts
   
2. Compile Contracts:
 Compile the smart contracts using a Solidity compiler like solc or through a development environment like Truffle or Hardhat.

3. Deploy Contracts: 
 Deploy the CoffeeToken contract first. Then, deploy the TokenSale contract, passing the address of the deployed CoffeeToken contract as a parameter.

4. Interact with Contracts
 -- Mint Tokens: Call the mint function on the CoffeeToken contract to issue tokens.
 -- Purchase Tokens: Use the purchase function on the TokenSale contract to buy tokens with Ether.
 -- Buy Coffee: Call buyOneCoffee or buyOneCoffeeFrom to simulate coffee purchases.
