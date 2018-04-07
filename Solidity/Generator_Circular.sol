pragma solidity ^0.4.0;

//TODO: Upload and store pixel to Swarm
//TODO: Convert bytearray to hex outside of Solidity
//TODO: Create SecondGenerator with values from first one -> Didnt work due to circular dependency.
//TODO: Add methods to change color on payment recieved
//TODO: Try generating contracts through a while loop.

interface Regulator {
    function checkAmount(uint amount) public returns (bool);
    function isOwner(address) public returns (bool);
}

contract Generator is Regulator {
    uint constant private amount = 10000;
    uint8[] private defaultcolor = [0,0,0,0];
    address constant private owner = msg.sender;
    PixelTest[] public pixels;
    address[] generators;
    //Enables only contract owner
    modifier ownerFunc {
        require(owner == msg.sender);
        _;
    }
    function GetDefaultColor() public returns (uint8[]) {
        return defaultcolor;
    }
    function GetDefaultOwner() public returns (address) {
        return owner;
    }
    function Generator() public {
        uint id;
        for (uint i = 0; i <amount; i++) {
            //Ensures no overflow
            require(id <= amount);
            //Create and store pixel to memory
            PixelTest memory pixel = PixelTest(i,defaultcolor, owner);
            //Copy pixel to PixelArray
            pixels.push(pixel);
            //Delete pixel stored in memory
            delete pixel;
            id = i;
        }
        createNextGenerator(id, amount);
    }
    
    function createNextGenerator public (uint currentId, uint _amount) {
        address nextGenerator = new NextGenerator(currentId, _amount);
        generators.push(nextGenerator);
        delete nextGenerator;
    } 

    struct PixelTest {
        uint256 id;
        uint8[] color;
        address owner;
    }
    function Throw() {
        throw;
    }
    
    //Throws exception if number is higher than max.
    function AmountException(uint _num, uint _max) {
        if(_num > _max) {
            throw;
        }
    }
}

contract NextGenerator is Generator() {
    function NextGenerator(uint currentId, uint _amount) {
        uint id;
        for (uint i = id; i < _amount; i++) {
            //Ensures no overflow
            require(currentId <= _amount);
            //Create and store pixel to memory
            PixelTest memory pixel = PixelTest(i, GetDefaultColor(), GetDefaultOwner());
            //Copy pixel to PixelArray
            pixels.push(pixel);
            //Delete pixel stored in memory
            delete pixel;
            id = i;
        }
        createNextGenerator(id, _amount);
    }
    
}

//String can parse to bytes32 without any conversion!
contract HelloWorld {
    event log_string(bytes32 log); // Event

    function () { // Fallback Function
        log_string("Hello World!");
    }
}
   