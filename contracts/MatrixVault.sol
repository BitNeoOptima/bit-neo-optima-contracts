// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import {Ownable} from "@openzeppelin-contracts-5.4.0/access/Ownable.sol";

contract MatrixVault is Ownable {
	constructor() Ownable(msg.sender) {}
}
