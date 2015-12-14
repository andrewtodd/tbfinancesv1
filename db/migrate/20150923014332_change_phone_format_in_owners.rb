class ChangePhoneFormatInOwners < ActiveRecord::Migration
  def change
  	change_column :owners, :phone,  :text
  end
end
