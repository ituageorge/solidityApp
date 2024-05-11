// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;
import './TccPost.sol';
import './TccUser.sol';

contract TCC {
    TccPost public post;
    TccUser public user;

    constructor() {
        user = new TccUser();
        post = new TccPost(user);
    }

    function signup(string memory _username, string memory _fullname) public {
        user.registerUser(_username, _fullname, msg.sender);
    }

    function signin(string memory _username)
    public 
    view 
    returns(TccUser.User memory){
        return user.login(_username, msg.sender);
    }

    function createPost(string memory _title, string memory _body ) public {
        post.createPost(_title, _body, msg.sender);
    }

    function getPost(uint256 _postId)
    public 
    view 
    returns (TccPost.Post memory)
    {
        return post.getPost(_postId);
    }

    function getPosts(uint256 _page, uint256 _pageSize) public view returns (   string[] memory,
            string[] memory,
            string[] memory,
            uint256[] memory) {
        return post.getPosts(_page, _pageSize);
    }

    function updatePost(
        uint256 _postId,
        string memory _title,
        string memory _body

    ) public {
        post.updatePost(_postId, _title, _body, msg.sender);
    }

    function deletePost(uint256 _postId) public {
        post.deletetPost(_postId, msg.sender);
    }


}