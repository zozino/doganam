class AddFieldsToTransactions < ActiveRecord::Migration[5.2]
  def change
    add_column :transactions, :taux_entree, :decimal
    add_column :transactions, :taux_sortie, :decimal
    add_column :transactions, :taux_preteur, :decimal
  end
end
