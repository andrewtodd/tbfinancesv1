class InvoiceReportPdf < PdfReport
  TABLE_WIDTHS = [150, 240, 150]
  TABLE_HEADERS = ["generated", "description", "amount"]

  def initialize(invoice=[])
    super()
    @invoice = invoice

    header 'Invoice'
    display_invoice_table
    footer
  end

  private

  def display_invoice_table
    table @invoice, {
     :header => true,
     :column_widths => TABLE_WIDTHS,
     :row_colors => TABLE_ROW_COLORS,
     :cell_style => { size: 7 }} do |table|
      table.row(0).style(:background_color => 'dddddd', :size => 9, :align => :center, :font_style => :bold)
    end
  end

end