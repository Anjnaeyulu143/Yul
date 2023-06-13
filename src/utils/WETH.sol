// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract WETH {

    // deposit - X
    // withdraw - X
    // transfer - X
    // transferFrom - X
    // approve - X
    // totalSupply - X
    // check allowance - X
    // balanceOf - X

    string public name = "WETH";
    string public symbol = "wETH";
    uint256 public decimals = 18;

    event log_deposit(address indexed _from, uint256 _amount);
    event log_withdraw(address indexed _to, uint256 _amount);
    event log_transfer(address indexed from, address indexed _to, uint256  _amount);
    event log_transferFrom(address indexed _from, address indexed _to, uint256 _amount);
    event log_approval(address indexed _owner , address indexed _spender, uint256 _amount);

    mapping(address => uint256) public balances;
    mapping(address => mapping(address => uint256)) public allowances;

    receive() external payable{
        deposit();
    }

    function deposit() public payable{
        require(msg.value != 0,"amount is not equal to zero");
        balances[msg.sender] += msg.value;

        emit log_deposit(msg.sender, msg.value);
    }

    function withdraw(uint256 _amount) external {

        // check
        require(balances[msg.sender] >= _amount,"you don't have enough money");

        // effect
        balances[msg.sender] -= _amount;

        // interact
        (bool success,) = payable(msg.sender).call{value:_amount}("");
        require(success,"transfer failed");

        emit log_withdraw(msg.sender, _amount);

    }

    function totalSupply() external view returns(uint256) {
        return address(this).balance;
    }

    function approve(address _to, uint256 _amount) external returns(bool) {
        uint256 _toBalance = balances[msg.sender];
        require(_to != address(0),"to address != 0");
        require(_toBalance >= _amount, "Not enough money");

        allowances[msg.sender][_to] = _amount;

        emit log_approval(msg.sender, _to, _amount);

        return true;
    }

    function allowance(address _owner, address _spender) public view returns(uint256) {
        return allowances[_owner][_spender];
    }


    function transfer(address _to, uint256 _amount) external returns(bool) {
        require(_to != address(0),"address != 0");
        require(balances[msg.sender] >= _amount,"don't have enough money");

        bool isTransfer = _transfer(msg.sender,_to,_amount);
        return isTransfer;
    }

    function _transfer(address _from,address _to, uint256 _amount) private returns(bool){
        balances[_from] -= _amount;
        balances[_to] += _amount;

        emit log_transfer(_from,_to, _amount);

        return true;
    }

    function transferFrom(address _from, address _to, uint256 _amount) external returns(bool){
        require(_to != address(0),"address != 0");
        require(_from != msg.sender,"you can't able to transfer yourself");
        uint256 currentAllowance = allowance(_from, msg.sender);

        require(currentAllowance >= _amount,"no enough money");

        allowances[_from][msg.sender] -= _amount;
        
        bool isTransfer = _transfer(_from,_to, _amount);

        return isTransfer;
    }

    function balanceOf(address _owner) external view returns(uint256){
        return balances[_owner];
    }

}