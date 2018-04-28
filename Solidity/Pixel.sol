pragma solidity ^0.4.20;

contract Owner {

    address private superuseraddress;

    function isowned() public {
        superuseraddress = msg.sender;
    }

    modifier superuser() {
        require(superuseraddress == msg.sender);
        _;
    }

    function balanceOf(address tokenOwner) public constant returns (uint balance);
    function allowance(address tokenOwner, address spender) public constant returns (uint remaining);
    function transfer(address to, uint tokens) public returns (bool success);
    function approve(address spender, uint tokens) public returns (bool success);
    function transferFrom(address from, address to, uint tokens) public returns (bool success);

    event Transfer(address indexed from, address indexed to, uint tokens);
    event Approval(address indexed tokenOwner, address indexed spender, uint tokens);
}

//TODO: Find a way to make sure a pixel cant be overwritten twice the same block;

contract Pixelhandler is Owner {
    
    struct Pixel {
        uint256 x;
        uint256 y;
        bytes16 color;
        address pixelowner;
    }

    mapping(address => uint256) balances;
    mapping(address => mapping (address => uint256)) allowed;

    function balanceOf(address _address) public constant returns (uint balance) {
        return balances[_address];
    }

    event pixelinfo(
        uint256 x,
        uint256 y,
        bytes16 color,
        address pixelowner
    );

    function CleanSlate(address _a) public superuser returns (uint) {
        SetPixelColor(0, 0, "", _a);
    }

    mapping(address => Pixel) pixels;

    address[] public pixelOwners;

    function transfer(address to, uint amount) public returns (bool success) {
        balances[msg.sender] = balances[msg.sender] -= amount;
        balances[to] = balances[to] -= amount;
        emit Transfer(msg.sender, to, amount);
        return true;
    }

    function transferFrom(address from, address to, uint amount) public returns (bool success) {
        balances[from] = balances[from] -= amount;
        allowed[from][msg.sender] = allowed[from][msg.sender]-=amount;
        balances[to] = balances[to] += amount;
        Transfer(from, to, amount);
        return true;
    }

    function approve(address spender, uint amount) public returns (bool success) {
        allowed[msg.sender][spender] = amount;
        Approval(msg.sender, spender, amount);
        return true;
    }

    /*
    Input parameters for this function is:
    address = caller of the function.
    x & y = position parsed through Javascrip canvas
    color = from color picked -> parsed to bytes16 from hex
    */
    function setPixelColor(uint256 _x, uint256 _y, bytes16 _color, address _address) public superuser {
        var pixel = pixels[_address];
        pixel.pixelowner = _address;
        pixel.x = _x;
        pixel.y = _y;
        pixel.color = _color;

        pixelOwners.push(_address)-1;
        emit pixelinfo(_x, _y, _color, _address);
    }

    //Returns all addresses that currently owns pixels.
    function getPixelOwners() public view returns (address[]) {
        return pixelOwners;
    }

    //Returns data from about the pixel at a certain address
    function getCustomer(address _address) public view returns (uint, uint, bytes16) {
        return (pixels[_address].x, pixels[_address].y, pixels[_address].color);
    }

    function getBlockhash(uint _blocknr) public view returns (bytes32) {
        return block.blockhash(_blocknr);
    }
}
