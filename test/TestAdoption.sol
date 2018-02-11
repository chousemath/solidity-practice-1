pragma solidity ^0.4.17;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/Adoption.sol";

contract TestAdoption {
    Adoption adoption = Adoption(DeployedAddresses.Adoption());

    function testUserCanAdoptPet() public {
        uint returnedId = adoption.adopt(8);
        uint expectedPetId = 8;
        Assert.equal(returnedId, expectedPetId, "Adoption of petId 8 should be recorded");
    }

    function testGetAdopterAddressByPetId() public {
        address expectedAdopter = this;
        address adopter = adoption.adopters(8);
        Assert.equal(adopter, expectedAdopter, "Owner of petId 8 should be recorded");
    }

    function testGetAdopterAddressByPetIdInArray() public {
        address expectedAdopter = this;
        address[16] memory adopters = adoption.getAdopters();
        Assert.equal(adopters[8], expectedAdopter, "Owner of petId 8 should be recorded");
    }
}