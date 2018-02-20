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
    uint256 public cost;

    //Get the Cost
    function get_cost(uint _startprice, uint256 _times) public returns(uint cost) {
        return _startprice*(_times+1);
    }

    //Safely increments counter
    function add_pixel_purchase_counter(uint256 _times) returns (uint times_Purchased) {
        return _times.add(1);
    }
    
    //Returns hex color
    function set_color_hex(Pixel _pixel, string _hex) returns (string hex_Color) {
        return _hex;
    }
    
    function set_X(Pixel _pixel, uint256 x) returns (uint256 xpos) {
        return x;
    }
    function set_Y(Pixel _pixel, uint256 y) {
        _pixel.y_pos = y;
    }
    function get_Cost(Pixel _pixel) returns (uint256 cost) {
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
    
    Pixel MyPixel = Pixel({Cost:0, Times_Purchased:0, STARTCOST:500, HexColorString:"#ffffff", xPos:0, yPos:0});
    
    
    //Assign x and y for each pixel in array
    function Initialize(Pixel[] p_Array) {
        for(uint i = 0; i < p_Array.length; i++) {
            p_Array[i].xPos = i;
            for(uint j = 0; j < p_Array.length; j++) {
                p_Array[j].yPos = j;
            }
        }    
    }
    

    bytes32[] Names;
    uint256[] X_List;
    uint256[] Y_List;
    address[] newContracts;
    
    //Add new pixel with address
    function createContract (uint256 Cost, Times_Purchased,STARTCOST,HexColorString,Xpos,Ypos) {
        address newContract = Pixel(Cost, Times_Purchased, STARTCOST,HexColorString,Xpos,Ypos);
        //Add contract to list of contracts
        newContracts.push(newContract);
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

    uint256 public max_x;
    uint256 public max_y;

    function Canvas() {
        max_x = 256;
        max_y = 256;
    }
}
