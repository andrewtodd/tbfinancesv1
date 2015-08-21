class InvoicesController < ApplicationController

	def index
		@invoices = Invoice.filter(params.slice(:invoice_type)).page(params[:page])
	
   if params[:search]
#      Rails.logger.debug("My object: #{params.inspect}")
      @invoices = Invoice.search(params[:search])
    end

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

  private
	def invoice_params
    	params.require(:invoice).permit(:tennant_id, :description, :amount, :created_at)
  	end
end
