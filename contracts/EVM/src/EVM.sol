// SPDX-License-Identifier: MIT

pragma solidity ^0.8.13;

contract EVM {
  // 01: ADD
  function add(uint256 a, uint256 b) public pure returns (uint256 result) {
    assembly {
      result := add(a, b)
    }
  }

  // 02: MUL
  function mul(uint256 a, uint256 b) public pure returns (uint256 result) {
    assembly {
      result := mul(a, b)
    }
  }

  // 03: SUB
  function sub(uint256 a, uint256 b) public pure returns (uint256 result) {
    assembly {
      result := sub(a, b)
    }
  }

  // 04: DIV
  function div(uint256 a, uint256 b) public pure returns (uint256 result) {
    assembly {
      result := div(a, b)
    }
  }

  // 05: SDIV
  function sdiv(uint256 a, uint256 b) public pure returns (uint256 result) {
    assembly {
      result := sdiv(a, b)
    }
  }

  // 06: MOD
  function mod(uint256 a, uint256 b) public pure returns (uint256 result) {
    assembly {
      result := mod(a, b)
    }
  }

  // 07: SMOD
  function smod(uint256 a, uint256 b) public pure returns (uint256 result) {
    assembly {
      result := smod(a, b)
    }
  }

  // 08: ADDMOD
  function addMod(
    uint256 a,
    uint256 b,
    uint256 n
  ) public pure returns (uint256 result) {
    assembly {
      result := addmod(a, b, n)
    }
  }

  // 09: MULMOD
  function mulMod(
    uint256 a,
    uint256 b,
    uint256 n
  ) public pure returns (uint256 result) {
    assembly {
      result := mulmod(a, b, n)
    }
  }

  // 0A: EXP
  function exp(uint256 a, uint256 exponent)
    public
    pure
    returns (uint256 result)
  {
    assembly {
      result := exp(a, exponent)
    }
  }

  // 0B: SIGNEXTEND
  function signExtend(uint256 b, uint256 x)
    public
    pure
    returns (uint256 result)
  {
    assembly {
      result := signextend(b, x)
    }
  }

  // 10: LT
  function lt(uint256 a, uint256 b) public pure returns (uint256 result) {
    assembly {
      result := lt(a, b)
    }
  }

  // 11: GT
  function gt(uint256 a, uint256 b) public pure returns (uint256 result) {
    assembly {
      result := gt(a, b)
    }
  }

  // 12: LT
  function slt(uint256 a, uint256 b) public pure returns (uint256 result) {
    assembly {
      result := slt(a, b)
    }
  }

  // 13: GT
  function sgt(uint256 a, uint256 b) public pure returns (uint256 result) {
    assembly {
      result := sgt(a, b)
    }
  }
}
