pragma solidity ^0.4.19;	

import "./ERC20.sol"; 
import "./SafeMath.sol";

contract Pixel is IERC20 {

    function Pixel(bytes32 name) {
        Name = name;
    }
    //Positions
    uint public x_pos;
    uint public y_pos;
    
    //Name of owner
    bytes32 public Name;
    
    //Color default to white
    string public colorHex = "#ffffff";
    
    //Inital price
    uint256 public startprice = 5;
    
    //Times pixel has been purchased
    uint256 public times_Purchased = 0;
    
    //The current price of pixel
    uint256 public cost;

    function get_cost(uint _startprice, uint _times, Pixel _pixel) public returns(uint cost) {
        return _pixel.cost = _startprice*(_times+1);
    }

    function add_pixel_purchase_counter(uint _times, Pixel _pixel) returns(uint times_Purchased) {
        return _pixel.timesPurchased.add(1);
    }
    
    function set_color_hex(Pixel _pixel, string _hex) {
        _pixel.colorHex = _hex;
    }
    function set_X(Pixel _pixel, uint256 x) {
        _pixel.x_pos = x;
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

    bytes32[] Names;
    uint256[] X_List;
    uint256[] Y_List;
    address[] newContracts;
    
    //Add new pixel with address
    function createContract (bytes32 name) {
        address newContract = Pixel(name);
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

    bool public isExpandable;

    function Canvas() {
        max_x = 256;
        max_y = 256;
    }
}
