class AddInvoiceTypeToInvoices < ActiveRecord::Migration[6.1]
  def change
    add_column :invoices, :invoice_type, :string
  end
end
