// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract SingingContest {
    mapping (bytes32 => uint8) public votesReceived;
    bytes32[] public singerList;

    constructor(bytes32[] memory singerNames) {
        singerList = singerNames;
    }

    function totalVotesFor(bytes32 singer) public view returns (uint8) {
        require(validSinger(singer), "Invalid singer");
        return votesReceived[singer];
    }

    function voteForSinger(bytes32 singer) public {
        require(validSinger(singer), "Invalid singer");
        votesReceived[singer] += 1;
    }

    function validSinger(bytes32 singer) public view returns (bool) {
        for(uint i = 0; i < singerList.length; i++) {
            if (singerList[i] == singer) {
                return true;
            }
        }
        return false;
    }
}

