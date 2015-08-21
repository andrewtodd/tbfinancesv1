class AddInvoiceLastRunToTennants < ActiveRecord::Migration
  def change
    add_column :tennants, :invoice_last_run, :date
  end
end
