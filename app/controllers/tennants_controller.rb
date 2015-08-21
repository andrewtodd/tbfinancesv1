class TennantsController < ApplicationController
  before_action :set_tennant, only: [:show, :edit, :update, :destroy]

  # GET /tennants
  # GET /tennants.json
  def index
    @tennants = Tennant.all
  end

  # GET /tennants/1
  # GET /tennants/1.json
  def show
  end

  # GET /tennants/new
  def new
    @tennant = Tennant.new
  end

  # GET /tennants/1/edit
  def edit
  end

  # POST /tennants
  # POST /tennants.json
  def create
    @tennant = Tennant.new(tennant_params)

    respond_to do |format|
      if @tennant.save
        format.html { redirect_to @tennant, notice: 'Tennant was successfully created.' }
        format.json { render :show, status: :created, location: @tennant }
      else
        format.html { render :new }
        format.json { render json: @tennant.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tennants/1
  # PATCH/PUT /tennants/1.json
  def update
    respond_to do |format|
      if @tennant.update(tennant_params)
        format.html { redirect_to @tennant, notice: 'Tennant was successfully updated.' }
        format.json { render :show, status: :ok, location: @tennant }
      else
        format.html { render :edit }
        format.json { render json: @tennant.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tennants/1
  # DELETE /tennants/1.json
  def destroy
    @tennant.destroy
    respond_to do |format|
      format.html { redirect_to tennants_url, notice: 'Tennant was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tennant
      @tennant = Tennant.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tennant_params
      params.require(:tennant).permit(:first_name, :last_name, :property_id, :email, :phone, :notes, :transaction_description)
    end
end
