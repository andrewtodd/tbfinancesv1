class AddTransactionDescriptionToTennants < ActiveRecord::Migration[6.1]
  def change
    add_column :tennants, :start_day, :string
  end
end
