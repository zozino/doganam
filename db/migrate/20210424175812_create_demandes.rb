class CreateDemandes < ActiveRecord::Migration[5.2]
  def change
    create_table :demandes do |t|
      t.integer :utilisateur_id
      t.integer :nombre_de_jour
      t.decimal :taux
      t.datetime :date_accepted
      t.datetime :date_disbursed
      t.datetime :date_repaid
      t.datetime :repayment_date
      t.integer :penalty_amount
      t.integer :total_amount_paid
      t.string :lender_phone
      t.boolean :is_anonymous
      t.integer :amount_borrowed
      t.integer :amount_to_repay
      t.integer :category_id
      t.string :phone
      t.string :status

      t.timestamps
    end
  end
end
