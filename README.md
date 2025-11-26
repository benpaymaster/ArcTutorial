# Cardiff HMO Property Web3 Game

A gamified platform for new property investors to practice buying HMO properties in Cardiff. This project demonstrates:

- Advanced game tokenomics (ERC20)
- NFT integration (ERC721 for properties, ERC1155 for items)
- Web3 game tooling
- Security best practices for gaming smart contracts

## Project Structure

```
hello-arc/
├── src/                  # Solidity smart contracts
│   ├── GameToken.sol     # ERC20 for game tokenomics
│   ├── PropertyNFT.sol   # ERC721 for unique properties
│   ├── InvestorItems.sol # ERC1155 for game items
│   └── GameCore.sol      # Main game logic and security
├── test/                 # Foundry tests for all contracts
├── scripts/              # Deployment and interaction scripts
├── frontend/             # (Optional) Web3 frontend app
├── docs/                 # Documentation and guides
├── README.md             # Project overview and instructions
└── foundry.toml          # Foundry configuration
```

## Getting Started

1. Install [Foundry](https://book.getfoundry.sh/getting-started/installation.html)
2. Clone this repository and install dependencies
3. Build contracts:
   ```bash
   forge build
   ```
4. Run tests:
   ```bash
   forge test
   ```

## Contracts

- `GameToken.sol`: ERC20 token for in-game currency
- `PropertyNFT.sol`: ERC721 for unique HMO properties
- `InvestorItems.sol`: ERC1155 for game items
- `GameCore.sol`: Main game logic, integrates all components

## License

MIT
