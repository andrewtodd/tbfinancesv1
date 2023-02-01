class AddStartDateToTennants < ActiveRecord::Migration[6.1]
  def change
    add_column :tennants, :start_date, :date
    add_column :tennants, :end_date, :date
  end
end
