
// Converted TokenFactory Contract from Solidity to Move for Supra Blockchain

module TokenFactory {

    resource struct FactoryData {
        created_tokens: vector<address>,
    }

    public fun initialize_factory(owner: &signer) {
        let factory = FactoryData {
            created_tokens: vector::empty(),
        };
        move_to(owner, factory);
    }

    public fun create_token(owner: &signer, total_supply: u64): address {
        let new_token = Token::initialize(owner, total_supply);
        let factory = borrow_global_mut<FactoryData>(signer::address_of(owner));
        vector::push_back(&mut factory.created_tokens, new_token);
        return new_token;
    }

    public fun get_created_tokens(owner: address): vector<address> {
        let factory = borrow_global<FactoryData>(owner);
        return factory.created_tokens;
    }
}
