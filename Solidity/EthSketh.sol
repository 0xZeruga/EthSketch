pragma solidity ^0.4.19;	

import "./ERC20.sol"; 
import "./SafeMath.sol";

contract Pixel is IERC20() {

    uint256 public Id;
    
    //Color default to white
    string public Colorhex = "#ffffff";
    
    //Inital price
    uint256 public StartPrice = 5;
    
    //Times pixel has been purchased
    uint256 public TimesPurchased = 0;
    
    function Pixel(uint256 id, string colorhex, uint256 startprice, uint256 timespurchased) public {
        Id = id;
        Colorhex = colorhex;
        StartPrice = startprice;
        TimesPurchased = timespurchased;
    }
    
    using SafeMath for uint256;
    
    //Get the Cost
    function getCost(uint _startprice, uint256 _times) public pure returns(uint cost) {
        return _startprice*(_times+1);
    }
    //The current price of pixel
    uint256 public cost = getCost(StartPrice,TimesPurchased);
    
    //The current pixel owner
    address public pixelowner;

    //Safely increments counter
    function addpixelpurchasecounter() public view {
       TimesPurchased.add(1);
    }
    
    //Returns hex color
    function setcolorhex(string _hex) public {
        Colorhex = _hex;
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
    
    //Use these somehow?
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
    
    uint256 constant PIXELAMOUNT = 10000;
    
    //Add one empty pixel contract
    function AddEmptyPixel(uint256 id) private {
                address newContract =  Pixel(id);
                //Add contract to list of contracts
                newContracts.push(newContract);
    }
    
    //Populate pixel contract with PIXELAMOUNT
    function AddEmptyPixels(uint256 amount) private {
        for (uint i = 0; i < amount; i++) {
            AddEmptyPixels(i);
        }
    }

    //Set Color to hex at index i
    function setColor(uint i, string _hex) public {
        getContract(i).setcolorhex(_hex);
    }
    
    //Get cost of pixel at index i
    //This should be called from Front once the pixel is hovered and Metamask transaction started.
    function getCost(uint i) public view returns (uint256 cost) {
       return getContract(i).cost();
    }
    
    function getContract(uint i) public view returns (Pixel chosenPixel) {
        return Pixel(newContracts[i]);
    }
    
    //Add initial empty pixels on contract start.
    function Canvas() public {
        AddEmptyPixels(PIXELAMOUNT);
    }
    
    event Transfer(address indexed _from, address indexed _to, uint256 _value);
    event Approval(address indexed _owner, address indexed _spender, uint256 _value);
}
