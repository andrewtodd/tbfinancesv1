class ChangePhoneFormatInOwners < ActiveRecord::Migration[6.1]
  def change
  	change_column :owners, :phone,  :text
  end
end
