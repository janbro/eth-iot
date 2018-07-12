pragma solidity ^0.4.23;

contract Membership {

	event NewMember(address mid, string memberlevel);

	struct Member {
		string memberlevel;
		uint256 lastrenewal;
	}

	uint256 owner;
	
	mapping (address => Member) members;

	constructor() public {
		owner = msg.sender;
	}

	function () external payable {
		if(msg.value > 0) {
			signUpOrRenew();
		}
	}

	// @dev Membership level Standard: Floor access
	//			 Deluxe: Rooftop Pool
	function signUpOrRenew() public payable isNotActive returns (bool) {
		require(msg.value > 0);
		Member storage member = members[msg.sender];

		if(msg.value >= 3 ether) {
			member = Member("Deluxe", block.timestamp);
		}
		else if(msg.value >= 1 ether) {
			member = Member("Standard", block.timestamp);
		}
		else {
			return false;
		}

		emit NewMember(msg.sender, member.memberlevel);
		return true;
	}

	modifier isNotActive() {
		require(members[msg.sender] == 0 || block.timestamp - members[msg.sender].lastrenewal > 4 weeks);
		_;
	}

	modifier isMember() {
		require(members[msg.sender] != 0);
		_;
	}

	modifier onlyOwner() {
		require(msg.sender == owner);
		_;
	}

}
