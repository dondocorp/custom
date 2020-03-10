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

    #Values retrieved
    @selected_product = (Product.where(sku: @input.product).first)
    @batch_size = @selected_product.batch_size
    @remaining_product = @input.quantity
    
    #Settings 
    @batches_per_day = 4
    

    #Calculations
    @days_required =  [1,@input.quantity/(@batches_per_day*@batch_size)].max
    @proposed = Date.current.advance(days: @days_required)
    @capable = @proposed < @input.delivery_date

    #Days Loop
    @days_list = Array.new
    @i = @input.quantity
    @day_counter = 1

    #Full schedule 
    @turns_list = Array.new

    while @i > 0  do
      
      #Calculate production date
      @temporal_date = @input.created_at.to_date + @day_counter

      #Day Hops. Sundays and soon holidays.
      if(@temporal_date.sunday?) then
        @temporal_date += 1
        @day_counter += 1
      end
      
      #Turns per day loop
      
      @turno = 1
      while (@turno<(@batches_per_day+1) and @remaining_product > 0) do
      
      #Booking Turn creation
      @temporal_text = "El día " + l(@temporal_date, format: '%B %d') + " en el turno " + @turno.to_s + " habrá que producir " + @batch_size.to_s + " " + @selected_product.unit_type
      #@turns_list.push([@temporal_date,@turno, @input.product])
      @turns_list.push(@temporal_date.to_s+";"+@turno.to_s+";"+@input.product.to_s)

      #Booking Turn saving
      @days_list.push(@temporal_text)
      
      #Turns per day Advancement
      @turno +=1
      @remaining_product -= @batch_size

      end

      #Day Advancement 
      @i -= @batch_size*@batches_per_day
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
