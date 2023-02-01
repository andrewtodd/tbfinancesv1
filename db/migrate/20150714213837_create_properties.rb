class CreateProperties < ActiveRecord::Migration[6.1]
  def change
    create_table :properties do |t|
      t.string :address_line1
      t.string :address_line2
      t.string :city
      t.string :country
      t.string :postal_code

      t.timestamps null: false
    end
  end
end
