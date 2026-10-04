//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import {PriceConversion} from "./PriceConversion.sol";

contract CrowdFunding {
    using PriceConversion for uint256;

    address public owner ;
    struct Funder {
        address funderAddress;
        uint256 fundAmount;
    }

    error TransactionFail();
    error NotOwner();

    Funder[] public funderDatabase ;
    uint256 public fundTargetinUSD ;

    function fundProject ()  payable external {
            funderDatabase.push(Funder(msg.sender, msg.value));
    }  

    function withdraw () external {
            if (msg.sender != owner) revert NotOwner();
            if (address(this).balance.getEthPrice() > fundTargetinUSD){
            (bool success,) = payable (msg.sender).call{value: address(this).balance}("");
            if (!success) revert TransactionFail();
            }
    }

    function refund () external {
        for (uint i = 0 ; i < funderDatabase.length ; i++){
        (bool success,) = payable(funderDatabase[i].funderAddress).call{value:funderDatabase[i].fundAmount}("");
        if (!success) revert TransactionFail();
        }
    }

    function getContractAmount () external view returns(uint256){
        return address(this).balance.getEthPrice();
    }
}
