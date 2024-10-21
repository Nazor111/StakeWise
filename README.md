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
3. Quorum requirement (30% of total pool balance must vote)
4. Automatic profit distribution
5. DAO treasury management
6. Time-locked proposal system
7. Transparent voting mechanism

## Smart Contract Functions

### Staking and Unstaking
- `stake(amount: uint)`: Stake STX tokens into the investment pool
- `unstake(amount: uint)`: Withdraw staked STX tokens from the pool

### Proposal Management
- `create-proposal(description: string-ascii, amount: uint, beneficiary: principal)`: Create investment proposal
- `vote(proposal-id: uint, vote-for: bool)`: Vote on proposals (requires minimum 1 STX stake)
- `execute-proposal(proposal-id: uint)`: Execute passed proposals (requires quorum)

### Read-only Functions
- `get-balance(user: principal)`: View user's staked balance
- `get-total-pool-balance()`: View total pool balance
- `get-proposal(proposal-id: uint)`: View proposal details
- `get-quorum-threshold()`: Get current quorum requirement
- `is-proposal-expired(proposal-id: uint)`: Check proposal expiration status

## Security Features

- Minimum stake requirement prevents vote manipulation
- Quorum threshold ensures high participation (30% minimum)
- 24-hour proposal review period
- Owner-only access for critical functions
- Balance verification for unstaking
- Proposal expiration checks

## Usage

1. Stake minimum 1 STX to participate in voting
2. Create investment proposals
3. Vote on active proposals
4. Proposals require 30% of total pool balance participation
5. Execute passed proposals after review period
6. Unstake tokens when desired

## Contributing

1. Fork repository
2. Create feature branch
3. Commit changes
4. Push to branch
5. Submit pull request
