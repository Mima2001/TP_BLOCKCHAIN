// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract SingingContest {
    // Struct to represent a singer with a name and total votes received
    struct Singer {
        bytes32 name;
        uint8 votesReceived;
    }

    // Array of Singer structs to store information about each singer
    Singer[] public singers;

    // Mapping to check if a singer name is valid
    mapping (bytes32 => bool) public validSingers;

    // Event to notify when a vote is cast
    event Voted(bytes32 indexed singer, address indexed voter);

    // Constructor to initialize the list of singers
    constructor(bytes32[] memory singerNames) {
        require(singerNames.length > 0, "Singer list cannot be empty");
        
        for (uint i = 0; i < singerNames.length; i++) {
            require(!validSingers[singerNames[i]], "Duplicate singer names are not allowed");
            singers.push(Singer(singerNames[i], 0));
            validSingers[singerNames[i]] = true;
        }
    }

    // Function to get the total votes for a singer
    function totalVotesFor(bytes32 singer) external view returns (uint8) {
        require(validSinger(singer), "Invalid singer");
        return votesReceived(singer);
    }

    // Function to vote for a singer
    function voteForSinger(bytes32 singer) external {
        require(validSinger(singer), "Invalid singer");
        singers[_singerIndex(singer)].votesReceived += 1;
        emit Voted(singer, msg.sender);
    }

    // Function to check if a singer is valid
    function validSinger(bytes32 singer) public view returns (bool) {
        return validSingers[singer];
    }

    // Internal function to get the index of a singer in the singers array
    function _singerIndex(bytes32 singer) internal view returns (uint) {
        for (uint i = 0; i < singers.length; i++) {
            if (singers[i].name == singer) {
                return i;
            }
        }
        revert("Singer not found");
    }

    // Internal function to get the votes received for a singer
    function votesReceived(bytes32 singer) internal view returns (uint8) {
        return singers[_singerIndex(singer)].votesReceived;
    }
}
