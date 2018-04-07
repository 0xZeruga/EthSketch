pragma solidity ^0.4.19;	

import "./ERC20.sol"; 
import "./SafeMath.sol";

contract Canvas {

    //Address to which the funds will be sent
    address public owner;

    mapping(address => uint256) balances;
    mapping(address => mapping(address =>uint256)) allowed;

    using SafeMath for uint256;
    
    address[] newContracts;
    
    struct PixelTest {
        uint256 id;
        uint256 x;
        uint256 y;
        uint256 start;
        bytes32[] color;
        uint256 count;
        
        address owner;
    }
    
    //Determines max Size in X and Y of the Canvas
    uint256 constant Size_X = 100;
    uint256 constant Size_Y = 100;
    uint256 constant START_PRICE = 5;
    uint256 id = 1;
    
    //TODO Port bytes32 to hex and back.
    bytes32[] color;
    PixelTest[] public pixels;
    
    //Add initial empty pixels on contract start.
    function Canvas() public {
       SetInitialPixels();
    }
    
    function SetInitialPixels()  {
        for (uint i=0; i<Size_X;i++) {
            for (uint j=0; j<Size_Y; j++) {
            PixelTest memory pixel = PixelTest(id,i,j,START_PRICE,color,0,owner);
            pixels.push(pixel);
            id++;
            }
        }
    }
    
    //Get examples
    
    //Get pixel by index
    function getPixel(uint n) public constant returns (uint256, uint256, uint256, uint256, bytes32[], uint256, address) {
        return (pixels[n].id, pixels[n].x, pixels[n].y, pixels[n].start, pixels[n].color ,pixels[n].count, pixels[n].owner);
    }
    
    //Get color
    function GetColor(uint n) public view returns (bytes32[] color) {
        return pixels[n].color;
    }
    //Get count
    function GetCount(uint n) public view returns (uint256 count) {
        return pixels[n].count;
    }
    //Get cost
    function GetPixelPrice(uint n) public view returns (uint256 cost) {
        return GetPrice(pixels[n].start,pixels[n].count);
    }
    //Get cost pure
    function GetPrice(uint256 _start, uint256 _count) pure returns (uint256 _price) {
        return _start*(_count*1);
    }
    
    
    //Set examples
    
    //Set cost
    function SetColor(uint n, bytes32[] _c) {
        pixels[n].color = _c;
    }
    function SetOwner(uint n, address _sender) {
        pixels[n].owner = _sender;
    }
    function IncrementCounter(uint256 n) {
        pixels[n].count = pixels[n].count.add(1);
    }
    function SetHexColor(uint256 n, bytes32[] _color) {
        pixels[n].color = _color;
    }
    
    
    //TODO: Use these somehow?
    //This checks whether Ether has been paid to the address
    function () private payable {
        UpdateColor();
    }
    //Automatically send tokens.
    function UpdateColor() public payable {
        require(msg.value > 0);
        owner.transfer(msg.value);
    }
    
     function balanceOf(address _owner) public constant returns (uint256 balance) {
        return balances[_owner];
    }
    
    function approve(address _spender, uint256 _value) public returns (bool success) {
        allowed[msg.sender][_spender] = _value;
        Approval(msg.sender, _spender, _value);
        return true;
    }
    
    //Spend from sender funds.
    //This recieves pixel.Cost at index i.
    function transfer(address _to, uint256 _value) public returns (bool success) {
        require(balances[msg.sender] >= _value && _value > 0);
        balances[msg.sender].sub(_value);
        balances[_to].add(_value);
        Transfer(msg.sender, _to, _value);
        return true;
    }
    
    function getTransfer(address _to, uint256 _value, uint256 _id, bytes32[] _color) public returns (bool success) {
        require(transfer(_to,_value)); 
            SetColor(_id,_color);
            IncrementCounter(_id);
            return true;
    }

    function allowance(address _owner, address _spender) public constant returns (uint256 remaining) {
         return allowed[_owner][_spender];
    }
    
    event Transfer(address indexed _from, address indexed _to, uint256 _value);
    event Approval(address indexed _owner, address indexed _spender, uint256 _value);
}