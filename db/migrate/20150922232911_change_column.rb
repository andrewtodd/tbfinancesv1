class ChangeColumn < ActiveRecord::Migration
  def change
  	change_column :tennants, :phone,  :text
  end
end
