class CreateQuartiers < ActiveRecord::Migration[5.2]
  def change
    create_table :quartiers do |t|
      t.string :nom

      t.timestamps
    end
  end
end
