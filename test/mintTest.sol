// SPDX-License-Identifier: MIT
pragma solidity >=0.6.2 <0.9.0;

pragma experimental ABIEncoderV2;

import {NaryaTest} from "narya-contracts/NaryaTest.sol";
import "contracts/BoredApeYachtClub.sol";

contract mintTest is NaryaTest {
    address user = makeAddr("user");
    address owner = makeAddr("owner");
    BoredApeYachtClub bayc;
    
    function setUp() public {
        vm.startPrank(owner);
        bayc = new BoredApeYachtClub("BoredApeYachtClub", "BAYC", 10000, block.timestamp + 1 days);
        vm.stopPrank();
        
    }

    function test(uint256 ethAmount, uint256 mintAmount) public {
        vm.startPrank(owner);
        bayc.flipSaleState();
        deal(address(user), ethAmount);
        vm.stopPrank();

        vm.startPrank(user);
        bayc.mintApe{value: ethAmount}(mintAmount);
        uint256 balance = bayc.balanceOf(address(user));
        require(balance == mintAmount);
        vm.stopPrank();
        
    }
}

