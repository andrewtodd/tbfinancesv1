class AddTransactionDescriptionToTennants < ActiveRecord::Migration
  def change
    add_column :tennants, :transaction_description, :string
  end
end
