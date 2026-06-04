import os
from dotenv import load_dotenv
from wake.testing import *
from pytypes.contracts.MatrixVault import MatrixVault
from pytypes.contracts.AssetVault import AssetVault
from pytypes.wake.interfaces.IERC20 import IERC20
from pytypes.dependencies.openzeppelincontracts5_4_0.token.ERC20.extensions.IERC20Metadata import IERC20Metadata

load_dotenv()

WETH = Address("0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2")
DEPOSIT_AMOUNT = 50 * 10**18


@chain.connect(
	accounts=2,
	chain_id=1,
	fork=os.getenv("ETHEREUM_RPC_URL"),
)
def test_distribution():
	user = chain.accounts[1]
	matrix_vault = MatrixVault.deploy()
	asset_vault = AssetVault.deploy(IERC20Metadata(WETH))
	assert asset_vault.asset() == WETH
	# WETH9: plain ETH transfer to the contract mints WETH
	Account(WETH).transact(value=DEPOSIT_AMOUNT, from_=user)
	weth = IERC20(WETH)
	weth.approve(asset_vault.address, DEPOSIT_AMOUNT, from_=user)
	asset_vault.deposit(DEPOSIT_AMOUNT, user.address, from_=user)
	assert asset_vault.balanceOf(user.address) == DEPOSIT_AMOUNT
	assert asset_vault.totalAssets() == DEPOSIT_AMOUNT
