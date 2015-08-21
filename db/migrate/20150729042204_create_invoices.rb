class CreateInvoices < ActiveRecord::Migration
  def change
    create_table :invoices do |t|
      t.integer :tennant_id
      t.string :description
      t.decimal :amount, precision: 10, scale: 2

      t.timestamps null: false
    end
  end
end
