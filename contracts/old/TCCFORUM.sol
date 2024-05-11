// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

contract TCCFORUM {
    string public admin; 

    mapping (string => string) public names;

    constructor(string memory _admin) {
        admin = _admin;
    }

    function createUser(string memory userName, string memory fullName) public {
        names[userName]= fullName;
    }

     function deleteUser(string memory userName) public {
        delete names[userName];
    }

  function updateUserName(string memory userName, string memory fullName) public {
        names[userName]= fullName;
    }

    function getUsers() public {
        
    }





}