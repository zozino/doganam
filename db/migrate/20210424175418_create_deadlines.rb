class CreateDeadlines < ActiveRecord::Migration[5.2]
  def change
    create_table :deadlines do |t|
      t.integer :nombre_de_jour
      t.decimal :tax

      t.timestamps
    end
  end
end
