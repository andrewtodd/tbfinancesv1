class AddmonthlyChargeToProperties < ActiveRecord::Migration
  def change
  	add_column :properties, :monthly_charge, :decimal, precision: 10, scale: 2
  end
end
