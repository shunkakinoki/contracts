// SPDX-License-Identifier: MIT
pragma solidity >=0.8.4;
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";
import {SafeTransferLib} from "@rari-capital/solmate/src/utils/SafeTransferLib.sol";
import {ERC20} from "@rari-capital/solmate/src/tokens/ERC20.sol";
import {ERC721} from "@rari-capital/solmate/src/tokens/ERC721.sol";

///@notice Ownable helper contract to withdraw ether or tokens from the contract address balance
contract Withdrawable is Ownable {
    ///@notice Withdraw Ether from contract address. OnlyOwner.
    function withdraw() external onlyOwner {
        uint256 balance = address(this).balance;
        SafeTransferLib.safeTransferETH(msg.sender, balance);
    }

    ///@notice Withdraw tokens from contract address. OnlyOwner.
    ///@param _token ERC20 smart contract address
    function withdrawERC20(address _token) external onlyOwner {
        ERC20 token = ERC20(_token);
        uint256 balance = ERC20(_token).balanceOf(address(this));
        SafeTransferLib.safeTransfer(token, msg.sender, balance);
    }

    ///@notice Withdraw tokens from contract address. OnlyOwner.
    ///@param _token ERC721 smart contract address
    function withdrawERC721(address _token, uint256 tokenId) external onlyOwner {
        ERC721 token = ERC721(_token);
        token.transferFrom(address(this), msg.sender, tokenId);
    }
}