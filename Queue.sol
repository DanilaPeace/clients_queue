
pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;

contract Queue {
    string[] public m_queue;

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
        m_queue.push(name);
    }

    function removeClientFromFront() public checkOwner{
        // If the m_queue is empty an error 110 is throwт
        require(!m_queue.empty(), 110);

        for(uint i = 0; i < m_queue.length - 1; i++) {
            m_queue[i] = m_queue[i + 1];
        }
        m_queue.pop();
    }
}
