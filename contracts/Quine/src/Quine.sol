/**
 *Submitted for verification at Etherscan.io on 2021-07-31
 */

/*
https://twitter.com/boredGenius/status/1421643447572647937?s=20&t=SdQIFhhrLxYxoU4LJ-tEPg
1. Write most of the non-quine code (NFT stuff)
2. Reference the code in step 1 as a string
3. Write code that does the output, as a string.
4. Copy the code in step 3 and output everything
 */

/* @author zefram.eth */
pragma solidity 0.8.13;

interface IR {
  function onERC721Received(
    address op,
    address fr,
    uint256 id,
    bytes calldata dt
  ) external returns (bytes4);
}

contract Quine {
  event Transfer(address indexed fr, address indexed to, uint256 indexed id);
  event Approval(address indexed ow, address indexed ad, uint256 indexed id);
  event ApprovalForAll(address indexed ow, address indexed op, bool ad);
  string public constant name = "Quine NFT";
  string public constant symbol = "QUINE";
  mapping(uint256 => address) private _os;
  mapping(address => uint256) private _bs;
  mapping(uint256 => address) private _ta;
  mapping(address => mapping(address => bool)) private _oa;

  constructor() {
    _sm(msg.sender, 1);
  }

  function supportsInterface(bytes4 ii) public pure returns (bool) {
    return ii == 0x80ac58cd || ii == 0x5b5e139f || ii == 0x01ffc9a7;
  }

  function balanceOf(address ow) public view returns (uint256) {
    require(ow != address(0));
    return _bs[ow];
  }

  function ownerOf(uint256 id) public view returns (address) {
    address ow = _os[id];
    require(ow != address(0));
    return ow;
  }

  function approve(address to, uint256 id) public {
    address ow = ownerOf(id);
    require(to != ow);
    require(msg.sender == ow || isApprovedForAll(ow, msg.sender));
    _ap(to, id);
  }

  function getApproved(uint256 id) public view returns (address) {
    require(_ex(id));
    return _ta[id];
  }

  function setApprovalForAll(address op, bool ad) public {
    require(op != msg.sender);
    _oa[msg.sender][op] = ad;
    emit ApprovalForAll(msg.sender, op, ad);
  }

  function isApprovedForAll(address ow, address op) public view returns (bool) {
    return _oa[ow][op];
  }

  function transferFrom(
    address fr,
    address to,
    uint256 id
  ) public {
    require(_ao(msg.sender, id));
    _tr(fr, to, id);
  }

  function safeTransferFrom(
    address fr,
    address to,
    uint256 id
  ) public {
    safeTransferFrom(fr, to, id, "");
  }

  function safeTransferFrom(
    address fr,
    address to,
    uint256 id,
    bytes memory _dt
  ) public {
    require(_ao(msg.sender, id));
    _st(fr, to, id, _dt);
  }

  function _st(
    address fr,
    address to,
    uint256 id,
    bytes memory _dt
  ) internal {
    _tr(fr, to, id);
    require(_cr(fr, to, id, _dt));
  }

  function _ex(uint256 id) internal view returns (bool) {
    return _os[id] != address(0);
  }

  function _ao(address sp, uint256 id) internal view returns (bool) {
    require(_ex(id));
    address ow = ownerOf(id);
    return (sp == ow || getApproved(id) == sp || isApprovedForAll(ow, sp));
  }

  function _sm(address to, uint256 id) internal {
    require(to != address(0));
    require(!_ex(id));
    _bs[to] += 1;
    _os[id] = to;
    emit Transfer(address(0), to, id);
    require(_cr(address(0), to, id, ""));
  }

  function _tr(
    address fr,
    address to,
    uint256 id
  ) internal {
    require(ownerOf(id) == fr);
    require(to != address(0));
    _ap(address(0), id);
    _bs[fr] -= 1;
    _bs[to] += 1;
    _os[id] = to;
    emit Transfer(fr, to, id);
  }

  function _ap(address to, uint256 id) internal {
    _ta[id] = to;
    emit Approval(ownerOf(id), to, id);
  }

  function _cr(
    address fr,
    address to,
    uint256 id,
    bytes memory _dt
  ) private returns (bool) {
    uint256 sz;
    assembly {
      sz := extcodesize(to)
    }
    if (sz > 0) {
      try IR(to).onERC721Received(msg.sender, fr, id, _dt) returns (bytes4 rv) {
        return rv == IR.onERC721Received.selector;
      } catch (bytes memory rs) {
        if (rs.length == 0) {
          revert();
        } else {
          assembly {
            revert(add(32, rs), mload(rs))
          }
        }
      }
    } else {
      return true;
    }
  }

  function tokenURI(uint256 id) public view returns (string memory s) {
    require(_ex(id));
    bytes memory pr = "data:text/plain;charset=utf-8,";
    s = '/* @author zefram.eth */ pragma solidity 0.8.6; interface IR { function onERC721Received(address op, address fr, uint256 id, bytes calldata dt) external returns (bytes4); } contract Quine { event Transfer(address indexed fr, address indexed to, uint256 indexed id); event Approval(address indexed ow, address indexed ad, uint256 indexed id); event ApprovalForAll(address indexed ow, address indexed op, bool ad); string public constant name = "Quine NFT"; string public constant symbol = "QUINE"; mapping(uint256 => address) private _os; mapping(address => uint256) private _bs; mapping(uint256 => address) private _ta; mapping(address => mapping(address => bool)) private _oa; constructor() { _sm(msg.sender, 1); } function supportsInterface(bytes4 ii) public pure returns (bool) { return ii == 0x80ac58cd || ii == 0x5b5e139f || ii == 0x01ffc9a7; } function balanceOf(address ow) public view returns (uint256) { require(ow != address(0)); return _bs[ow]; } function ownerOf(uint256 id) public view returns (address) { address ow = _os[id]; require(ow != address(0)); return ow; } function approve(address to, uint256 id) public { address ow = ownerOf(id); require(to != ow); require(msg.sender == ow || isApprovedForAll(ow, msg.sender)); _ap(to, id); } function getApproved(uint256 id) public view returns (address) { require(_ex(id)); return _ta[id]; } function setApprovalForAll(address op, bool ad) public { require(op != msg.sender); _oa[msg.sender][op] = ad; emit ApprovalForAll(msg.sender, op, ad); } function isApprovedForAll(address ow, address op) public view returns (bool) { return _oa[ow][op]; } function transferFrom(address fr,address to,uint256 id) public { require(_ao(msg.sender, id)); _tr(fr, to, id); } function safeTransferFrom(address fr,address to,uint256 id) public { safeTransferFrom(fr, to, id, ""); } function safeTransferFrom(address fr,address to,uint256 id,bytes memory _dt) public { require(_ao(msg.sender, id)); _st(fr, to, id, _dt); } function _st(address fr,address to,uint256 id,bytes memory _dt) internal { _tr(fr, to, id); require(_cr(fr, to, id, _dt)); } function _ex(uint256 id) internal view returns (bool) { return _os[id] != address(0); } function _ao(address sp, uint256 id) internal view returns (bool) { require(_ex(id)); address ow = ownerOf(id); return (sp == ow || getApproved(id) == sp || isApprovedForAll(ow, sp)); } function _sm(address to, uint256 id) internal { require(to != address(0)); require(!_ex(id)); _bs[to] += 1; _os[id] = to; emit Transfer(address(0), to, id); require(_cr(address(0), to, id, "")); } function _tr(address fr,address to,uint256 id) internal { require(ownerOf(id) == fr); require(to != address(0)); _ap(address(0), id); _bs[fr] -= 1; _bs[to] += 1; _os[id] = to; emit Transfer(fr, to, id); } function _ap(address to, uint256 id) internal { _ta[id] = to; emit Approval(ownerOf(id), to, id); } function _cr(address fr,address to,uint256 id,bytes memory _dt) private returns (bool) { uint256 sz; assembly { sz := extcodesize(to) } if (sz > 0) { try IR(to).onERC721Received(msg.sender, fr, id, _dt) returns (bytes4 rv) { return rv == IR.onERC721Received.selector; } catch (bytes memory rs) { if (rs.length == 0) { revert(); } else { assembly { revert(add(32, rs), mload(rs)) } } } } else { return true; } } function tokenURI(uint256 id) public view returns (string memory s) { require(_ex(id)); bytes memory pr = "data:text/plain;charset=utf-8,";';
    string
      memory t0 = "73203d20737472696e67286162692e656e636f64655061636b65642870722c20732c20225c6e73203d2027222c20732c2022273b5c6e737472696e67206d656d6f7279207430203d205c22222c2074302c20225c223b5c6e6279746573206d656d6f7279207431203d206865785c22222c2074302c20225c223b5c6e222c20743129293b7d7d";
    bytes
      memory t1 = hex"73203d20737472696e67286162692e656e636f64655061636b65642870722c20732c20225c6e73203d2027222c20732c2022273b5c6e737472696e67206d656d6f7279207430203d205c22222c2074302c20225c223b5c6e6279746573206d656d6f7279207431203d206865785c22222c2074302c20225c223b5c6e222c20743129293b7d7d";
    s = string(
      abi.encodePacked(
        pr,
        s,
        "\ns = '",
        s,
        "';\nstring memory t0 = \"",
        t0,
        '";\nbytes memory t1 = hex"',
        t0,
        '";\n',
        t1
      )
    );
  }
}
