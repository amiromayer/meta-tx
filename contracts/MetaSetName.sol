pragma solidity >= 0.5.0;
import {ECRecover} from "./ECRecover.sol";

contract MetaSetName is ECRecover {

    mapping (address => string) public names;

    function setName(string memory _name) public {
        names[msg.sender] = _name;
    }

    //Function to set name on behalf of signer
    function metaSetName(bytes memory _signature, string memory _name, uint _nonce) public {
        bytes32 messageHash = hashMessage(_name, _nonce);
        address signer = recoverSigner(messageHash, _signature);
        validateNonceForSigner(signer, _nonce);
        names[signer] = _name;
        
    }

    function hashMessage(string memory _name, uint _nonce) 
        public 
        pure
        returns (bytes32 _messageHash)
    {
        _messageHash = keccak256(abi.encodePacked(_name, _nonce));
    }

}