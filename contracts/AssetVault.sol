pragma solidity ^0.8.23;

import {ERC4626} from "@openzeppelin-contracts-5.4.0/token/ERC20/extensions/ERC4626.sol";
import {IERC20Metadata} from "@openzeppelin-contracts-5.4.0/token/ERC20/extensions/IERC20Metadata.sol";
import {ERC20} from "@openzeppelin-contracts-5.4.0/token/ERC20/ERC20.sol";

contract AssetVault is ERC4626 {
	constructor(IERC20Metadata asset)
		ERC4626(asset)
		ERC20(string.concat("bno", asset.name()), string.concat("bno", asset.symbol()))
	{}
}
