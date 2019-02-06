pragma solidity ^0.5.0;
import "./ECRecover.sol";

contract MetaTransfer is ECRecover {

    mapping (address => uint) usedNonces;
    
    mapping (address => uint) public balances;
    
    function faucet() external {
        balances[msg.sender] += 1000;
    }
    
    function metaTransfer(bytes calldata _signature, address _to, uint _amount, uint _nonce) external {
        bytes32 messageHash = hashMessage(_to, _amount, _nonce);
        address signer = recoverSigner(messageHash, _signature);
        require(_nonce == usedNonces[signer], "Invalid nonce.");
        require(balances[signer] >= _amount, "Signer has insufficient funds.");
        balances[signer] -= _amount;
        balances[_to] += _amount;
        
    }

    // Signature methods

    function hashMessage(address _to, uint _amount, uint _nonce) 
        public 
        view
        returns (bytes32 _messageHash)
    {
        //Actually should also add contract address to avoid replay attacks
        _messageHash = keccak256(abi.encodePacked(_to, _amount, _nonce));
    }

}

//0x1f6e4cf20d61d6f81aaef8f324f7f31715a73ac41910e9054987c0d149bc653a32913f603ac11ee49adfffa06c71ffc09ea2df10b4eb2d7cb54111fb15bc9c191b, "0x8c495eb5ed845d4da6d0529c38a3a4e8bd568ebc", 42, 0