pragma solidity >= 0.5.0;
import {ECDSA} from "./ECDSA.sol";

contract ECRecover {
    mapping (address => uint) nonces;

    function recoverSigner(bytes32 _hash, bytes memory _signature) public pure returns (address) {
        bytes32 ethSignedMessageHash = ECDSA.toEthSignedMessageHash(_hash);
        return ECDSA.recover(ethSignedMessageHash, _signature);
    }

    function validateNonceForSigner(address _signer, uint _nonce) internal {
        require(_nonce == nonces[_signer], "Invalid nonce");
        nonces[_signer]++;
    }

}