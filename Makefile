-include .env

.PHONY: all deploy test deploy-sepolia

build:; forge build

test:; forge test

anvil:; anvil

forge install:; forge install cyfrin/foundry-devops --no-git && forge install smartcontractkit/chainlink-brownie-contracts --no-git && forge install foundry-rs/forge-std --no-git && forge install transmissions11/solmate --no-git

deploy-sepolia:
	@forge script script/DeployRaffle.s.sol --rpc-url $(SEPOLIA_RPC_URL) --account account_sepolia --broadcast --verify --etherscan-api-key $(ETHERSCAN_API_KEY) -vvvv

deploy-anvil:
	@forge script script/DeployRaffle.s.sol --rpc-url $(ANVIL_RPC_URL) --private-key $(ANVIL_PRIVATE_KEY) --broadcast -vvvv

fundSubscription:
	@forge script script/Interactions.s.sol:FundSubscription --rpc-url $(ANVIL_RPC_URL) --private-key $(ANVIL_PRIVATE_KEY) --broadcast -vvvv

enterRaffle:
	@forge script script/Interactions.s.sol:EnterRaffle --rpc-url $(SEPOLIA_RPC_URL) --account account_sepolia --broadcast -vvvv