pragma solidity ^0.4.17; // minimum version of solidity to use

contract Adoption {
    address[16] public adopters; // an array of ethereum addresses

    function adopt(uint petId) public returns (uint) {
        require(petId >= 0 && petId <= 15);
        adopters[petId] = msg.sender;
        return petId;
    }

    function getAdopters() public view returns (address[16]) {
        return adopters;
    }
}