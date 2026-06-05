from wake.testing import *
from pytypes.contracts.AssetVault import AssetVault
from pytypes.contracts.mocks.MockERC20 import MockERC20

DEPOSIT_AMOUNT = 50 * 10**18


@chain.connect(accounts=2)
def test_asset_vault_deposit():
	asset = MockERC20.deploy("Test", "TST")
	mint_erc20(asset, chain.accounts[0], DEPOSIT_AMOUNT)

	asset_vault = AssetVault.deploy(asset)
	assert asset_vault.asset() == asset.address
	assert asset_vault.name() == "bnoTest"
	assert asset_vault.symbol() == "bnoTST"

	asset.approve(asset_vault.address, DEPOSIT_AMOUNT)
	asset_vault.deposit(DEPOSIT_AMOUNT, chain.accounts[0])

	assert asset_vault.balanceOf(chain.accounts[0]) == DEPOSIT_AMOUNT
	assert asset_vault.totalAssets() == DEPOSIT_AMOUNT
	assert asset_vault.convertToAssets(asset_vault.balanceOf(chain.accounts[0])) == DEPOSIT_AMOUNT