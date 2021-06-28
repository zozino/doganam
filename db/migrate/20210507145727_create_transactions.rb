class CreateTransactions < ActiveRecord::Migration[5.2]
  def change
    create_table :transactions do |t|
      t.integer :demande_id
      t.timestamp :date_sent
      t.timestamp :date_received
      t.string :sender_phone
      t.string :receiver_phone
      t.integer :amount
      t.string :tx_reference
      t.string :payment_reference
      t.boolean :is_envoi

      t.timestamps
    end
  end
end
