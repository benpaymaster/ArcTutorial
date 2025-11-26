// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract PropertyNFT is ERC721, Ownable {
    uint256 public nextTokenId;
    mapping(uint256 => string) public propertyDetails;

    constructor() ERC721("CardiffHMOProperty", "CHMOP") {}

    function mint(address to, string memory details) external onlyOwner {
        propertyDetails[nextTokenId] = details;
        _safeMint(to, nextTokenId);
        nextTokenId++;
    }
}
