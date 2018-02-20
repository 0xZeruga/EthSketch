pragma solidity ^0.4.19;	

import "./ERC20.sol"; 
import "./SafeMath.sol";

contract Pixel is IERC20() {

/*
    function Pixel(uint256 Cost, uint256 Times_Purchased, uint256 STARTCOST, string HexColorString, uint256 xPos, uint256 yPos ) {
        Cost = cost;
        Times_Purchased = times_Purchased;
        STARTCOST = startprice;
        HexColorString = colorHex;
        xPos = x_pos;
        yPos = y_pos;
    }
    */
    uint256 public Id;
    
    function Pixel(uint256 id) public {
        Id = id;}
    
    using SafeMath for uint256;
    
    //id
    
    
    //Positions
    uint public x_pos;
    uint public y_pos;
    
    //Color default to white
    string public colorHex = "#ffffff";
    
    //Inital price
    uint256 public startprice = 5;
    
    //Times pixel has been purchased
    uint256 public times_Purchased = 0;
    
    //Get the Cost
    function getcost(uint _startprice, uint256 _times) public returns(uint cost) {
        return _startprice*(_times+1);
        
    }
    //The current price of pixel
    uint256 public cost = getcost(startprice,times_Purchased);
    
    //The current pixel owner
    address public pixelowner;

  

    //Safely increments counter
    function addpixelpurchasecounter(uint256 _times) returns (uint times_Purchased) {
        return _times.add(1);
    }
    
    //Returns hex color
    function setcolorhex(Pixel _pixel, string _hex) returns (string hex_Color) {
        colorHex = _hex;
        return _hex;
    }
    
    function setX(uint256 x) {
        x_pos = x;
    }
    function setY(uint256 y) {
        y_pos = y;
    }
    function getX() returns (uint256 xpos) {
        return x_pos;
    }
    function getY() returns (uint256 ypos) {
        return y_pos;
    }
    function getCost() returns (uint256 cost) {
        return cost;
    }
}

contract Canvas {

    //Address to which the funds will be sent
    address public owner;

    mapping(address => uint256) balances;
    mapping(address => mapping(address =>uint256)) allowed;

    using SafeMath for uint256;
    Pixel[] public PixelArray; 
    
    address[] newContracts;
    
    //This checks whether Ether has been paid to the address
    function () payable {
        UpdateColor();
    }
    //Automatically send tokens.
    function UpdateColor() payable {
        require(msg.value > 0);
        
        owner.transfer(msg.value);
    }
    
     function balanceOf(address _owner) constant returns (uint256 balance) {
        return balances[_owner];
    }
    
    function approve(address _spender, uint256 _value) returns (bool success) {
        allowed[msg.sender][_spender] = _value;
        Approval(msg.sender, _spender, _value);
        return true;
    }
    
    //Spend from sender funds.
    //This recieves pixel.Cost at index i.
    function transfer(address _to, uint256 _value) returns (bool success) {
        require(balances[msg.sender] >= _value && _value > 0);
        balances[msg.sender].sub(_value);
        balances[_to].add(_value);
        Transfer(msg.sender, _to, _value);
        return true;
    }
    
    function getTransfer(address _to, uint256 _value, uint256 _id, string _hex) returns (bool success) {
        if(transfer(_to,_value)) {
            setColor(_id,_hex);
        }
    }

    function allowance(address _owner, address _spender) constant returns (uint256 remaining) {
         return allowed[_owner][_spender];
    }
    /*
    //Create Pixel Contract
    //i and j values sets x and y.
    function createContract (uint256 cost, uint256 Times_Purchased,uint256 STARTCOST, string HexColorString,uint256 Xpos, uint256 Ypos) {
        for (uint i = 0; i < 100; i++) {
            for (uint j = 0; j < 100; j++) {
                address newContract = Pixel(cost, Times_Purchased, STARTCOST,HexColorString,i,j);
                //Add contract to list of contracts
                newContracts.push(newContract);
            }
            
        }
    }

    //Loop every index and set x and y values for each contract.
    //TODO: This might be unnecessary. 
    function LoopContract(address[] p_Contracts) {
        for (uint i = 0; i < p_Contracts.length; i++) {
            p_Contracts[i].setX(i);
            for (uint j = 0; j < p_Contracts.length; j++) {
                p_Contracts[j].setY(j);
            }
        } 
    }
    */
    
    //Use this option if scrap x/y and instead use index.
     uint256 constant PIXELAMOUNT = 10000;
    
    //Add one empty pixel contract
    function AddEmptyPixel(uint256 id) {
                address newContract =  Pixel(id);
                //Add contract to list of contracts
                newContracts.push(newContract);
    }
    
    //Populate pixel contract with PIXELAMOUNT
    function AddEmptyPixels(uint256 amount) {
        for (uint i = 0; i < PIXELAMOUNT; i++) {
            AddEmptyPixels(i);
        }
    }
    
    Pixel con = Pixel(newContracts[0]);
    
    //Needs to be assigned once accessed.
    uint256 p = con.Id();

    //Set Xpos and Ypos
    function setPos(uint i, uint256 x, uint256 y) public {
        getContract(i).setX(x);
        getContract(i).setY(y);
    }
    //Set Color to hex at index i
    function setColor(uint i, string _hex) public {
        getContract(i).setcolorhex(con,_hex);
    }
    //Get cost of pixel at index i
    //This should be called from Front once the pixel is hovered and Metamask transaction started.
    function getCost(uint i) public returns (uint256 cost) {
       return getContract(i).getCost();
    }
    
    function getContract(uint i) view returns (Pixel chosenPixel) {
        return Pixel(newContracts[i]);
    }
    
    //Might remove positions
    function getxpos(uint i) public returns (uint256 xpos) {
        return getContract(i).getX();
    }
    function getypos(uint i) public returns (uint256 xpos) {
        return getContract(i).getY();
    }

    function Canvas() public {

    }
    
    event Transfer(address indexed _from, address indexed _to, uint256 _value);
    event Approval(address indexed _owner, address indexed _spender, uint256 _value);
}
