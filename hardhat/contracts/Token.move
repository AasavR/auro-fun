
// Converted Token Contract from Solidity to Move for Supra Blockchain

module Token {

    resource struct TokenData {
        total_supply: u64,
        balances: map<address, u64>,
    }

    public fun initialize(owner: &signer, total_supply: u64) {
        let token = TokenData {
            total_supply: total_supply,
            balances: map::empty(),
        };
        map::insert(&mut token.balances, signer::address_of(owner), total_supply);
        move_to(owner, token);
    }

    public fun transfer(sender: &signer, recipient: address, amount: u64) {
        let token = borrow_global_mut<TokenData>(signer::address_of(sender));
        assert!(map::contains_key(&token.balances, signer::address_of(sender)), 1);
        assert!(map::get(&token.balances, signer::address_of(sender)) >= amount, 2);

        let sender_balance = map::get_mut(&mut token.balances, signer::address_of(sender));
        *sender_balance = *sender_balance - amount;

        if (!map::contains_key(&token.balances, recipient)) {
            map::insert(&mut token.balances, recipient, 0);
        }
        let recipient_balance = map::get_mut(&mut token.balances, recipient);
        *recipient_balance = *recipient_balance + amount;
    }

    public fun get_balance(account: address): u64 {
        if (exists<TokenData>(account)) {
            let token = borrow_global<TokenData>(account);
            return *map::get(&token.balances, account);
        } else {
            return 0;
        }
    }
}
