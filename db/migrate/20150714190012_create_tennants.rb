class CreateTennants < ActiveRecord::Migration[6.1]
  def change
    create_table :tennants do |t|
      t.string :first_name
      t.string :last_name
      t.integer :property_id
      t.string :email
      t.integer :phone
      t.string :notes

      t.timestamps null: false
    end
  end
end
