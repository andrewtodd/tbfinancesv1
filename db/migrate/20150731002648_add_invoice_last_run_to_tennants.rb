class AddInvoiceLastRunToTennants < ActiveRecord::Migration[6.1]
  def change
    add_column :tennants, :invoice_last_run, :date
  end
end
