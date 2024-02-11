// SPDX-License-Identifier: MIT

pragma solidity ^0.8.17;

contract Orders{
    
    enum Order{
        NOT_DELIVERED,
        DELIVERED,
        CANCELLED
    }

    Order public order;

    function deliverOrder() public {
        order = Order.DELIVERED;
    }

    function delayOrder() public {
        order = Order.NOT_DELIVERED;
    }

    function cancleOrder() public {
        order = Order.CANCELLED;
    }

    function orderStatus() public view returns(string memory){
        if(order == Order.NOT_DELIVERED) return "Order is not delivered";
        else if(order == Order.DELIVERED) return "Order is delivered";
        else return "Order is cancelled";
    }
}