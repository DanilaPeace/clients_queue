
pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;

contract queue {
    string[] queue;

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

    function showQueue() public view returns(string[]) {
        return queue;
    }
}
