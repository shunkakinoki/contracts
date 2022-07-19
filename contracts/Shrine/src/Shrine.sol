// SPDX-License-Identifier: AGPL-3.0

pragma solidity ^0.8.13;

/**


           .o.                    .                            .o8
          .888.                 .o8                           "888
         .8"888.      .oooo.o .o888oo oooo d8b  .ooooo.   .oooo888  oooo d8b  .ooooo.  oo.ooooo.
        .8' `888.    d88(  "8   888   `888""8P d88' `88b d88' `888  `888""8P d88' `88b  888' `88b
       .88ooo8888.   `"Y88b.    888    888     888   888 888   888   888     888   888  888   888
      .8'     `888.  o.  )88b   888 .  888     888   888 888   888   888     888   888  888   888
     o88o     o8888o 8""888P'   "888" d888b    `Y8bod8P' `Y8bod88P" d888b    `Y8bod8P'  888bod8P'
                                                                                        888
                                                                                       o888o


 */

import { MerkleProof } from "@openzeppelin/contracts/utils/cryptography/MerkleProof.sol";
import { ERC20 } from "solmate/src/tokens/ERC20.sol";
import { SafeTransferLib } from "solmate/src/utils/SafeTransferLib.sol";

import { Ownable } from "./lib/Ownable.sol";
import { ReentrancyGuard } from "./lib/ReentrancyGuard.sol";

