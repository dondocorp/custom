class InputsController < ApplicationController
  before_action :set_input, only: [:show, :edit, :update, :destroy]

  # GET /inputs
  # GET /inputs.json
  def index
    @inputs = Input.all
  end

  # GET /inputs/1
  # GET /inputs/1.json
  def show
    @selected_product = (Product.where(sku: @input.product).first)
    @batch_size = @selected_product.batch_size
    @days_required = @input.quantity/@batch_size
    
    @proposed = Date.current + @days_required
    @capable = @proposed < @input.delivery_date

    @days_list = Array.new

    @i = @input.quantity
    @day_counter = 1
    
    while @i > 0  do
      @day_quantity = [@i,@batch_size].min
    
      @temporal_date = @input.created_at.to_date + @day_counter
      if(@temporal_date.sunday?) then
        @temporal_date += 1
        @day_counter += 1
      end
      @temporal_text = "El día "+ l(@temporal_date, format: '%B %d') +" habrá que producir "+@day_quantity.to_s+" "+@selected_product.unit_type
      @days_list.push(@temporal_text)
      @i -= @batch_size
      @day_counter += 1
    end


    # Date.current + @input.quantity
    #+ (/(Product.where(:sku @input.product).batch_siz)).days < @input.delivery_date 
  end

  # GET /inputs/new
  def new
    @input = Input.new
    @product_list = Product.all
  end

  # GET /inputs/1/edit
  def edit
    @product_list = Product.all
  end

  # POST /inputs
  # POST /inputs.json
  def create
    @input = Input.new(input_params)
    #@input.created_at = Date.current
    @batch_size = (Product.where(sku: @input.product).first).batch_size
    @days_required = @input.quantity/@batch_size
    @capable = Date.current + @days_required < @input.delivery_date

    
    
    respond_to do |format|
    if @capable
    
      if @input.save
        format.html { redirect_to @input, notice: 'Input was successfully created.' }
        format.json { render :show, status: :created, location: @input }
      else
        format.html { render :new }
        format.json { render json: @input.errors, status: :unprocessable_entity }
      end
    else
  
     format.html { redirect_to @input, notice: 'No Capability' }
        format.json { render :show, status: :unprocessable_entity, location: @input }
      end
   end 
  end

  # PATCH/PUT /inputs/1
  # PATCH/PUT /inputs/1.json
  def update
    respond_to do |format|
      if @input.update(input_params)
        format.html { redirect_to @input, notice: 'Input was successfully updated.' }
        format.json { render :show, status: :ok, location: @input }
      else
        format.html { render :edit }
        format.json { render json: @input.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /inputs/1
  # DELETE /inputs/1.json
  def destroy
    @input.destroy
    respond_to do |format|
      format.html { redirect_to inputs_url, notice: 'Input was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_input
      @input = Input.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def input_params
      params.require(:input).permit(:product, :quantity, :delivery_date, :observations)
    end
end
