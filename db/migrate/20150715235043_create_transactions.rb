class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.string :generated_by
      t.decimal :amount
      t.string :transaction_type
      t.date :date
      t.integer :tennant_id
      t.string :name
      t.string :category
      t.integer :owner_id

      t.timestamps null: false
    end
  end
end
