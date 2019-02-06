//Users ethers.js
const ethers = require("ethers");
const Wallet = ethers.Wallet;
const utils = ethers.utils;

let mnemonic =
  "blur depend exhibit cliff film govern toward type embrace fine latin hotel";

let wallet = ethers.Wallet.fromMnemonic(mnemonic);
console.log("Wallet address:", wallet.address);

console.log("Private key:", wallet.privateKey);

let to = "0x8c495eb5ed845d4da6d0529c38a3a4e8bd568ebc";
let amount = 42;
let nonce = 0;

let msgHash = utils.solidityKeccak256(
  ["address", "uint256", "uint256"],
  [to, amount, nonce]
);
console.log("Message hash:", msgHash);

let hashToSign = utils.arrayify(msgHash);

let signature = wallet.signMessage(hashToSign);
console.log("Signature", signature);

let signer = Wallet.verifyMessage(hashToSign, signature);
console.log("Signing address:", signer);
