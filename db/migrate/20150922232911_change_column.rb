class ChangeColumn < ActiveRecord::Migration[6.1]
  def change
  	change_column :tennants, :phone,  :text
  end
end
