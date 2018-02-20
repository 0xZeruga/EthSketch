pragma solidity ^0.4.19;	

import "./ERC20.sol"; 
import "./SafeMath.sol";

contract Pixel is IERC20 {

    function Pixel(uint256 Cost, uint256 Times_Purchased, uint256 STARTCOST, string HexColorString, uint256 xPos, uint256 yPos ) {
        Cost = cost;
        Times_Purchased = times_Purchased;
        STARTCOST = startprice;
        HexColorString = colorHex;
        xPos = x_pos;
        yPos = y_pos;
    }
    
    using SafeMath for uint256;
    
    //Positions
    uint public x_pos;
    uint public y_pos;
    
    //Color default to white
    string public colorHex = "#ffffff";
    
    //Inital price
    uint256 public startprice = 5;
    
    //Times pixel has been purchased
    uint256 public times_Purchased = 0;
    
    //The current price of pixel
    uint256 public cost = getcost(startprice,times_Purchased);

    //Get the Cost
    function getcost(uint _startprice, uint256 _times) public returns(uint cost) {
        return _startprice*(_times+1);
    }

    //Safely increments counter
    function addpixelpurchasecounter(uint256 _times) returns (uint times_Purchased) {
        return _times.add(1);
    }
    
    //Returns hex color
    function setcolorhex(Pixel _pixel, string _hex) returns (string hex_Color) {
        _pixel.colorHex = _hex;
        return _hex;
    }
    
    function setX(Pixel _pixel, uint256 x) returns (uint256 xpos) {
        _pixel.xpos = x;
        return x;
    }
    function setY(Pixel _pixel, uint256 y) returns (uint256 ypos) {
        _pixel.y_pos = y;
        return y;
    }
    function getCost(Pixel _pixel) returns (uint256 cost) {
        return _pixel.cost;
    }
}

contract Canvas {

    using SafeMath for uint256;
    Pixel[] public PixelArray; 

    struct Pixel {
        uint256 Cost;
        uint256 Times_Purchased;
        uint256 STARTCOST; //In wei
        string HexColorString;
        uint256 xPos;
        uint256 yPos;
    }
    
    address[] newContracts;
    
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
            p_Contracts[i].set_X(i);
            for (uint j = 0; j < p_Contracts.length; j++) {
                p_Contracts[j].set_Y(j);
            }
        } 
    }

    //Get name of index i
    function getName (uint i) {
        Pixel con = Pixel(newContracts[i]);
        Names[i] = con.Name();
    }
    //Get Xpos of index i
    function getXpos (uint i) {
        Pixel con = Pixel(newContracts[i]);
        X_List[i] = con.x_pos();
    }
    //Get Ypos of index i
    function getYpos (uint i) {
        Pixel con = Pixel(newContracts[i]);
        Y_List[i] = con.y_pos();
    }
    //Set Xpos and Ypos
    function setPos(uint i, uint256 x, uint256 y) {
        Pixel con = Pixel(newContracts[i]);
        con.set_X(con, x);
        con.set_Y(con, y);
    }
    //Set Color
    function setColor(uint i, string _hex) {
        Pixel con = Pixel(newContracts[i]);
        con.set_color_hex(con,_hex);
    }
    //Get cost
    function getCost(uint i) returns (uint256 cost) {
        Pixel con = Pixel(newContracts[i]);
        return con.get_Cost(con); 
    }
    function getPos(uint i) returns (uint256 xpos) {
        Pixel con = Pixel(newContracts[i]);
        return con.x_pos;
    }

    function Canvas() {
        max_x = 256;
        max_y = 256;
    }
}
