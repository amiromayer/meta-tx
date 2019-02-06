pragma solidity ^0.5.0;
import "./utils/ECDSA.sol";

contract ECRecover {

    function recoverSigner(bytes32 _hash, bytes memory _signature) public view returns (address) {
        bytes32 ethSignedMessageHash = ECDSA.toEthSignedMessageHash(_hash);
        return ECDSA.recover(ethSignedMessageHash, _signature);
    }

}