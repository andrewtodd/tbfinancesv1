class AddTransactionDescriptionToTennants < ActiveRecord::Migration
  def change
    add_column :tennants, :start_day, :string
  end
end
