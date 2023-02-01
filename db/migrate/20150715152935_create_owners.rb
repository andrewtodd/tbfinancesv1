class CreateOwners < ActiveRecord::Migration[6.1]
  def change
    create_table :owners do |t|
      t.string :first_name
      t.string :last_name
      t.integer :phone
      t.string :email

      t.timestamps null: false
    end
  end
end
