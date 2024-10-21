# StakeWise: DAO Investment Pool

A Decentralized Autonomous Organization (DAO) for Investment Pools using Clarity smart contracts on the Stacks blockchain.

## Description

The DAO Investment Pool allows members to pool funds and collectively invest in various projects. Voting and governance are managed through a smart contract where members vote on investment decisions, and profits are distributed based on contributions.

## Use Case

- Community-driven investment funds
- Decentralized venture capital
- Collective asset management

## Key Features

1. Stake-based governance (members vote proportionally to their investment)
2. Minimum stake requirement for voting (1 STX)
3. Automatic profit distribution
4. DAO treasury management for pooling and investing
5. Time-locked proposal system
6. Transparent voting mechanism

## Smart Contract Functions

### Staking and Unstaking
- `stake(amount: uint)`: Stake STX tokens into the investment pool
- `unstake(amount: uint)`: Withdraw staked STX tokens from the pool

### Proposal Management
- `create-proposal(description: string-ascii, amount: uint, beneficiary: principal)`: Create investment proposal
- `vote(proposal-id: uint, vote-for: bool)`: Vote on proposals (requires minimum 1 STX stake)
- `execute-proposal(proposal-id: uint)`: Execute passed proposals

### Read-only Functions
- `get-balance(user: principal)`: View user's staked balance
- `get-total-pool-balance()`: View total pool balance
- `get-proposal(proposal-id: uint)`: View proposal details
- `is-proposal-expired(proposal-id: uint)`: Check proposal expiration status

## Getting Started

1. Install [Clarinet](https://github.com/hirosystems/clarinet)
2. Clone repository
3. Run tests: `clarinet test`
4. Deploy contract: `clarinet deploy`

## Usage

1. Stake minimum 1 STX to participate in voting
2. Create investment proposals
3. Vote on active proposals
4. Execute passed proposals after review period
5. Unstake tokens when desired

## Security Features

- Minimum stake requirement prevents vote manipulation
- 24-hour proposal review period
- Owner-only access for critical functions
- Balance verification for unstaking
- Proposal expiration checks

## Future Improvements

- Quadratic voting implementation
- Multi-asset support
- Automated profit distribution
- Proposal delegation system
- Advanced treasury management
- Risk assessment framework

## Contributing

1. Fork repository
2. Create feature branch
3. Commit changes
4. Push to branch
5. Submit pull request
