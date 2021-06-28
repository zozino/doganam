class CreateUtilisateurs < ActiveRecord::Migration[5.2]
  def change
    create_table :utilisateurs do |t|
      t.string :nom
      t.string :prenoms
      t.integer :age
      t.string :sexe
      t.string :quartier
      t.text :id_document_url
      t.text :photo_url
      t.string :password_digest
      t.string :phone
      t.string :pseudo
      t.string :status

      t.timestamps
    end
  end
end
