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

    function testUserCanAbandonPet() public {
        // make sure that the address of the adopter is set to the current contract
        address expectedAdopter = this;
        address adopter = adoption.adopters(8);
        Assert.equal(adopter, expectedAdopter, "Owner of petId 8 should not be an empty address");
        // abandon the pet
        uint returnedId = adoption.abandon(8);
        uint expectedPetId = 8;
        // this should be the address at position 8 after pet abandonment
        address expectedAddress = 0x0000000000000000000000000000000000000000;
        // retrieve the updated adopter address
        adopter = adoption.adopters(8);
        Assert.equal(adopter, expectedAddress, "Owner of petId 8 should be reset to empty address");
        Assert.equal(returnedId, expectedPetId, "Abandonment of petId 8 should be recorded");
    }
}