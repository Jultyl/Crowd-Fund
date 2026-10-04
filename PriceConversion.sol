//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

library PriceConversion {

    function getPrice () public view returns(uint256){
        AggregatorV3Interface priceFeed= AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
            (, int256 _answer,,,) = priceFeed.latestRoundData()  ;
            return uint256(_answer);

    }

    function getEthPrice (uint256 _EthQuantity) public view returns(uint256){
        uint256 _EthUSDAmount = getPrice() * _EthQuantity;
        return _EthUSDAmount ;
    }

}
