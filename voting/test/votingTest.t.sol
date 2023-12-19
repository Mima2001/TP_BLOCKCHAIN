// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;
import "forge-std/Test.sol";
import "src/SingingContest.sol"; // Corrected import statement and file name

contract SingingContestTest is Test {
    SingingContest singingContest; // Corrected variable name

    function setUp() public {
        // Deploy a new contract instance for each test
        bytes32[] memory singerNames = new bytes32[](3);
        singerNames[0] = "Alice";
        singerNames[1] = "Bob";
        singerNames[2] = "Charlie";
        singingContest = new SingingContest(singerNames);
    }
    function testInitialVoteCounts() public {
        assertEq(singingContest.totalVotesFor("Alice"), 0);
        assertEq(singingContest.totalVotesFor("Bob"), 0);
        assertEq(singingContest.totalVotesFor("Charlie"), 0);
        assertEq(singingContest.totalVotesFor("InvalidSinger"), 0); // Test for non-existent singer
    }

    function testVotingForSinger() public {
        singingContest.voteForSinger("Alice");
        assertEq(singingContest.totalVotesFor("Alice"), 1);

        singingContest.voteForSinger("Bob");
        singingContest.voteForSinger("Bob");
        assertEq(singingContest.totalVotesFor("Bob"), 2);
    }

    function testValidSingerCheck() public view {
        assert(singingContest.validSinger("Alice"));
        assert(singingContest.validSinger("Bob"));
        assert(singingContest.validSinger("Charlie"));
        assert(!singingContest.validSinger("InvalidSinger"));
    }

    function testVotingForInvalidSinger() public {
        singingContest.voteForSinger("InvalidSinger");
        assertEq(singingContest.totalVotesFor("InvalidSinger"), 0); // Ensure no vote is counted
    }

   
}
