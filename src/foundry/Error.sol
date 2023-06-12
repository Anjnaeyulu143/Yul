// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;



contract Error {
    error notAuthorized();

    // for events we use emit keyword ;
    // Error is used when we reverting the call;

    function throwError() pure external {
        require(false,"error");
    }

    function throwCustomError() pure external {
        revert notAuthorized();
    }

    

}