// SPDX-License-Identifier: MIT
// ERC71A with Locked Reserve

pragma solidity ^0.8.4;

interface IERC721ALockedReserve {
    /**
     * Token must be in the range of reserved locked tokens
     */
    error LockedReserveMintTokenOutOfRange();

    /**
     * The caller must own corresponding token from locked reserve contract
     */
    error LockedReserveMintNotLockTokenHolder();

    /**
     * @dev Mint a token from locked reserve
     */
    function lockedReserveMint(address to, uint256 tokenId) external;
}
