// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import {Ownable} from "@openzeppelin-contracts-5.4.0/access/Ownable.sol";
import {IAaveV3Pool} from "./interfaces/IAaveV3Pool.sol";
import {IComet} from "./interfaces/IComet.sol";

contract MatrixVault is Ownable {
	enum Action {
		Deposit,
		Withdraw,
		Borrow,
		Repay,
		SwapIn,
		SwapOut
	}

	enum Protocol {
		Aave,
		Compound,
		Ammalgam,
		UniswapV3,
		Wrapper
	}

	struct Operation {
		Action action;
		Protocol protocol;
		address target;
		address asset;
		uint256 value;
	}

	constructor() Ownable(msg.sender) {}

	function execute(Operation[] calldata operations) external onlyOwner {
		for (uint256 i = 0; i < operations.length; i++) {
			Operation calldata operation = operations[i];
			if (operation.action == Action.Deposit) {
				_deposit(operation);
			} else if (operation.action == Action.Withdraw) {
				_withdraw(operation);
			} else if (operation.action == Action.Borrow) {
				_borrow(operation);
			} else if (operation.action == Action.Repay) {
				_repay(operation);
			} else if (operation.action == Action.SwapIn) {
				//_swapIn(operation);
			} else if (operation.action == Action.SwapOut) {
				//_swapOut(operation);
			} else {
				revert("MatrixVault: unsupported action");
			}
		}
	}

	function _deposit(Operation calldata operation) internal {
		if (operation.protocol == Protocol.Aave) {
			IAaveV3Pool(operation.target).deposit(operation.asset, operation.value, address(this), 0);
		} else if (operation.protocol == Protocol.Compound) {
			IComet(operation.target).supply(operation.asset, operation.value);
		} else if (operation.protocol == Protocol.Ammalgam) {
			//ILendingPool(operation.target).deposit(operation.asset, operation.value, address(this), 0);
		} else if (operation.protocol == Protocol.UniswapV3) {
			//ILendingPool(operation.target).deposit(operation.asset, operation.value, address(this), 0);
		} else if (operation.protocol == Protocol.Wrapper) {
			//ILendingPool(operation.target).deposit(operation.asset, operation.value, address(this), 0);
		} else {
			revert("MatrixVault: unsupported protocol");
		}
	}

	function _withdraw(Operation calldata operation) internal {
		if (operation.protocol == Protocol.Aave) {
			IAaveV3Pool(operation.target).withdraw(operation.asset, operation.value, address(this)); // wake-disable-line unchecked-return-value
		} else if (operation.protocol == Protocol.Compound) {
			IComet(operation.target).withdraw(operation.asset, operation.value);
		} else if (operation.protocol == Protocol.Ammalgam) {
			// withdraw via Ammalgam
		} else if (operation.protocol == Protocol.UniswapV3) {
			// withdraw via Uniswap V3
		} else if (operation.protocol == Protocol.Wrapper) {
			// withdraw via Wrapper
		} else {
			revert("MatrixVault: unsupported protocol");
		}
	}

	function _borrow(Operation calldata operation) internal {
		if (operation.protocol == Protocol.Aave) {
			IAaveV3Pool(operation.target).borrow(operation.asset, operation.value, 2, 0, address(this));
		} else if (operation.protocol == Protocol.Compound) {
			IComet(operation.target).withdraw(operation.asset, operation.value);
		} else if (operation.protocol == Protocol.Ammalgam) {
			// borrow via Ammalgam
		} else if (operation.protocol == Protocol.UniswapV3) {
			// borrow via Uniswap V3
		} else if (operation.protocol == Protocol.Wrapper) {
			// borrow via Wrapper
		} else {
			revert("MatrixVault: unsupported protocol");
		}
	}

	function _repay(Operation calldata operation) internal {
		if (operation.protocol == Protocol.Aave) {
			IAaveV3Pool(operation.target).repay(operation.asset, operation.value, 2, address(this)); // wake-disable-line unchecked-return-value
		} else if (operation.protocol == Protocol.Compound) {
			IComet(operation.target).supply(operation.asset, operation.value);
		} else if (operation.protocol == Protocol.Ammalgam) {
			// repay via Ammalgam
		} else if (operation.protocol == Protocol.UniswapV3) {
			// repay via Uniswap V3
		} else if (operation.protocol == Protocol.Wrapper) {
			// repay via Wrapper
		} else {
			revert("MatrixVault: unsupported protocol");
		}
	}

	/*function _swapIn(Operation calldata operation) internal {
		if (operation.protocol == Protocol.Ammalgam) {
			// swap in via Ammalgam
		} else if (operation.protocol == Protocol.UniswapV3) {
			//
		} else {
			revert("MatrixVault: unsupported protocol");
		}
	}

	function _swapOut(Operation calldata operation) internal {
		if (operation.protocol == Protocol.Aave) {
			// swap out via Aave
		} else if (operation.protocol == Protocol.Compound) {
			// swap out via Compound
		} else if (operation.protocol == Protocol.Ammalgam) {
			// swap out via Ammalgam
		} else if (operation.protocol == Protocol.UniswapV3) {
			// swap out via Uniswap V3
		} else if (operation.protocol == Protocol.Wrapper) {
			// swap out via Wrapper
		} else {
			revert("MatrixVault: unsupported protocol");
		}
	}*/
}
