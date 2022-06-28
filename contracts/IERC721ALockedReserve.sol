// SPDX-License-Identifier: MIT
// ERC71A with Locked Reserve

pragma solidity ^0.8.4;

interface IERC721ALockedReserve {
    /**
     * The caller must own corresponding token from locked reserve contract
     */
    error NotQualifiedForUnlock();
}
