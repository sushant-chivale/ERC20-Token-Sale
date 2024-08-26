//Let's use a sample contract from OpenZeppelin to deploy a token. This token could represent anything - for example a voucher for coffees.
//The flow could be:
//We can give users tokens for coffees
//The user can spend the coffee token in his own name, or give it to someone else
//Coffee tokens get burned when the user gets his coffee.


// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";

contract CoffeeToken is ERC20, AccessControl {
    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");

    event CoffeePurchased(address indexed receiver, address indexed buyer);

    constructor() ERC20("CoffeeToken", "CFE") {
        _grantRole(DEFAULT_ADMIN_ROLE, msg.sender);
        _grantRole(MINTER_ROLE, msg.sender);
    }

    function mint(address to, uint256 amount) public onlyRole(MINTER_ROLE) {
        _mint(to, amount);
    }

    function buyOneCoffee() public {
        _burn(_msgSender(), 1);
        emit CoffeePurchased(_msgSender(), _msgSender());
    }

    function buyOneCoffeeFrom(address account) public {
        _spendAllowance(account, _msgSender(), 1);
        _burn(account, 1);
        emit CoffeePurchased(_msgSender(), account);
    }
}



//-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------



//we now already implemented an ERC20 token. But somehow, we can either mint it for someone, but nobody can obtain those tokens otherwise.
//We will use the Token from the previous above. But instead of integrating a token sale directly, we let another contract take control of some of the tokens through an allowance functionality.

//SPDX-License-Identifier: MIT
pragma solidity 0.8.16;

interface IERC20 {
    function transfer(address to, uint amount) external;
    function decimals() external view returns(uint);
}

contract TokenSale {
    uint tokenPriceInWei = 1 ether;

    IERC20 token;

    constructor(address _token) {
        token = IERC20(_token);
    }

    function purchase() public payable {
        require(msg.value >= tokenPriceInWei, "Not enough money sent");
        uint tokensToTransfer = msg.value / tokenPriceInWei;
        uint remainder = msg.value - tokensToTransfer * tokenPriceInWei;
        token.transfer(msg.sender, tokensToTransfer * 10 ** token.decimals());
        payable(msg.sender).transfer(remainder); //send the rest back

    }
}
