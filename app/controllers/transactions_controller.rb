class TransactionsController < ApplicationController
  before_action :set_transaction, only: [:show, :edit, :update, :destroy]
  before_action :set_dropdowns, only: [:show, :edit, :index]

  include TransactionsHelper

  # GET /transactions
  # GET /transactions.json
  def index
    @transactions = Transaction.filter(params.slice(:category, :transaction_type, :owner)).page(params[:page]).order("date DESC")


    # We use the filter and slice functions here)

    ## FILTER
    # Filter is a function of the Filterable module.
    # filter accepts a key value pairs from the URL parameters. 
    #  - The key should be the name of one of your scopes (which are like methods
    #  which are defined in the model)
    #  - the value will be the value you want to send as a parameter to the scope

    # If we only wanted to filter by a single attribute (eg 'category') we could do this:
    #   @transactions = @transactions.category(params[:category]) if params[:category].present?
    # If you did it that way and we wanted to allow more than 1 filter we could end
    # up with several lines (1 for each filter scope)

    # Filter allows us to pass in several params at once with a single line (see above)

    ## SLICE
    # slice limits the keys (in params) sent to the filter method to only the keys passed to it
    #  eg. In this case (at the time of writing) where only giving slice ':category' and ':transaction_type'
    #     - therefore it's the same as using Transaction.filter(params{category}, params{transaction_type} (assuming params has both keys)
    # Although slice is not essential to make filter work, filter will break if we 
    # send it a parameter that that we do not have a scope for and therefore slice
    # should always be used.

    if params[:search]
      @transactions = Transaction.search(params[:search]).page(params[:page])
    end

    # The app uses tennant collection as a hash to populate the tennant select dropdown for each transaction
    @tennant_collection = Hash.new()
    
    @tennants = Tennant.all
    @tennants.each do |tennant|
      @tennant_collection[tennant.id] = tennant.first_name+" "+tennant.last_name
    end

  end

  # GET /transactions/1
  # GET /transactions/1.json
  def show
  end

  # GET /transactions/new
  def new
    @transaction = Transaction.new
  end

  # GET /transactions/1/edit
  def edit
  end

  # POST /transactions
  # POST /transactions.json
  def create
    @transaction = Transaction.new(transaction_params)

    respond_to do |format|
      if @transaction.save
        format.html { redirect_to @transaction, notice: 'Transaction was successfully created.' }
        format.json { render :show, status: :created, location: @transaction }
      else
        format.html { render :new }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end


  def update
    respond_to do |format|
      if @transaction.update(transaction_params)
        format.html { redirect_to @transaction, notice: 'Transaction was successfully updated.' }
        format.json { respond_with_bip(@transaction) } # needed to add this so that currency would be displayed properly after bip edit
      else
        format.html { render :edit }
        format.json { respond_with_bip(@transaction) } # needed to add this so that currency would be displayed properly after bip edit
      end
    end
  end

  

  # DELETE /transactions/1
  # DELETE /transactions/1.json
  def destroy
    @transaction.destroy
    respond_to do |format|
      format.html { redirect_to transactions_url, notice: 'Transaction was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

require 'csv'

def import
  transactions_imported,row_count = import_file(params[:file])

  if transactions_imported == row_count
    redirect_to transactions_url, notice: "Success! All Products Imported."
  elsif transactions_imported > 0
    redirect_to transactions_url, notice: "Warning! Only #{transactions_imported} out of #{row_count} transactions were imported."
  else
    redirect_to transactions_url, notice: "Error: All #{row_count} transactions failed"
  end
end



  private
    # Use callbacks to share common setup or constraints between actions.
    def set_transaction
      @transaction = Transaction.find(params[:id])
    end

    def set_dropdowns
      @categories = Transaction.categories
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def transaction_params
      params.require(:transaction).permit(:generated_by, :amount, :transaction_type, :date, :tennant_id, :name, :category, :owner_id)
    end


end
