// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

contract TccUser {
    struct User {
        string username;
        string fullname;
        address walletAddress;
    }

    //  bytes array data type
    mapping(string => User) public users;

    mapping(address => string) public userNames;

    modifier isUserRegistered(string memory _username) {
        require(
            bytes(users[_username].username).length == 0,
            "User already exist!"
        );
        _;
    }

    function registerUser(
        string memory _username,
        string memory _fullname,
        address _walletAddress
    ) public isUserRegistered(_username) {
        users[_username] = User(_username, _fullname, _walletAddress);

        // store usernames
        userNames[_walletAddress] = _username;
    }

    // get current username
    function getCurrentUsername(
        address _walletAddress
    ) public view returns (string memory) {
        require(
            bytes(userNames[_walletAddress]).length > 0,
            "Unable to find username!"
        );
        return userNames[_walletAddress];
    }

    function userExist(string memory _username) public view {
        require(
            bytes(users[_username].username).length > 0,
            "User is not registered!"
        );
    }

    function login(
        string memory _username,
        address _walletAddress
    ) public view returns (User memory) {
        userExist(_username);
        User memory user = users[_username];
        require(
            user.walletAddress == _walletAddress,
            "Invalid wallet Address!"
        );
        return (user);
    }
}
