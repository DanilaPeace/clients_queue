
pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;

contract Queue {
    string[] public queue;

    constructor() public{
        require(tvm.pubkey() != 0, 101);
        require(msg.pubkey() == tvm.pubkey(), 102);
        tvm.accept();
    }

    modifier checkOwner {
        require(msg.pubkey() == tvm.pubkey(), 102);
        tvm.accept();
        _;
    }

    function pushClientToEnd(string name) public checkOwner{
        queue.push(name);
    }

    function removeClientFromFront() public checkOwner{
        // If the queue is empty an error 110 is throwт
        require(!queue.empty(), 110);

        for(uint i = 0; i < queue.length - 1; i++) {
            queue[i] = queue[i + 1];
        }
        queue.pop();
    }
}
