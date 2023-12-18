// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract SingerVotes {

   
    mapping(string => uint256) public votes;
    mapping(address => bool) public hasVoted;


   
    event Voted(address voter, string singer);

    function vote(string memory singer) external  {
            require(!hasVoted[msg.sender], "You have already voted.");
      

        votes[singer]++;
            hasVoted[msg.sender] = true;

       emit Voted(msg.sender, singer);
    }
}