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
        uint256 constant start;
        bytes32[] color;
        uint256 count;
        
        address owner;
        
        //TODO: Find out a way to parse uint256 to bytes32[]
       // uint256 p = GetPrice(start,count);
    }
    

    //Determines max Size in X and Y of the Canvas
    uint256 constant Size_X = 100;
    uint256 constant Size_Y = 100;
    
    //TODO: Find a way to initiate 2D-array of structs.
    PixelTest A[Size_X][Size_Y]={0};
    int i;
    int j;
    int x = 0;
    
    //Creates inital pixels as structs and sets their default values.
    for(i=0; i<Size_X;i++) {
        for(j=0; j<Size_Y; j++) {
            struct PixelTest A[i][j] t = {x,u,j,5,#FFFFFF,0};
            t.id = x;
            x++
        }
    }
    
    //Get examples
    
    //Find Struct by coordinate
    function GetPixelByCord(uint256 _x, uint256 _y) returns (struct p) {
        for(int i = 0; i <Size_X; i++) {
            for(int j = 0; j <Size_Y; j++) {
                if(A[i][j] == A[_x][_y]) {
                    return A[i][j];
                }
            }
        }
    }
    
    //Find Struct by id
    function GetPixelById(uint256 _id) returns (struct p) {
        for(int i = 0; i <Size_X; i++) {
            for(int j = 0; j <Size_Y; j++) {
                if(A[i][j].id == _id) {
                    return A[i][j];
                }
            }
        }
    }
    
    //Get color
    function GetColor(uint256 _x, uint256 _y) public view returns (bytes32[] color) {
        return A[_x,_y].color;
    }
    //Get count
    function GetCount(uint256 _x, uint256 _y) public view returns (uint256 count) {
        return A[_x,_y].count;
    }
    //Get cost
    function GetPixelPrice(uint256 _x, uint256 _y) public view returns (uint256 cost) {
        return GetPrice(A[_x][_y].start,A[_x,_y].count);
    }
    //Get cost pure
    function GetPrice(uint256 _start, uint256 _count) pure returns (uint256 _price) {
        return _start*(_count*1);
    }
    
    
    //Set examples
    
    //Set cost
    function SetC(uint256 _x, uint256 _y, bytes32[] _c) {
        A[_x,_y].c = _c;
    }
    function SetOwner(address _sender, uint _x, uint _y) {
        A[_x, _y].owner = _sender;
    }
    function IncrementCounter(uint256 _x, uint256 _y) {
        A[_x,_y].count = A[_x,_y].count.add(1);
    }
    function SetHexColor(uint256 _x, uint256 _y, bytes32[] _color) {
        A[_x,_y].color = _color;
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
    
    function getTransfer(address _to, uint256 _value, uint256 _id, string _hex) public returns (bool success) {
        require(transfer(_to,_value)); 
            setColor(_id,_hex);
            increaseCost(_id);
            return true;
    }
    
    function increaseCost(uint256 i) public view {
        getContract(i).addpixelpurchasecounter();
    }

    function allowance(address _owner, address _spender) public constant returns (uint256 remaining) {
         return allowed[_owner][_spender];
    }
    
    //Add initial empty pixels on contract start.
    function Canvas() public {
       
    }
    
    event Transfer(address indexed _from, address indexed _to, uint256 _value);
    event Approval(address indexed _owner, address indexed _spender, uint256 _value);
}
