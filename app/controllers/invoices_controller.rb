class InvoicesController < ApplicationController

  before_action :set_invoice, only: [:show, :edit, :update, :destroy]

  include InvoicesHelper

	def index
		@invoices = Invoice.filter(params.slice(:invoice_type)).page(params[:page])
	
   if params[:search]
#      Rails.logger.debug("My object: #{params.inspect}")
      @invoices = Invoice.search(params[:search])
    end

  end

  def generate
    invoice_count = generate_invoices

    redirect_to invoices_url, notice: "#{invoice_count} invoices created"
  end

	def show
    	@invoice = Invoice.find(params[:id])
  end

  def new
    @invoices = Invoice.new
  end

  def create
  	@invoice = Invoice.new(invoice_params)
 
  	@invoice.save
  	redirect_to @invoice
  end

  def destroy
    @invoice.destroy
    respond_to do |format|
      format.html { redirect_to invoices_url, notice: 'Invoice was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    def set_invoice
      @invoice = Invoice.find(params[:id])
    end
	
  def invoice_params
    	params.require(:invoice).permit(:tennant_id, :description, :amount, :created_at)
  end
end