/// @title Shrine
/// @author zefram.eth
/// @notice A Shrine maintains a list of Champions with individual weights (shares), and anyone could
/// offer any ERC-20 tokens to the Shrine in order to distribute them to the Champions proportional to their
/// shares. A Champion transfer their right to claim all future tokens offered to
/// the Champion to another address.
contract Shrine is Ownable, ReentrancyGuard {
    /// -----------------------------------------------------------------------
    /// Errors
    /// -----------------------------------------------------------------------

    error Shrine_AlreadyInitialized();
    error Shrine_InputArraysLengthMismatch();
    error Shrine_NotAuthorized();
    error Shrine_InvalidMerkleProof();
    error Shrine_LedgerZeroTotalShares();

    /// -----------------------------------------------------------------------
    /// Custom types
    /// -----------------------------------------------------------------------

    type Champion is address;
    type Version is uint256;

    /// -----------------------------------------------------------------------
    /// Library usage
    /// -----------------------------------------------------------------------

    using SafeTransferLib for ERC20;

    /// -----------------------------------------------------------------------
    /// Events
    /// -----------------------------------------------------------------------

    event Offer(address indexed sender, ERC20 indexed token, uint256 amount);
    event Claim(
        address recipient,
        Version indexed version,
        ERC20 indexed token,
        Champion indexed champion,
        uint256 claimedTokenAmount
    );
    event ClaimFromMetaShrine(Shrine indexed metaShrine);
    event TransferChampionStatus(Champion indexed champion, address recipient);
    event UpdateLedger(Version indexed newVersion, Ledger newLedger);
    event UpdateLedgerMetadata(
        Version indexed version,
        string newLedgerMetadataIPFSHash
    );

    /// -----------------------------------------------------------------------
    /// Structs
    /// -----------------------------------------------------------------------

    /// @param version The Merkle tree version
    /// @param token The ERC-20 token to be claimed
    /// @param champion The Champion address. If the Champion rights have been transferred, the tokens will be sent to its owner.
    /// @param shares The share amount of the Champion
    /// @param merkleProof The Merkle proof showing the Champion is part of this Shrine's Merkle tree
    struct ClaimInfo {
        Version version;
        ERC20 token;
        Champion champion;
        uint256 shares;
        bytes32[] merkleProof;
    }

    /// @param metaShrine The shrine to claim from
    /// @param version The Merkle tree version
    /// @param token The ERC-20 token to be claimed
    /// @param shares The share amount of the Champion
    /// @param merkleProof The Merkle proof showing the Champion is part of this Shrine's Merkle tree
    struct MetaShrineClaimInfo {
        Shrine metaShrine;
        Version version;
        ERC20 token;
        uint256 shares;
        bytes32[] merkleProof;
    }

    struct Ledger {
        bytes32 merkleRoot;
        uint256 totalShares;
    }

    /// -----------------------------------------------------------------------
    /// Storage variables
    /// -----------------------------------------------------------------------

    /// @notice The current version of the ledger, starting from 1
    Version public currentLedgerVersion;

    /// @notice version => ledger
    mapping(Version => Ledger) public ledgerOfVersion;

    /// @notice version => (token => (champion => claimedTokens))
    mapping(Version => mapping(ERC20 => mapping(Champion => uint256)))
        public claimedTokens;

    /// @notice version => (token => offeredTokens)
    mapping(Version => mapping(ERC20 => uint256)) public offeredTokens;

    /// @notice champion => address
    mapping(Champion => address) public championClaimRightOwner;

    /// -----------------------------------------------------------------------
    /// Initialization
    /// -----------------------------------------------------------------------

    /// @notice Initialize the Shrine contract.
    /// @param initialGuardian The Shrine's initial guardian, who controls the ledger
    /// @param initialLedger The Shrine's initial ledger with the distribution shares
    /// @param initialLedgerMetadataIPFSHash The IPFS hash of the initial metadata
    function initialize(
        address initialGuardian,
        Ledger calldata initialLedger,
        string calldata initialLedgerMetadataIPFSHash
    ) external {
        // we use currentLedgerVersion as a flag for whether the Shrine
        // has already been initialized
        if (Version.unwrap(currentLedgerVersion) != 0) {
            revert Shrine_AlreadyInitialized();
        }

        // 0 total shares makes no sense
        if (initialLedger.totalShares == 0)
            revert Shrine_LedgerZeroTotalShares();

        __ReentrancyGuard_init();
        __Ownable_init(initialGuardian);

        // the version number start at 1
        currentLedgerVersion = Version.wrap(1);
        ledgerOfVersion[Version.wrap(1)] = initialLedger;

        // emit event to let indexers pick up ledger & metadata IPFS hash
        emit UpdateLedger(Version.wrap(1), initialLedger);
        emit UpdateLedgerMetadata(
            Version.wrap(1),
            initialLedgerMetadataIPFSHash
        );
    }

    /// -----------------------------------------------------------------------
    /// User actions
    /// -----------------------------------------------------------------------

    /// @notice Offer ERC-20 tokens to the Shrine and distribute them to Champions proportional
    /// to their shares in the Shrine. Callable by anyone.
    /// @param token The ERC-20 token being offered to the Shrine
    /// @param amount The amount of tokens to offer
    function offer(ERC20 token, uint256 amount) external {
        // -------------------------------------------------------------------
        // State updates
        // -------------------------------------------------------------------

        // distribute tokens to Champions
        offeredTokens[currentLedgerVersion][token] += amount;

        // -------------------------------------------------------------------
        // Effects
        // -------------------------------------------------------------------

        // transfer tokens from sender
        token.safeTransferFrom(msg.sender, address(this), amount);

        emit Offer(msg.sender, token, amount);
    }

    /// @notice Offer multiple ERC-20 tokens to the Shrine and distribute them to Champions proportional
    /// to their shares in the Shrine. The input arrays must be of the same length. Callable by anyone.
    /// @param versionList The list of ledger versions to distribute to
    /// @param tokenList The list of ERC-20 tokens being offered to the Shrine
    /// @param amountList The list of amounts of tokens to offer
    function offerMultiple(
        Version[] calldata versionList,
        ERC20[] calldata tokenList,
        uint256[] calldata amountList
    ) external {
        // -------------------------------------------------------------------
        // Validation
        // -------------------------------------------------------------------

        if (
            versionList.length != tokenList.length ||
            versionList.length != amountList.length
        ) {
            revert Shrine_InputArraysLengthMismatch();
        }

        // -------------------------------------------------------------------
        // State updates
        // -------------------------------------------------------------------

        for (uint256 i = 0; i < versionList.length; i++) {
            // distribute tokens to Champions
            offeredTokens[versionList[i]][tokenList[i]] += amountList[i];
        }

        // -------------------------------------------------------------------
        // Effects
        // -------------------------------------------------------------------

        for (uint256 i = 0; i < versionList.length; i++) {
            // transfer tokens from sender
            tokenList[i].safeTransferFrom(
                msg.sender,
                address(this),
                amountList[i]
            );

            emit Offer(msg.sender, tokenList[i], amountList[i]);
        }
    }

    /// @notice A Champion or the owner of a Champion may call this to claim their share of the tokens offered to this Shrine.
    /// Requires a Merkle proof to prove that the Champion is part of this Shrine's Merkle tree.
    /// Only callable by the champion (if the right was never transferred) or the owner
    /// (that the original champion transferred their rights to)
    /// @param claimInfo The info of the claim
    /// @return claimedTokenAmount The amount of tokens claimed
    function claim(address recipient, ClaimInfo calldata claimInfo)
        external
        returns (uint256 claimedTokenAmount)
    {
        // -------------------------------------------------------------------
        // Validation
        // -------------------------------------------------------------------

        // verify sender auth
        _verifyChampionOwnership(claimInfo.champion);

        // verify Merkle proof that the champion is part of the Merkle tree
        _verifyMerkleProof(
            claimInfo.version,
            claimInfo.champion,
            claimInfo.shares,
            claimInfo.merkleProof
        );

        // compute claimable amount
        uint256 championClaimedTokens = claimedTokens[claimInfo.version][
            claimInfo.token
        ][claimInfo.champion];
        claimedTokenAmount = _computeClaimableTokenAmount(
            claimInfo.version,
            claimInfo.token,
            claimInfo.shares,
            championClaimedTokens
        );

        // -------------------------------------------------------------------
        // State updates
        // -------------------------------------------------------------------

        // record total tokens claimed by the champion
        claimedTokens[claimInfo.version][claimInfo.token][claimInfo.champion] =
            championClaimedTokens +
            claimedTokenAmount;

        // -------------------------------------------------------------------
        // Effects
        // -------------------------------------------------------------------

        // transfer tokens to the recipient
        claimInfo.token.safeTransfer(recipient, claimedTokenAmount);

        emit Claim(
            recipient,
            claimInfo.version,
            claimInfo.token,
            claimInfo.champion,
            claimedTokenAmount
        );
    }

    /// @notice A variant of {claim} that combines multiple claims into a single call.
    function claimMultiple(
        address recipient,
        ClaimInfo[] calldata claimInfoList
    ) external returns (uint256[] memory claimedTokenAmountList) {
        claimedTokenAmountList = new uint256[](claimInfoList.length);
        for (uint256 i = 0; i < claimInfoList.length; i++) {
            // -------------------------------------------------------------------
            // Validation
            // -------------------------------------------------------------------

            // verify sender auth
            _verifyChampionOwnership(claimInfoList[i].champion);

            // verify Merkle proof that the champion is part of the Merkle tree
            _verifyMerkleProof(
                claimInfoList[i].version,
                claimInfoList[i].champion,
                claimInfoList[i].shares,
                claimInfoList[i].merkleProof
            );

            // compute claimable amount
            uint256 championClaimedTokens = claimedTokens[
                claimInfoList[i].version
            ][claimInfoList[i].token][claimInfoList[i].champion];
            claimedTokenAmountList[i] = _computeClaimableTokenAmount(
                claimInfoList[i].version,
                claimInfoList[i].token,
                claimInfoList[i].shares,
                championClaimedTokens
            );

            // -------------------------------------------------------------------
            // State updates
            // -------------------------------------------------------------------

            // record total tokens claimed by the champion
            claimedTokens[claimInfoList[i].version][claimInfoList[i].token][
                claimInfoList[i].champion
            ] = championClaimedTokens + claimedTokenAmountList[i];
        }

        for (uint256 i = 0; i < claimInfoList.length; i++) {
            // -------------------------------------------------------------------
            // Effects
            // -------------------------------------------------------------------

            // transfer tokens to the recipient
            claimInfoList[i].token.safeTransfer(
                recipient,
                claimedTokenAmountList[i]
            );

            emit Claim(
                recipient,
                claimInfoList[i].version,
                claimInfoList[i].token,
                claimInfoList[i].champion,
                claimedTokenAmountList[i]
            );
        }
    }

    /// @notice A variant of {claim} that combines multiple claims for the same Champion & version into a single call.
    /// @dev This is more efficient than {claimMultiple} since it only checks Champion ownership & verifies Merkle proof once.
    function claimMultipleTokensForChampion(
        address recipient,
        Version version,
        ERC20[] calldata tokenList,
        Champion champion,
        uint256 shares,
        bytes32[] calldata merkleProof
    ) external returns (uint256[] memory claimedTokenAmountList) {
        // -------------------------------------------------------------------
        // Validation
        // -------------------------------------------------------------------

        // verify sender auth
        _verifyChampionOwnership(champion);

        // verify Merkle proof that the champion is part of the Merkle tree
        _verifyMerkleProof(version, champion, shares, merkleProof);

        claimedTokenAmountList = new uint256[](tokenList.length);
        for (uint256 i = 0; i < tokenList.length; i++) {
            // compute claimable amount
            uint256 championClaimedTokens = claimedTokens[version][
                tokenList[i]
            ][champion];
            claimedTokenAmountList[i] = _computeClaimableTokenAmount(
                version,
                tokenList[i],
                shares,
                championClaimedTokens
            );

            // -------------------------------------------------------------------
            // State updates
            // -------------------------------------------------------------------

            // record total tokens claimed by the champion
            claimedTokens[version][tokenList[i]][champion] =
                championClaimedTokens +
                claimedTokenAmountList[i];
        }

        for (uint256 i = 0; i < tokenList.length; i++) {
            // -------------------------------------------------------------------
            // Effects
            // -------------------------------------------------------------------

            // transfer tokens to the recipient
            tokenList[i].safeTransfer(recipient, claimedTokenAmountList[i]);

            emit Claim(
                recipient,
                version,
                tokenList[i],
                champion,
                claimedTokenAmountList[i]
            );
        }
    }

    /// @notice If this Shrine is a Champion of another Shrine (MetaShrine), calling this can claim the tokens
    /// from the MetaShrine and distribute them to this Shrine's Champions. Callable by anyone.
    /// @param claimInfo The info of the claim
    /// @return claimedTokenAmount The amount of tokens claimed
    function claimFromMetaShrine(MetaShrineClaimInfo calldata claimInfo)
        external
        nonReentrant
        returns (uint256 claimedTokenAmount)
    {
        return _claimFromMetaShrine(claimInfo);
    }

    /// @notice A variant of {claimFromMetaShrine} that combines multiple claims into a single call.
    function claimMultipleFromMetaShrine(
        MetaShrineClaimInfo[] calldata claimInfoList
    ) external nonReentrant returns (uint256[] memory claimedTokenAmountList) {
        // claim and distribute tokens
        claimedTokenAmountList = new uint256[](claimInfoList.length);
        for (uint256 i = 0; i < claimInfoList.length; i++) {
            claimedTokenAmountList[i] = _claimFromMetaShrine(claimInfoList[i]);
        }
    }

    /// @notice Allows a champion to transfer their right to claim from this shrine to
    /// another address. The champion will effectively lose their shrine membership, so
    /// make sure the new owner is a trusted party.
    /// Only callable by the champion (if the right was never transferred) or the owner
    /// (that the original champion transferred their rights to)
    /// @param champion The champion whose claim rights will be transferred away
    /// @param newOwner The address that will receive all rights of the champion
    function transferChampionClaimRight(Champion champion, address newOwner)
        external
    {
        // -------------------------------------------------------------------
        // Validation
        // -------------------------------------------------------------------

        // verify sender auth
        _verifyChampionOwnership(champion);

        // -------------------------------------------------------------------
        // State updates
        // -------------------------------------------------------------------

        championClaimRightOwner[champion] = newOwner;
        emit TransferChampionStatus(champion, newOwner);
    }

    /// -----------------------------------------------------------------------
    /// Getters
    /// -----------------------------------------------------------------------

    /// @notice Computes the amount of a particular ERC-20 token claimable by a Champion from
    /// a particular version of the Merkle tree.
    /// @param version The Merkle tree version
    /// @param token The ERC-20 token to be claimed
    /// @param champion The Champion address
    /// @param shares The share amount of the Champion
    /// @return claimableTokenAmount The amount of tokens claimable
    function computeClaimableTokenAmount(
        Version version,
        ERC20 token,
        Champion champion,
        uint256 shares
    ) public view returns (uint256 claimableTokenAmount) {
        return
            _computeClaimableTokenAmount(
                version,
                token,
                shares,
                claimedTokens[version][token][champion]
            );
    }

    /// @notice The Shrine Guardian's address (same as the contract owner)
    /// @return The Guardian's address
    function guardian() external view returns (address) {
        return owner();
    }

    /// @notice The ledger at a particular version
    /// @param version The version of the ledger to query
    /// @return The ledger at the specified version
    function getLedgerOfVersion(Version version)
        external
        view
        returns (Ledger memory)
    {
        return ledgerOfVersion[version];
    }

    /// -----------------------------------------------------------------------
    /// Guardian actions
    /// -----------------------------------------------------------------------

    /// @notice The Guardian may call this function to update the ledger, so that the list of
    /// champions and the associated weights are updated.
    /// @param newLedger The new Merkle tree to use for the list of champions and their shares
    function updateLedger(Ledger calldata newLedger) external onlyOwner {
        // 0 total shares makes no sense
        if (newLedger.totalShares == 0) revert Shrine_LedgerZeroTotalShares();

        Version newVersion = Version.wrap(
            Version.unwrap(currentLedgerVersion) + 1
        );
        currentLedgerVersion = newVersion;
        ledgerOfVersion[newVersion] = newLedger;

        emit UpdateLedger(newVersion, newLedger);
    }

    /// @notice The Guardian may call this function to update the ledger metadata IPFS hash.
    /// @dev This function simply emits the IPFS hash in an event, so that an off-chain indexer
    /// can pick it up.
    /// @param newLedgerMetadataIPFSHash The IPFS hash of the updated metadata
    function updateLedgerMetadata(
        Version version,
        string calldata newLedgerMetadataIPFSHash
    ) external onlyOwner {
        emit UpdateLedgerMetadata(version, newLedgerMetadataIPFSHash);
    }

    /// -----------------------------------------------------------------------
    /// Internal utilities
    /// -----------------------------------------------------------------------

    /// @dev Reverts if the sender isn't the champion or does not own the champion claim right
    /// @param champion The champion whose ownership will be verified
    function _verifyChampionOwnership(Champion champion) internal view {
        {
            address _championClaimRightOwner = championClaimRightOwner[
                champion
            ];
            if (_championClaimRightOwner == address(0)) {
                // claim right not transferred, sender should be the champion
                if (msg.sender != Champion.unwrap(champion))
                    revert Shrine_NotAuthorized();
            } else {
                // claim right transferred, sender should be the owner
                if (msg.sender != _championClaimRightOwner)
                    revert Shrine_NotAuthorized();
            }
        }
    }

    /// @dev Reverts if the champion is not part of the Merkle tree
    /// @param version The Merkle tree version
    /// @param champion The Champion address. If the Champion rights have been transferred, the tokens will be sent to its owner.
    /// @param shares The share amount of the Champion
    /// @param merkleProof The Merkle proof showing the Champion is part of this Shrine's Merkle tree
    function _verifyMerkleProof(
        Version version,
        Champion champion,
        uint256 shares,
        bytes32[] calldata merkleProof
    ) internal view {
        if (
            !MerkleProof.verify(
                merkleProof,
                ledgerOfVersion[version].merkleRoot,
                keccak256(abi.encodePacked(champion, shares))
            )
        ) {
            revert Shrine_InvalidMerkleProof();
        }
    }

    /// @dev See {computeClaimableTokenAmount}
    function _computeClaimableTokenAmount(
        Version version,
        ERC20 token,
        uint256 shares,
        uint256 claimedTokenAmount
    ) internal view returns (uint256 claimableTokenAmount) {
        uint256 totalShares = ledgerOfVersion[version].totalShares;
        uint256 offeredTokenAmount = (offeredTokens[version][token] * shares) /
            totalShares;

        // rounding may cause (offeredTokenAmount < claimedTokenAmount)
        // don't want to revert because of it
        claimableTokenAmount = offeredTokenAmount >= claimedTokenAmount
            ? offeredTokenAmount - claimedTokenAmount
            : 0;
    }

    /// @dev See {claimFromMetaShrine}
    function _claimFromMetaShrine(MetaShrineClaimInfo calldata claimInfo)
        internal
        returns (uint256 claimedTokenAmount)
    {
        // -------------------------------------------------------------------
        // Effects
        // -------------------------------------------------------------------

        // claim tokens from the meta shrine
        uint256 beforeBalance = claimInfo.token.balanceOf(address(this));
        claimInfo.metaShrine.claim(
            address(this),
            ClaimInfo({
                version: claimInfo.version,
                token: claimInfo.token,
                champion: Champion.wrap(address(this)),
                shares: claimInfo.shares,
                merkleProof: claimInfo.merkleProof
            })
        );
        claimedTokenAmount =
            claimInfo.token.balanceOf(address(this)) -
            beforeBalance;

        // -------------------------------------------------------------------
        // State updates
        // -------------------------------------------------------------------

        // distribute tokens to Champions
        offeredTokens[currentLedgerVersion][
            claimInfo.token
        ] += claimedTokenAmount;

        emit Offer(
            address(claimInfo.metaShrine),
            claimInfo.token,
            claimedTokenAmount
        );
        emit ClaimFromMetaShrine(claimInfo.metaShrine);
    }
}
