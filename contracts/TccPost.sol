// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

import "./TccUser.sol";

contract TccPost {
    TccUser user;

    struct Post {
        string title;
        string body;
        string username;
    }

    uint256 postCount = 0;
    mapping(uint256 => Post) public posts;

    constructor(TccUser _user) {
        user = _user;
    }

    modifier isPostOwner(uint256 _postId, address _walletAddress) {
        Post memory post = postExist(_postId);

        require(
            keccak256(abi.encodePacked(post.username)) ==
                keccak256(
                    abi.encodePacked(user.getCurrentUsername(_walletAddress))
                ),
            "You are not authorized to perform this function!"
        );
        _;
    }

    function postExist(uint256 _postId) public view returns (Post memory) {
        require(bytes(posts[_postId].title).length > 0, "Invalid post id!");
        return posts[_postId];
    }

    // creat  post
    function createPost(
        string memory _title,
        string memory _body,
        address _walletAddress
    ) public {
        posts[postCount] = Post(
            _title,
            _body,
            user.getCurrentUsername(_walletAddress)
        );
        postCount++;
    }

    // get a single post
    function getPost(uint256 _postId) public view returns (Post memory) {
        Post memory post = posts[_postId];
        require(bytes(post.title).length > 0, "Invalid post id!");
        return post;
    }

    // delete post
    function deletetPost(
        uint256 _postId,
        address _walletAddress
    ) public isPostOwner(_postId, _walletAddress) {
        postExist(_postId);
        delete posts[_postId];
    }

    function updatePost(
        uint256 _postId,
        string memory _title,
        string memory _body,
        address _walletAddress
    ) public isPostOwner(_postId, _walletAddress) {
        postExist(_postId);
        posts[_postId] = Post(
            _title,
            _body,
            user.getCurrentUsername(_walletAddress)
        );
    }

    // get multiple post
    function getPosts(
        uint256 _page,
        uint256 _pageSize
    )
        public
        view
        returns (
            string[] memory,
            string[] memory,
            string[] memory,
            uint256[] memory
        )
    {
        require(_page != 0, "Page must not be equal to zero");
        require(_pageSize != 0, "Page size must not be equal to zero");

        uint256 startIndex = (_page - 1) * _pageSize;
        uint256 endIndex = (startIndex + _pageSize) > postCount
            ? postCount
            : (startIndex + _pageSize);

        string[] memory titles = new string[](startIndex - endIndex);
        string[] memory bodies = new string[](startIndex - endIndex);
        string[] memory usernames = new string[](startIndex - endIndex);
        uint256[] memory postIds = new uint256[](startIndex - endIndex);

        for (uint256 i = startIndex; i <= endIndex; i++) {
            titles[i - startIndex] = posts[i].title;
            bodies[i - startIndex] = posts[i].body;
            usernames[i - startIndex] = posts[i].username;
            postIds[i - startIndex] = i;
            // currentPosts[i] = Post(title, body, username);
        }

        return (titles, bodies, usernames, postIds);
    }
}
