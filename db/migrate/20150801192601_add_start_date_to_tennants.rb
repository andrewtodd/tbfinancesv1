class AddStartDateToTennants < ActiveRecord::Migration
  def change
    add_column :tennants, :start_date, :date
    add_column :tennants, :end_date, :date
  end
end
