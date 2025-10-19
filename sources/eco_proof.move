module eco_proof::eco_proof {
    // Módulo mínimo para permitir compilação/publcação inicial.
    // Contém apenas uma struct simples e uma entry function que cria um objeto
    // e o transfere para o remetente. Depois podemos estender.

    use sui::object;
    use sui::tx_context;
    use sui::transfer;

    // Um recurso simples que será criado e transferido ao sender
    public struct SimpleItem has key, store {
        id: object::UID,
        // owner será implicitamente o address dono do objeto (não armazenamos)
        value: u64,
    }

    // Entry que cria um SimpleItem e transfere para o sender
    public entry fun mint_simple(value: u64, ctx: &mut tx_context::TxContext) {
        let creator = tx_context::sender(ctx);
        let item = SimpleItem { id: object::new(ctx), value };
        // Transferimos o objeto para o próprio creator (owner)
        transfer::public_transfer(item, creator);
    }
}
