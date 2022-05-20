// SPDX-License-Identifier: MIT

pragma solidity ^0.8.13;

import "../governance/NounsDAOExecutor.sol";

interface Administered {
  function _acceptAdmin() external returns (uint256);
}

contract NounsDAOExecutorHarness is NounsDAOExecutor {
  constructor(address admin_, uint256 delay_)
    NounsDAOExecutor(admin_, delay_)
  {}

  function harnessSetPendingAdmin(address pendingAdmin_) public {
    pendingAdmin = pendingAdmin_;
  }

  function harnessSetAdmin(address admin_) public {
    admin = admin_;
  }
}

contract NounsDAOExecutorTest is NounsDAOExecutor {
  constructor(address admin_, uint256 delay_) NounsDAOExecutor(admin_, 2 days) {
    delay = delay_;
  }

  function harnessSetAdmin(address admin_) public {
    require(msg.sender == admin);
    admin = admin_;
  }

  function harnessAcceptAdmin(Administered administered) public {
    administered._acceptAdmin();
  }
}
