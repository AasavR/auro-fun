
// Converted Lock Contract from Solidity to Move for Supra Blockchain

module Lock {

    resource struct LockData {
        unlock_time: u64,
        amount: u64,
    }

    public fun lock_tokens(owner: &signer, amount: u64, unlock_time: u64) {
        assert!(unlock_time > timestamp::now_seconds(), 1);
        let lock = LockData {
            unlock_time: unlock_time,
            amount: amount,
        };
        move_to(owner, lock);
    }

    public fun unlock_tokens(owner: &signer) {
        let lock = borrow_global_mut<LockData>(signer::address_of(owner));
        assert!(timestamp::now_seconds() >= lock.unlock_time, 2);
        destroy_global<LockData>(signer::address_of(owner));
    }
}
