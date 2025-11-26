// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract GameToken is ERC20 {
    constructor() ERC20("CardiffHMO", "CHMO") {
        _mint(msg.sender, 1_000_000 * 10 ** decimals());
    }
}
