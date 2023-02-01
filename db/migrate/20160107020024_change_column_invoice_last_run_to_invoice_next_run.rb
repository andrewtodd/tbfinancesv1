class ChangeColumnInvoiceLastRunToInvoiceNextRun < ActiveRecord::Migration[6.1]
  def change
    rename_column :tennants, :invoice_last_run, :invoice_next_run
  end
end
