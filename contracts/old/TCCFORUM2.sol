// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

contract TCCFORUM {
    address public admin;

    struct User {
        string userName;
        string fullName;
    }

    // In this example, the keys are of type uint256, and the values are of type struct.
    //  The public keyword makes the mapping accessible from outside the contract, allowing other contracts or users to interact with it.
    mapping(uint256 => User) public users;
   
    uint256 count = 0;

    constructor() {
        admin = msg.sender;
    }

    // middleware to make sure the current wallet is an admin wallet
    modifier isAdmin() {
        require(msg.sender==admin, "You need to be an admin!");
        _;
    }

    function createUser(string memory userName, string memory fullName) isAdmin public {
        users[count] = User(userName, fullName);
        count += 1;
    }

    function findUser(
        string memory userName
    ) public view returns (string memory, string memory) {
        for (uint256 i = 0; i < count; i++) {
            if (
                keccak256(abi.encodePacked(users[i].userName)) ==
                keccak256(abi.encodePacked(userName))
            ) {
                // return users[i].data;
                return (users[i].userName, users[i].fullName);
            }
        }
        require(false, "Unable to find user!");
    }

    function deleteUser(uint256 index) public {
        delete users[index];
    }

    function updateUserName(uint256 index, string memory fullName) public {
        users[index].userName = fullName;
    }

    function getUsers() public view returns (User[] memory) {
        // return (users);\
        User[] memory userList = new User[](count);
        for (uint256 newCount = 0; newCount < count; newCount++) {
            userList[newCount] = users[newCount];
        }
        return userList;
    }
}
