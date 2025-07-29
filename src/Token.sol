// SPDX-License-Identifier: MIT
// Compatible with OpenZeppelin Contracts ^5.0.0
pragma solidity ^0.8.27;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import {ERC20Burnable} from "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import {ERC20Permit} from "@openzeppelin/contracts/token/ERC20/extensions/ERC20Permit.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

contract Token is ERC20, ERC20Burnable, Ownable, ERC20Permit {
    uint8 private nrOfDecimals;

    constructor(address initialOwner, string memory name, string memory symbol, uint8 tokenDecimals)
        ERC20(name, symbol)
        Ownable(initialOwner)
        ERC20Permit(name)
    {
        require(tokenDecimals <= 18, "Decimals cannot exceed 18");
        nrOfDecimals = tokenDecimals;
    }

    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }

    function decimals() public view override returns (uint8) {
        return nrOfDecimals;
    }
}
