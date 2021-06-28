class CreateOtps < ActiveRecord::Migration[5.2]
  def change
    create_table :otps do |t|
      t.string :num_phone
      t.string :code

      t.timestamps
      
    end
  end
end
