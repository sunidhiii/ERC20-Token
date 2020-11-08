pragma solidity ^0.4.2;

contract ERC20Token {
    
    string  public name = "VideoWiki Token";
    string  public symbol = "WIKICOIN";
    //string  public standard = "VideoWiki Token v1.0";
    uint256 public totalSupply;

    //triggers when tokens are transferred, including zero value transfers. 
    event Transfer(
        address indexed _from,
        address indexed _to,
        uint256 _value
    );

    //triggers on any successful call to approve(address _spender, uint256 _value).
    event Approval(
        address indexed _owner,
        address indexed _spender,
        uint256 _value
    );

    //creates a hashmap to assign amount as value to it's key address.
    //Returns the account balance of another account with address _owner.
    mapping(address => uint256) public balanceOf;
    
    //creates a nested map of address A approving address B to send specific number of tokens.
    //Returns the amount which _spender is still allowed to withdraw from _owner.
    mapping(address => mapping(address => uint256)) public allowance;

    //for initializing the totalSupply and balanceOf amounts.
    constructor () public {
        balanceOf[msg.sender] = 100000;
        totalSupply = 100000;
    }

    //Transfers _value amount of tokens to address _to.
    function transfer(address _to, uint256 _value) public returns (bool success) {
        
        //exception if account doesn't have enough balance.
        require(balanceOf[msg.sender] >= _value);

        //update the balance of sender and receiver.
        balanceOf[msg.sender] -= _value;
        balanceOf[_to] += _value;

        emit Transfer(msg.sender, _to, _value);

        return true;
    }

    //Allows _spender to withdraw from your account multiple times, up to the _value amount.
    function approve(address _spender, uint256 _value) public returns (bool success) {
        
        //update the allowance.
        allowance[msg.sender][_spender] = _value;

        emit Approval(msg.sender, _spender, _value);

        return true;
    }

    //Transfers _value amount of tokens from address _from after being approved to address _to.
    function transferFrom(address _from, address _to, uint256 _value) public returns (bool success) {
        
        //sender address has enough tokens.
        require(_value <= balanceOf[_from]);
        
        //sender address has big enough allowance.
        require(_value <= allowance[_from][msg.sender]);

        //update the balance of sender and receiver.
        balanceOf[_from] -= _value;
        balanceOf[_to] += _value;

        //update the allowance.
        allowance[_from][msg.sender] -= _value;

        emit Transfer(_from, _to, _value);

        return true;
    }
}