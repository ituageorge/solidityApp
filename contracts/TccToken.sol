// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract TccToken is ERC20 {
    string tokenName = "Tcc Token";
    string tokenSymbol = "TCCT";

     uint8 _decimals = 9;

    uint256 TOTAL_SUPPLY = 1000000;
   
    constructor() ERC20(tokenName, tokenSymbol) {
        _mint(msg.sender, TOTAL_SUPPLY * (10**_decimals));
    }

    function decimals() public view override  returns (uint8) {
        return _decimals;
    }
}
