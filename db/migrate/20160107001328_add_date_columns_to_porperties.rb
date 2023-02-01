class AddDateColumnsToPorperties < ActiveRecord::Migration[6.1]
  def change
  	    add_column :properties, :start_date, :date
 		add_column :properties, :end_date, :date
  end
end
