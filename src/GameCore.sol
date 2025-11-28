// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

import "./GameToken.sol";
import "./PropertyNFT.sol";
import "./InvestorItems.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract GameCore is Ownable {
    GameToken public gameToken;
    PropertyNFT public propertyNFT;
    InvestorItems public investorItems;

    event PropertyPurchased(
        address indexed investor,
        uint256 propertyId,
        uint256 price
    );

    constructor(
        address _gameToken,
        address _propertyNFT,
        address _investorItems
    ) {
        gameToken = GameToken(_gameToken);
        propertyNFT = PropertyNFT(_propertyNFT);
        investorItems = InvestorItems(_investorItems);
    }

    function buyProperty(uint256 propertyId, uint256 price) external {
        require(
            gameToken.balanceOf(msg.sender) >= price,
            "Insufficient tokens"
        );
        gameToken.transferFrom(msg.sender, owner(), price);
        propertyNFT.safeTransferFrom(owner(), msg.sender, propertyId);
        emit PropertyPurchased(msg.sender, propertyId, price);
    }

    // Add more game logic and security features as needed
}
