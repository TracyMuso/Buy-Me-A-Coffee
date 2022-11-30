// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

contract  BuyMeACoffee  {
    // Event to emit when a memo is created
    event NewMemo (
        address indexed from,
        uint256,
        string name,
        string message
    );
    // Memo struct
    struct Memo {
        address from;
        uint256 timestamp;
        string name;
        string message;
    }

    Memo[] memos;

    // address of contractdeployer
    address payable owner;

// deploy logic
    constructor() {
        owner = payable(msg.sender);
    }

    /**@dev buy s coffee for a contract owner
     * @param _name name of the buyer
     *@param _message message to the owner
     */

    function buyCoffee(string memory _name, string memory _message) public payable {
        require(msg.value > 0, "can't buy coffee for free!");

        // add the memo to the storage
        memos.push(Memo(
            msg.sender,
            block.timestamp,
            _name,
            _message
        ));
        // emit a log event when a new memo is created
        emit NewMemo(
            msg.sender,
            block.timestamp,
            _name,
            _message
        );
    }
    /**
     * @dev send the entire balance stored in this contract to the owner
     */
    function withdrawTips() public {
        require(owner.send(address(this).balance));
    }
    /**
     * @dev retrieve all the memos stored on the blockchain
     */
    function getMemos() public view returns(Memo[] memory) {
        return memos;
    }
}