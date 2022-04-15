// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

// name your contract and set the storage type (inherited from OpenZeppelin)
contract AnkrPolygonNFT is ERC721URIStorage {

// set up our counters
    using Counters for Counters.Counter;
// use counter to store tokenIds
    Counters.Counter private _tokenIds;

// pass arguments for name and symbol
    constructor() ERC721("AnkrPolygonNFT", "ANKRPG") {}

// create mint function with argument for tokenURI which will be a JSON file on IPFS
    function mint(string memory tokenURI) public returns (uint256){

// use token increment function to count up
        _tokenIds.increment();

// fetch current tokenId
        uint256 newItemId = _tokenIds.current();

// safeMint requires address of who is interacting with contract (msg.sender) and tokenId from the line above
        _safeMint(msg.sender, newItemId);

// set newItemId and tokenURI
        _setTokenURI(newItemId, tokenURI);

// return newItemId
        return newItemId;
    }
}