// SPDX-License-Identifier: MIT
// ERC721A Contracts v4.1.0
// Creators: Chiru Labs

pragma solidity ^0.8.4;

import '../ERC721APUMPA.sol';

contract ERC721AGasReporterMock is ERC721APUMPA {
    constructor(string memory name_, string memory symbol_)
    ERC721APUMPA(name_, symbol_, 0, address(0)) {}

    function safeMintOne(address to) public {
        _safeMint(to, 1);
    }

    function mintOne(address to) public {
        _mint(to, 1);
    }

    function safeMintTen(address to) public {
        _safeMint(to, 10);
    }

    function mintTen(address to) public {
        _mint(to, 10);
    }

    function transferTenAsc(address to) public {
        unchecked {
            transferFrom(msg.sender, to, 0);
            transferFrom(msg.sender, to, 1);
            transferFrom(msg.sender, to, 2);
            transferFrom(msg.sender, to, 3);
            transferFrom(msg.sender, to, 4);
            transferFrom(msg.sender, to, 5);
            transferFrom(msg.sender, to, 6);
            transferFrom(msg.sender, to, 7);
            transferFrom(msg.sender, to, 8);
            transferFrom(msg.sender, to, 9);
        }
    }

    function transferTenDesc(address to) public {
        unchecked {
            transferFrom(msg.sender, to, 9);
            transferFrom(msg.sender, to, 8);
            transferFrom(msg.sender, to, 7);
            transferFrom(msg.sender, to, 6);
            transferFrom(msg.sender, to, 5);
            transferFrom(msg.sender, to, 4);
            transferFrom(msg.sender, to, 3);
            transferFrom(msg.sender, to, 2);
            transferFrom(msg.sender, to, 1);
            transferFrom(msg.sender, to, 0);
        }
    }

    function transferTenAvg(address to) public {
        unchecked {
            transferFrom(msg.sender, to, 4);
            transferFrom(msg.sender, to, 5);
            transferFrom(msg.sender, to, 3);
            transferFrom(msg.sender, to, 6);
            transferFrom(msg.sender, to, 2);
            transferFrom(msg.sender, to, 7);
            transferFrom(msg.sender, to, 1);
            transferFrom(msg.sender, to, 8);
            transferFrom(msg.sender, to, 0);
            transferFrom(msg.sender, to, 9);
        }
    }
}
