class ChangeNumericFieldInTransactions < ActiveRecord::Migration[6.1]
  def change
  	change_column :transactions, :amount, :decimal, :precision => 10, :scale => 2, :default => 0.00
  end
end
