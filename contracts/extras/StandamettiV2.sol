// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@1001-digital/erc721-extensions/contracts/RandomlyAssigned.sol";

interface IPumpaOwnerCheck {
    function ownerOf(uint256 tokenId) external view returns (address owner);
}

contract Standametti is ERC721, Ownable, RandomlyAssigned {
    using Strings for uint256;

    uint256 public cost = 0.02 ether;
    uint256 internal startTokenId = 1;
    uint256 internal maxPumpaReservedSupply = 300;
    uint256 public maxTotalSupply = 4500;
    uint256 public publicSupplyLeft = maxTotalSupply - maxPumpaReservedSupply;
    uint256 internal maxPublicMintAmount = 10;
    string internal baseURI =
        "https://ipfs.io/ipfs/QmZd2RwnapYAtETyyhVGTS9d8rDBvRPE3nvr573ed1QMcX/";

    // Allow OG Pumpametti holders to mint for free
    address internal pumpaAddress = 0x09646c5c1e42ede848A57d6542382C32f2877164;
    IPumpaOwnerCheck internal pumpaContract = IPumpaOwnerCheck(pumpaAddress);

    constructor()
        ERC721("Standametti", "Standa")
        RandomlyAssigned(
            // Total number of tokens to be randomly assigned
            maxTotalSupply - maxPumpaReservedSupply,
            // Id of first randomly assigned token
            startTokenId + maxPumpaReservedSupply
        )
    {}

    function _baseURI() internal view virtual override returns (string memory) {
        return baseURI;
    }

    function PumpaFirstChoiceVIPMint(uint256 pumpaId) public payable {
        require(pumpaId >= startTokenId);
        require(pumpaId <= startTokenId + maxPumpaReservedSupply);
        require(
            pumpaContract.ownerOf(pumpaId) == msg.sender,
            "Not the owner of this pumpametti"
        );

        _safeMint(msg.sender, pumpaId);
    }

    function publicMint(uint256 _mintAmount) public payable {
        require(_mintAmount > 0 && _mintAmount <= maxPublicMintAmount);
        require(
            tx.origin == msg.sender,
            "CANNOT MINT THROUGH A CUSTOM CONTRACT"
        );
        require(totalSupply() + _mintAmount <= maxTotalSupply);
        require(
            publicSupplyLeft - _mintAmount >= 0,
            "No more public supply left"
        );
        require(msg.value >= cost * _mintAmount);
        publicSupplyLeft = publicSupplyLeft - _mintAmount;

        for (uint256 i = 0; i < _mintAmount; ++i) {
            uint256 tokenId = nextToken();
            if (totalSupply() < maxTotalSupply) {
                _safeMint(_msgSender(), tokenId);
            }
        }
    }

    function tokenURI(uint256 tokenId)
        public
        view
        virtual
        override
        returns (string memory)
    {
        require(
            _exists(tokenId),
            "ERC721Metadata: URI query for nonexistent token"
        );

        string memory currentBaseURI = _baseURI();
        return
            bytes(currentBaseURI).length > 0
                ? string(
                    abi.encodePacked(
                        currentBaseURI,
                        tokenId.toString(),
                        ".json"
                    )
                )
                : "";
    }

    function withdraw() public payable onlyOwner {
        require(payable(msg.sender).send(address(this).balance));
    }
}
