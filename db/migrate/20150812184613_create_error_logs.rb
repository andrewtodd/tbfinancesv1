class CreateErrorLogs < ActiveRecord::Migration[6.1]
  def change
    create_table :error_logs do |t|
      t.date :date
      t.text :transaction_name
      t.string :error
      t.string :file_name
      t.integer :file_row

      t.timestamps null: false
    end
  end
end
