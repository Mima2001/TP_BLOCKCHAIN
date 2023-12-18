// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "forge-std/Test.sol";
import "src/Voting.sol";

contract MyContractTest is Test {
   

    function test_vote_once() public {
        SingerVotes votes = new SingerVotes(); 

        votes.vote("singerName");

        assertEq(votes.votes("singerName"), 1); // Check vote count
        assertEq(votes.hasVoted(msg.sender), true); // Check hasVoted

        (bool success, ) = address(votes).call(abi.encodeWithSignature("vote(string)"));
        assertEq(success, false, "Second vote attempt should fail for sender");
    }
}
