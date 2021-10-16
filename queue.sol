
pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;

contract queue {
    string[] public queue;

    constructor() public{
        require(tvm.pubkey() != 0, 101);
        require(msg.pubkey() == tvm.pubkey(), 102);
        tvm.accept();
    }

    modifier modifyQueue {
        require(msg.pubkey() == tvm.pubkey(), 102);
        tvm.accept();
        _;
    }

    function pushClient(string name) public modifyQueue{
        queue.push(name);
    }

    function shiftClient() public modifyQueue{
        // If the queue is empty
        require(!queue.empty(), 110);

        for(uint i = 0; i < queue.length - 1; i++) {
            queue[i] = queue[i + 1];
        }
        queue.pop();
    }
}
