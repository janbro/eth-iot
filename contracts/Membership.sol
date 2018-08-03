pragma solidity ^0.4.23;

contract Membership {

	event NewMember(address mid, string memberlevel);

	struct Member {
		string memberlevel;
		uint256 lastrenewal;
	}

	address owner;
	
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

		if(msg.value == 3 ether) {
			members[msg.sender] = Member("Deluxe", block.timestamp);
		}
		else if(msg.value == 1 ether) {
			members[msg.sender] = Member("Standard", block.timestamp);
		}
		else {
			return false;
		}

		emit NewMember(msg.sender, members[msg.sender].memberlevel);
		return true;
	}

	function isActiveMember() public view returns (bool) {
		return (now - members[msg.sender].lastrenewal) <= 4 weeks;
	}

	modifier isNotActive() {
		require(now - members[msg.sender].lastrenewal > 4 weeks);
		_;
	}

	modifier isMember() {
		require(now - members[msg.sender].lastrenewal <= 4 weeks);
		_;
	}

	modifier onlyOwner() {
		require(msg.sender == owner);
		_;
	}

}
