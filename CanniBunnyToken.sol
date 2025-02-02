// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

contract CanniBunnyToken is ERC20, Ownable {
    uint256 public constant MAX_SUPPLY = 1_500_000 * 10**18; // 1.5 Million CBT

    constructor(address initialOwner) ERC20("CanniBunny Token", "CBT") Ownable(initialOwner) {
        _mint(initialOwner, MAX_SUPPLY);
    }

    /**
     * @dev Allows the owner to mint additional tokens, but never beyond MAX_SUPPLY.
     */
    function mint(address to, uint256 amount) public onlyOwner {
        require(totalSupply() + amount <= MAX_SUPPLY, "Minting exceeds max supply");
        _mint(to, amount);
    }

    /**
     * @dev Allows token holders to burn their own tokens, reducing total supply.
     */
    function burn(uint256 amount) public {
        _burn(msg.sender, amount);
    }
}
